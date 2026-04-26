swayimg.set_mode("viewer")
swayimg.viewer.limit_preload(50)
swayimg.imagelist.enable_adjacent(true)

-- Keybinds
swayimg.viewer.on_key("Left", function()
    swayimg.viewer.switch_image("prev")
end)

swayimg.viewer.on_key("Right", function()
    swayimg.viewer.switch_image("next")
end)
