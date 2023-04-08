local awful = require("awful")
local beautiful = require("beautiful")
local naughty = require("naughty")

-- Function to call on screen startup
local function screen_decoration(s)
  -- -- Tags
  awful.tag({ "1", "2", "3", "4" }, s, awful.layout.layouts[1])

  local wibox_bar = awful.wibar({
    screen = s,
    position = "top",
    -- type = "desktop",
    height = 24,
    ontop = true,
    bg = beautiful.wibar_bg,
  })

  local function change_wibox_visibility(client)
    if client.screen == s then
      wibox_bar.ontop = not client.fullscreen
      if client.fullscreen then
        awful.spawn.with_shell("bash ~/scripts/polybar_controller hide")
      else
        awful.spawn.with_shell("bash ~/scripts/polybar_controller show")
      end
    end
  end

  client.connect_signal("property::fullscreen", change_wibox_visibility)
  client.connect_signal("focus", change_wibox_visibility)
  s.wibox = wibox_bar
end

return {
  screen_decoration = screen_decoration,
}
