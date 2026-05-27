swayimg.set_mode("viewer")
swayimg.viewer.limit_preload(50)
swayimg.imagelist.enable_adjacent(true)

swayimg.gallery.enable_pstore(true)

swayimg.on_window_resize(function()
  swayimg.viewer.set_fix_scale("optimal")
end)

swayimg.viewer.on_image_change(function()
  swayimg.viewer.set_default_scale("optimal")
end)

-- Keybinds
swayimg.viewer.on_key("Left", function()
  swayimg.viewer.switch_image("prev")
end)

swayimg.viewer.on_key("Right", function()
  swayimg.viewer.switch_image("next")
end)

swayimg.viewer.on_key("i", function()
    swayimg.text.show()
end)

swayimg.viewer.on_key("q", function()
  swayimg.exit()
end)
