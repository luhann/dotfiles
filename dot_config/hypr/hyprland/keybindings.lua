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

-- Screenshots (grim + slurp): save to ~/pictures/screenshots and copy to clipboard
-- Same keys and filename format as the niri config
local screenshotFile = [["$HOME/pictures/screenshots/screenshot from $(date '+%Y-%m-%d %H-%M-%S').png"]]
local function screenshot(capture)
    return hl.dsp.exec_cmd('mkdir -p "$HOME/pictures/screenshots" && '
        .. capture .. " - | tee " .. screenshotFile .. " | wl-copy")
end
hl.bind("Print",        screenshot([[grim -g "$(slurp)"]]))
hl.bind("CTRL + Print", screenshot([[grim -o "$(hyprctl monitors -j | jq -r '.[] | select(.focused).name')"]]))
hl.bind("ALT + Print",  screenshot([[grim -g "$(hyprctl activewindow -j | jq -r '"\(.at[0]),\(.at[1]) \(.size[0])x\(.size[1])"')"]]))

-- Clipboard history (cliphist)
hl.bind(mainMod .. " + CTRL + V",       hl.dsp.exec_cmd("cliphist list | rofi -dmenu -p clipboard | cliphist decode | wl-copy"))

-- Volume, brightness and media keys (playerctl)
local mediaBinds = {
    { key = "XF86AudioRaiseVolume",  cmd = "wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+", repeating = true },
    { key = "XF86AudioLowerVolume",  cmd = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-",       repeating = true },
    { key = "XF86AudioMute",         cmd = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle" },
    { key = "XF86AudioMicMute",      cmd = "wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle" },
    { key = "XF86MonBrightnessUp",   cmd = "brightnessctl s 5%+", repeating = true },
    { key = "XF86MonBrightnessDown", cmd = "brightnessctl s 5%-", repeating = true },
    { key = "XF86AudioNext",         cmd = "playerctl next" },
    { key = "XF86AudioPause",        cmd = "playerctl play-pause" },
    { key = "XF86AudioPlay",         cmd = "playerctl play-pause" },
    { key = "XF86AudioPrev",         cmd = "playerctl previous" },
}
for _, b in ipairs(mediaBinds) do
    hl.bind(b.key, hl.dsp.exec_cmd(b.cmd), { locked = true, repeating = b.repeating })
end

--------------------
---- GESTURES ----
--------------------

hl.gesture({ fingers = 3, direction = "vertical",  action = "workspace" })
hl.gesture({ fingers = 3, direction = "horizontal", action = function() hl.dispatch(hl.dsp.window.cycle_next()) end })
hl.gesture({ fingers = 3, direction = "up",         mods = "SUPER", scale = 1.5, action = "fullscreen" })
