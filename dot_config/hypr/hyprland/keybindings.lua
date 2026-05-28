-- Keybindings module
-- Loaded via require("keybindings") from hyprland.lua
-- Program variables and mainMod are provided by the HY global set in hyprland.lua
--
-- See https://wiki.hypr.land/Configuring/Basics/Binds/

local terminal    = HY.terminal
local browser     = HY.browser
local fileManager = HY.fileManager
local menu        = HY.menu
local mainMod     = HY.mainMod

-- Applications
hl.bind(mainMod .. " + Return",         hl.dsp.exec_cmd(terminal .. " msg create-window"))
hl.bind(mainMod .. " + SHIFT + Return", hl.dsp.exec_cmd(terminal .. " msg create-window --class floating"))
hl.bind(mainMod .. " + E",              hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + SHIFT + E",      hl.dsp.exec_cmd(terminal .. " msg create-window --class floating -e fish -c yazi"))
hl.bind(mainMod .. " + R",              hl.dsp.exec_cmd(browser))

-- Session / window management
hl.bind(mainMod .. " + L",              hl.dsp.exec_cmd("loginctl lock-session"))
hl.bind(mainMod .. " + Q",              hl.dsp.window.close())
hl.bind(mainMod .. " + SHIFT + Q",      hl.dsp.exit())
hl.bind(mainMod .. " + V",              hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + D",              hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + J",              hl.dsp.layout("togglesplit"))

-- Focus / presentation mode: toggle gaps and borders off and back on
hl.bind(mainMod .. " + SHIFT + P", function()
    local focused = hl.get_config("general.gaps_in").top > 0
    hl.config({ general = {
        gaps_in     = focused and 0 or 5,
        gaps_out    = focused and 0 or 10,
        border_size = focused and 0 or 2,
    }})
end)

-- Extra programs
hl.bind(mainMod .. " + Z",              hl.dsp.exec_cmd("zotero"))
hl.bind(mainMod .. " + backslash",      hl.dsp.exec_cmd("wallpaper"))
hl.bind(mainMod .. " + space",          hl.dsp.exec_cmd("search"))

-- Focus movement
hl.bind(mainMod .. " + left",           hl.dsp.focus({ direction = "l" }))
hl.bind(mainMod .. " + right",          hl.dsp.focus({ direction = "r" }))
hl.bind(mainMod .. " + up",             hl.dsp.focus({ direction = "u" }))
hl.bind(mainMod .. " + down",           hl.dsp.focus({ direction = "d" }))
hl.bind(mainMod .. " + f",              hl.dsp.window.fullscreen())

-- Scrolling
hl.bind(mainMod .. " + period", hl.dsp.layout("move +col"))
hl.bind(mainMod .. " + SHIFT + period", hl.dsp.layout("move -col"))
hl.bind(mainMod .. " + comma", hl.dsp.layout("swapcol l"))
hl.bind(mainMod .. " + SHIFT + comma", hl.dsp.layout("swapcol r"))

-- Workspaces
for i = 1, 10 do
    local key = i % 10  -- 10 maps to key 0
    hl.bind(mainMod .. " + " .. key,         hl.dsp.focus({ workspace = i }))
    hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i, follow = false }))
end

-- Cycle windows
hl.bind(mainMod .. " + Tab",            hl.dsp.window.cycle_next())
hl.bind(mainMod .. " + SHIFT + Tab",    hl.dsp.window.cycle_next({ next = false }))

-- Special workspace (scratchpad)
hl.bind(mainMod .. " + S",              hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + SHIFT + S",      hl.dsp.window.move({ workspace = "special:magic" }))

-- Scroll through workspaces
hl.bind(mainMod .. " + mouse_down",     hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up",       hl.dsp.focus({ workspace = "e-1" }))

-- Move/resize with mouse
hl.bind(mainMod .. " + mouse:272",      hl.dsp.window.drag(),   { mouse = true })
hl.bind(mainMod .. " + mouse:273",      hl.dsp.window.resize(), { mouse = true })

-- Volume and brightness
hl.bind("XF86AudioRaiseVolume",  hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume",  hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),      { locked = true, repeating = true })
hl.bind("XF86AudioMute",         hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),     { locked = true})
hl.bind("XF86AudioMicMute",      hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),   { locked = true})
hl.bind("XF86MonBrightnessUp",   hl.dsp.exec_cmd("brightnessctl s 5%+"),                            { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl s 5%-"),                            { locked = true, repeating = true })

-- Media keys (playerctl)
hl.bind("XF86AudioNext",  hl.dsp.exec_cmd("playerctl next"),        { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"),  { locked = true })
hl.bind("XF86AudioPlay",  hl.dsp.exec_cmd("playerctl play-pause"),  { locked = true })
hl.bind("XF86AudioPrev",  hl.dsp.exec_cmd("playerctl previous"),    { locked = true })

--------------------
---- GESTURES ----
--------------------

hl.gesture({ fingers = 3, direction = "vertical",  action = "workspace" })
hl.gesture({ fingers = 3, direction = "horizontal", action = function() hl.dispatch(hl.dsp.window.cycle_next()) end })
hl.gesture({ fingers = 3, direction = "up",         mods = "SUPER", scale = 1.5, action = "fullscreen" })
