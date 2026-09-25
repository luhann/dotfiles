swayimg.mode = "viewer"
swayimg.viewer.preload = 50
swayimg.viewer.default_scale = "optimal"
swayimg.imagelist.adjacent = true

swayimg.gallery.pstore = true

swayimg.on_window_resize(function()
  swayimg.viewer.set_fix_scale("optimal")
end)

-- Keybinds
swayimg.viewer.on_key("Left", function()
  swayimg.viewer.open("prev")
end)

swayimg.viewer.on_key("Right", function()
  swayimg.viewer.open("next")
end)

swayimg.viewer.on_key("i", function()
  swayimg.text.visible = true
end)

swayimg.viewer.on_key("q", function()
  swayimg.exit()
end)
