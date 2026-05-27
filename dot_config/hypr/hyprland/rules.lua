-- Window and workspace rules module
-- Loaded via require("rules") from hyprland.lua
--
-- See https://wiki.hypr.land/Configuring/Basics/Window-Rules/
-- See https://wiki.hypr.land/Configuring/Basics/Workspace-Rules/

-- Per-workspace layout rules
hl.workspace_rule({ workspace = "name:term", layout = "scrolling" })
hl.workspace_rule({ workspace = "name:dev", layout = "master" })

-- Window rules
hl.window_rule({ match = { class = "^firefox" },                        opacity = "1.0 override" })
hl.window_rule({ match = { class = "^(mpv|vlc)$" },                    opacity = "1.0 override" })
hl.window_rule({ match = { fullscreen = true },                         opacity = "1.0 override" })
hl.window_rule({ match = { class = "^(pavucontrol|blueman-manager)$" }, float = true })
hl.window_rule({ match = { class = ".*" },                              suppress_event = "maximize" })
hl.window_rule({ match = { class = "Alacritty" },                       opacity = "0.9 override 0.9 override" })
hl.window_rule({ match = { class = "floating" },                        float = true })

-- Layer rules
hl.layer_rule({ match = { namespace = "waybar" }, blur = true })
hl.layer_rule({ match = { namespace = "rofi" }, no_anim = true })
