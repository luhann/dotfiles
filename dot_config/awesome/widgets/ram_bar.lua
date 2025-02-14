local gears = require("gears")
local wibox = require("wibox")
local beautiful = require("beautiful")

local xresources = require("beautiful.xresources")
local xrdb = xresources.get_current_theme()
local dpi = xresources.apply_dpi

-- Set colors
local active_color = beautiful.ram_bar_active_color or "#5AA3CC"
local background_color = beautiful.ram_bar_background_color or "#222222"


function format_progress_bar(bar, icon)
    icon.forced_height = icon_size
    icon.forced_width = icon_size
    icon.resize = true
    bar.forced_width = dpi(50)
    bar.shape = gears.shape.rounded_bar
    bar.bar_shape = gears.shape.rounded_bar

    -- bar.forced_height = dpi(30)
    -- bar.paddings = dpi(4)
    -- bar.border_width = dpi(2)
    -- bar.border_color = x.color8

    local w = wibox.widget{
        nil,
        {
            -- icon,
            bar,
            spacing = dpi(10),
            layout = wibox.layout.fixed.horizontal
        },
        expand = "none",
        reflection = {horizontal = true},
        layout = wibox.container.mirror
    }
    return w
end


local ram_bar = wibox.widget{
    max_value     = 100,
    value         = 50,
    forced_height = dpi(10),
    margins       = {
        top = dpi(8),
        bottom = dpi(8),
    },
    forced_width  = dpi(200),
    shape         = gears.shape.rounded_bar,
    bar_shape     = gears.shape.rounded_bar,
    color         = active_color,
    background_color = background_color,
    border_width  = 0,
    border_color  = beautiful.border_color,
    widget        = wibox.widget.progressbar,
}

local ram = format_progress_bar(ram_bar, wibox.widget.imagebox(beautiful.ram_icon))

awesome.connect_signal("daemon::ram", function(used, total)
    local used_ram_percentage = (used / total) * 100
    ram_bar.value = used_ram_percentage
end)

return ram
