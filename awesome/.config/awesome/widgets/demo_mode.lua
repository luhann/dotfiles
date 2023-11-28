-------------------------------------------------
-- DemoMode button for Awesome Window Manager
-- Turns off notifications and send a heartbeat to xscreensaver

-- @author Raphaël Fournier-S'niehotta
-- @copyright 2018 Raphaël Fournier-S'niehotta
-------------------------------------------------

local wibox = require("wibox")
local watch = require("awful.widget.watch")
local awful = require("awful")
local beautiful = require("beautiful")
local naughty       = require("naughty")
local gears = require("gears")

local xresources = require("beautiful.xresources")
local xrdb = xresources.get_current_theme()
local dpi = xresources.apply_dpi

local XSCREENSAVER_DEACTIVATE_COMMAND = "xscreensaver-command -deactivate"
local XSCREENSAVER_TIMER = 61

local demo_mode = wibox.widget {
  forced_height = dpi(15),
  forced_width = dpi(15),
  resize = true,
  image  = beautiful.demomode_icon or iconpath,
  widget = wibox.widget.imagebox
}

watch(XSCREENSAVER_DEACTIVATE_COMMAND, XSCREENSAVER_TIMER, demo_mode)

function blockXscreensaver()
  gears.timer {
    timeout   = XSCREENSAVER_TIMER,
    autostart = true,
    callback  = function()
        awful.util.spawn_with_shell(XSCREENSAVER_DEACTIVATE_COMMAND)
        --naughty.notify{ 
         --title= "Notification status",
         --text = tostring(not naughty.is_suspended()),
         --ignore_suspend = true,
       --}
      end,
    single_shot = false,
}
end

demo_mode:buttons(awful.util.table.join(
                       awful.button({ }, 1, function () 
                         naughty.toggle()
                         if naughty.is_suspended() then
                           blockXscreensaver()
                           demo_mode.demomode_icon =  beautiful.demomode_suspend_icon
                         else
                           demo_mode.demomode_icon =  beautiful.demomode_norm_icon
                         end
                         naughty.notify{ 
                           title= "Notification status",
                           text = tostring(not naughty.is_suspended()),
                           ignore_suspend = true,
                         }
                     end)
                       ))


return demo_mode
