local gears = require("gears")
local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")

local xresources = require("beautiful.xresources")
local xrdb = xresources.get_current_theme()
local dpi = xresources.apply_dpi

-- Create a textclock widget
local clock = wibox.widget {
    format = "<span foreground='" .. x.color14 .."'> <b> %H:%M - %Y-%m-%d </b> </span>",
    widget = wibox.widget.textclock,
    buttons = gears.table.join(),
}

return clock