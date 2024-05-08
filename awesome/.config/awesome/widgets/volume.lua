local gears = require("gears")
local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")

local xresources = require("beautiful.xresources")
local xrdb = xresources.get_current_theme()
local dpi = xresources.apply_dpi

-- Create a volume widget
local volume = wibox.widget {
  widget = wibox.widget.textbox,
  buttons = gears.table.join(
      awful.button({ }, 1, function() awful.spawn("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle") awesome.emit_signal("volume_change") end),
      awful.button({ }, 4, function() awful.spawn("wpctl set-volume @DEFAULT_AUDIO_SINK@ 1%+") awesome.emit_signal("volume_change") end),
      awful.button({ }, 5, function() awful.spawn("wpctl set-volume @DEFAULT_AUDIO_SINK@ 1%-") awesome.emit_signal("volume_change") end)
  )
}

awesome.connect_signal("volume_change",
function()
   -- set new volume value
   awful.spawn.easy_async_with_shell(
      "wpctl get-volume @DEFAULT_AUDIO_SINK@",
      function(stdout)
          if stdout == nil or s == '' then
            volume:set_text("init")
          elseif stdout:match("MUTED") then
              volume:set_markup("<span foreground='#a51c30'><b>silence</b></span>")
          else 
              volume:set_markup("<b>" .. stdout:match("%d+%.%d+") .. " dB" .. "</b>")
          end
      end
   ) end
)

awesome.emit_signal("volume_change")

return volume