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

local demo_mode = wibox.widget {
  forced_height = dpi(15),
  forced_width = dpi(15),
  resize = true,
  image  = beautiful.demomode_icon or iconpath,
  widget = wibox.widget.imagebox
}

function notification_message()
  if naughty.is_suspended() then
    return tostring("Notification Paused")
  else
    return tostring("Notification Resumed")
  end
end

demo_mode:buttons(awful.util.table.join(
                       awful.button({ }, 1, function () 
                         naughty.toggle()
                         if naughty.is_suspended() then
                           demo_mode:set_image(gears.surface.load_uncached(beautiful.demomode_suspend_icon))
                         else
                           demo_mode:set_image(gears.surface.load_uncached(beautiful.demomode_norm_icon))
                         end
                         naughty.notify({ 
                           title= notification_message(),
                           height = dpi(25),
                           ignore_suspend = true,
                         })
                     end)
                       ))


return demo_mode
