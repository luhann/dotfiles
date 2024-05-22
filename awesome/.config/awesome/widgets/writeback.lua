local gears = require("gears")
local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")

local xresources = require("beautiful.xresources")
local xrdb = xresources.get_current_theme()
local dpi = xresources.apply_dpi


local writeback = awful.widget.watch("writeback", 1, function(widget, stdout)
  widget:set_text( "󰥠  " .. stdout)
end)


return writeback