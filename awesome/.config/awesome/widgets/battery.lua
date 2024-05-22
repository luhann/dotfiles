local gears = require("gears")
local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")

local xresources = require("beautiful.xresources")
local xrdb = xresources.get_current_theme()
local dpi = xresources.apply_dpi


local battery = awful.widget.watch("acpi -b", 5, function(widget, stdout)
  perc = string.match(stdout, "%d+%%")
  if stdout:match("Charging") then
    widget:set_text(perc .. " 󰐼 ")
    return
  elseif stdout:match("Full") then
    widget:set_text(perc .. " 󱡝 ")
    return
  elseif stdout:match("Discharging") then
    widget:set_text(perc)
    return
  end
end)


return battery
