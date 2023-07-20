-- Achilles Come Down
local awful = require("awful")

local theme_name = "patroclus"
local icon_path = os.getenv("HOME") .. "/.config/awesome/themes/" .. theme_name .. "/icons/"

local theme_assets = require("beautiful.theme_assets")

local xresources = require("beautiful.xresources")
local xrdb = xresources.get_current_theme()
local dpi = xresources.apply_dpi

local gfs = require("gears.filesystem")
local themes_path = gfs.get_themes_dir()

local theme = {}

-- Set some colors that are used frequently as local variables
local accent_color = x.color14
local focused_color = x.color14
local unfocused_color = x.color7
local urgent_color = x.color9

theme.font          = "Iosevka Aile 8"

theme.notification_max_width = dpi(300)
theme.notification_max_height = dpi(100)
theme.notification_icon_size = dpi(60)

-- Colours
theme.bg_dark     = x.background
theme.bg_normal     = x.color0 .. "00"
theme.bg_focus      = x.background
theme.bg_urgent     = x.background
theme.bg_minimize   = x.color8
theme.bg_systray    = x.background .. "00"

theme.fg_normal     = x.color7
theme.fg_focus      = focused_color
theme.fg_urgent     = urgent_color
theme.fg_minimize   = x.color8


-- Gaps
theme.useless_gap   = dpi(3)
theme.gap_single_client = true

-- This could be used to manually determine how far away from the
-- screen edge the bars / notifications should be.
theme.screen_margin = dpi(3)

-- Borders
theme.border_width  = dpi(3)
theme.border_color = x.color0
theme.border_normal = x.color0
theme.border_focus  = x.color0


-- Tasklist
--
theme.tasklist_disable_task_name = true
theme.tasklist_bg_focus = x.color0 .. "00"
theme.tasklist_fg_focus = focused_color
theme.tasklist_bg_normal = x.color0 .. "00"
theme.tasklist_fg_normal = unfocused_color
theme.tasklist_bg_minimize = x.color0 .. "00"
theme.tasklist_fg_minimize = theme.fg_minimize
theme.tasklist_bg_urgent = x.color0 .. "00"
theme.tasklist_fg_urgent = urgent_color
theme.tasklist_spacing = dpi(5)
theme.tasklist_align = "center"

theme.taglist_fg_empty = unfocused_color .. "55"
theme.taglist_bg_focus = x.color0 .. "55"

theme.hotkeys_opacity = 0.75
theme.hotkeys_border_width = dpi(0)
-- There are other variable sets
-- overriding the default one when
-- defined, the sets are:
-- taglist_[bg|fg]_[focus|urgent|occupied|empty|volatile]
-- tasklist_[bg|fg]_[focus|urgent]
-- titlebar_[bg|fg]_[normal|focus]
-- tooltip_[font|opacity|fg_color|bg_color|border_width|border_color]
-- mouse_finder_[color|timeout|animate_timeout|radius|factor]
-- prompt_[fg|bg|fg_cursor|bg_cursor|font]
-- hotkeys_[bg|fg|border_width|border_color|shape|opacity|modifiers_fg|label_bg|label_fg|group_margin|font|description_font]
-- Example:
theme.ram_bar_active_color = focused_color
theme.ram_bar_background_color = unfocused_color

--theme.taglist_bg_focus = "#ff0000"
-- You can use your own layout icons like this:
-- You can use your own layout icons like this:
theme.icon_size = dpi(15)

theme.layout_fairv = icon_path .. "fairv.svg"
theme.layout_floating  = icon_path .. "floating.svg"
theme.layout_tile = icon_path .. "tile.svg"
theme.layout_spiral  = icon_path .. "spiral.svg"

theme.ram_icon = icon_path .. "ram.svg"
theme.power_icon = icon_path .. "power.svg"


-- Variables set for theming notifications:
-- notification_font
-- notification_[bg|fg]
-- notification_[width|height|margin]
-- notification_[border_color|border_width|shape|opacity]

-- Variables set for theming the menu:
-- menu_[bg|fg]_[normal|focus]
-- menu_[border_color|border_width]
theme.menu_height = dpi(15)
theme.menu_width  = dpi(100)


-- Generate Awesome icon:
theme.awesome_icon = theme_assets.awesome_icon(
    theme.menu_height, theme.bg_focus, theme.fg_focus
)

-- Define the icon theme for application icons. If not set then the icons
-- from /usr/share/icons and /usr/share/icons/hicolor will be used.
theme.icon_theme = "/usr/share/icons/Papirus-Dark"

return theme
