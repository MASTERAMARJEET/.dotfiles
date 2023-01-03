-- awesome_mode: api-level=4:screen=on
-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, "luarocks.loader")

-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")
-- Widget and layout library
local wibox = require("wibox")
-- Theme handling library
local beautiful = require("beautiful")

-- Notification library
local naughty = require("naughty")
-- Declarative object management
local ruled = require("ruled")
local menubar = require("menubar")
local hotkeys_popup = require("awful.hotkeys_popup")
-- Enable hotkeys help widget for VIM and other apps
-- when client with a matching name is opened:
require("awful.hotkeys_popup.keys")

local utils = require("utilities")

-- {{{ Error handling
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
naughty.connect_signal("request::display_error", function(message, startup)
  naughty.notification({
    urgency = "critical",
    title = "Oops, an error happened"
        .. (startup and " during startup!" or "!"),
    message = message,
  })
end)
-- }}}

-- {{{ Variable definitions
-- Themes define colours, icons, font and wallpapers.
beautiful.init(gears.filesystem.get_themes_dir() .. "default/theme.lua")

terminal = "st"
editor = os.getenv("EDITOR") or "nano"
editor_cmd = terminal .. " -e " .. editor

-- Default modkey.
modkey = "Mod4"

-- Table of layouts to cover with awful.layout.inc, order matters.
awful.layout.layouts = {
  awful.layout.suit.max,
  -- awful.layout.suit.max.fullscreen,
  -- awful.layout.suit.floating,
  awful.layout.suit.tile,
  -- awful.layout.suit.tile.left,
  -- awful.layout.suit.tile.bottom,
  -- awful.layout.suit.tile.top,
  -- awful.layout.suit.fair,
  -- awful.layout.suit.fair.horizontal,
  -- awful.layout.suit.spiral,
  -- awful.layout.suit.spiral.dwindle,
  -- awful.layout.suit.magnifier,
  awful.layout.suit.corner.nw,
  -- awful.layout.suit.corner.ne,
  -- awful.layout.suit.corner.sw,
  -- awful.layout.suit.corner.se,
}
-- }}}

-- {{{ Menu
-- Menubar configuration
menubar.utils.terminal = terminal -- Set the terminal for applications that require it
-- }}}

-- {{{ TopBar

local screen_config = require("screen-config")
screen.connect_signal("request::desktop_decoration", function(s)
  screen_config.screen_decoration(s)
end)
-- }}}

-- {{{ Mouse bindings
awful.mouse.append_global_mousebindings({
  awful.button({}, 4, awful.tag.viewprev),
  awful.button({}, 5, awful.tag.viewnext),
})
-- }}}

-- {{{ Key bindings

-- General Awesome keys
awful.keyboard.append_global_keybindings({
  awful.key({}, "#121", function()
    awful.spawn.with_shell("bash ~/scripts/audio_control toggle")
  end, { description = "mute/unmute", group = "system" }),
  awful.key({}, "#122", function()
    awful.spawn.with_shell("bash ~/scripts/audio_control minus")
  end, { description = "decrease volume", group = "system" }),
  awful.key({}, "#123", function()
    awful.spawn.with_shell("bash ~/scripts/audio_control plus")
  end, { description = "increase volume", group = "system" }),
  awful.key({}, "#232", function()
    awful.spawn.with_shell("bash ~/scripts/brightness_control minus")
  end, { description = "decrease brightness", group = "system" }),
  awful.key({}, "#233", function()
    awful.spawn.with_shell("bash ~/scripts/brightness_control plus")
  end, { description = "increase brightness", group = "system" }),
  awful.key({}, "#171", function()
    awful.spawn.with_shell("playerctl next")
  end, { description = "play next", group = "system" }),
  awful.key({}, "#172", function()
    awful.spawn.with_shell("playerctl play-pause")
  end, { description = "play/pause", group = "system" }),
  awful.key({}, "#173", function()
    awful.spawn.with_shell("playerctl previous")
  end, { description = "play previous", group = "system" }),
  awful.key({}, "#107", function()
    awful.spawn.with_shell("flameshot gui")
  end, { description = "take screenshot", group = "system" }),
  awful.key(
    { modkey, "Control" },
    "s",
    hotkeys_popup.show_help,
    { description = "show help", group = "awesome" }
  ),
  awful.key(
    { modkey, "Control" },
    "r",
    awesome.restart,
    { description = "reload awesome", group = "awesome" }
  ),
  awful.key(
    { modkey, "Control" },
    "q",
    awesome.quit,
    { description = "quit awesome", group = "awesome" }
  ),
  -- awful.key({ modkey }, "x", function()
  --     awful.prompt.run({
  --         prompt = "Run Lua code: ",
  --         textbox = awful.screen.focused().mypromptbox.widget,
  --         exe_callback = awful.util.eval,
  --         history_path = awful.util.get_cache_dir() .. "/history_eval",
  --     })
  -- end, { description = "lua execute prompt", group = "awesome" }),
  -- awful.key({ modkey }, "r", function()
  --     awful.screen.focused().mypromptbox:run()
  -- end, { description = "run prompt", group = "launcher" }),
  -- awful.key({ modkey }, "p", function()
  --     menubar.show()
  -- end, { description = "show the menubar", group = "launcher" }),
})

-- Tags related keybindings
awful.keyboard.append_global_keybindings({
  awful.key(
    { modkey },
    "h",
    awful.tag.viewprev,
    { description = "view previous", group = "tag" }
  ),
  awful.key(
    { modkey },
    "l",
    awful.tag.viewnext,
    { description = "view next", group = "tag" }
  ),
  awful.key(
    { modkey },
    "Escape",
    awful.tag.history.restore,
    { description = "go back", group = "tag" }
  ),
})

-- Focus related keybindings
awful.keyboard.append_global_keybindings({
  awful.key({ modkey }, "j", function()
    awful.client.focus.byidx(1)
  end, { description = "focus next by index", group = "client" }),
  awful.key({ modkey }, "k", function()
    awful.client.focus.byidx(-1)
  end, { description = "focus previous by index", group = "client" }),
  awful.key({ modkey }, "Tab", function()
    awful.client.focus.history.previous()
    if client.focus then
      client.focus:raise()
    end
  end, { description = "go back", group = "client" }),
  -- awful.key({ modkey, "Control" }, "j", function()
  --   awful.screen.focus_relative(1)
  -- end, { description = "focus the next screen", group = "screen" }),
  -- awful.key({ modkey, "Control" }, "k", function()
  --   awful.screen.focus_relative(-1)
  -- end, { description = "focus the previous screen", group = "screen" }),
  awful.key({ modkey, "Control" }, "n", function()
    local c = awful.client.restore()
    -- Focus restored client
    if c then
      c:activate({ raise = true, context = "key.unminimize" })
    end
  end, { description = "restore minimized", group = "client" }),
  -- awful.key({ modkey }, "t", function()
  --   for s in screen do
  --     s.wibox.visible = not s.wibox.visible
  --     awful.spawn.with_shell("bash ~/scripts/polybar_controller toggle")
  --   end
  -- end, { description = "toggle wibox", group = "awesome" }),
})

-- Layout related keybindings
awful.keyboard.append_global_keybindings({
  awful.key({ modkey, "Shift" }, "j", function()
    awful.client.swap.byidx(1)
  end, {
    description = "swap with next client by index",
    group = "client",
  }),
  awful.key({ modkey, "Shift" }, "k", function()
    awful.client.swap.byidx(-1)
  end, {
    description = "swap with previous client by index",
    group = "client",
  }),
  awful.key(
    { modkey },
    "u",
    awful.client.urgent.jumpto,
    { description = "jump to urgent client", group = "client" }
  ),
  awful.key({ modkey }, "Right", function()
    awful.tag.incmwfact(0.05)
  end, { description = "increase master width factor", group = "layout" }),
  awful.key({ modkey }, "Left", function()
    awful.tag.incmwfact(-0.05)
  end, { description = "decrease master width factor", group = "layout" }),
  -- awful.key({ modkey, "Shift" }, "h", function()
  --   awful.tag.incnmaster(1, nil, true)
  -- end, {
  --   description = "increase the number of master clients",
  --   group = "layout",
  -- }),
  -- awful.key({ modkey, "Shift" }, "l", function()
  --   awful.tag.incnmaster(-1, nil, true)
  -- end, {
  --   description = "decrease the number of master clients",
  --   group = "layout",
  -- }),
  -- local show_tag_by_numrow_index = awful.key {
  --     modifiers = { "Mod4" },
  --     keygroup = awful.key.keygroup.NUMROW,
  --     description = "only view tag",
  --     group = "tag",
  --     on_press = function (index)
  --         local screen = awful.screen.focused()
  --         local tag = screen.tags[index]
  --         if tag then
  --             tag:view_only()
  --         end
  --     end
  -- }
  awful.key({ modkey, "Shift" }, "h", function()
    if client.focus then
      local tags = awful.screen.focused().tags
      local current_tag = awful.screen.focused().selected_tag
      local current_idx = utils.get_key(tags, current_tag)
      local prev_idx = gears.math.cycle(#tags, current_idx - 1)
      local prev_tag = tags[prev_idx]
      if tag then
        client.focus:move_to_tag(prev_tag)
        awful.tag.viewprev()
      end
    end
  end, {
    description = "move focused client to previous tag",
    group = "tag",
  }),
  awful.key({ modkey, "Shift" }, "l", function()
    if client.focus then
      local tags = awful.screen.focused().tags
      local current_tag = awful.screen.focused().selected_tag
      local current_idx = utils.get_key(tags, current_tag)
      local next_idx = gears.math.cycle(#tags, current_idx + 1)
      local next_tag = tags[next_idx]
      if tag then
        client.focus:move_to_tag(next_tag)
        awful.tag.viewnext()
      end
    end
  end, {
    description = "move focused client to next tag",
    group = "tag",
  }),
  awful.key({ modkey, "Control" }, "h", function()
    awful.tag.incncol(1, nil, true)
  end, {
    description = "increase the number of columns",
    group = "layout",
  }),
  awful.key({ modkey, "Control" }, "l", function()
    awful.tag.incncol(-1, nil, true)
  end, {
    description = "decrease the number of columns",
    group = "layout",
  }),
  awful.key({ modkey }, "space", function()
    awful.layout.inc(1)
  end, { description = "select next", group = "layout" }),
  awful.key({ modkey, "Shift" }, "space", function()
    awful.layout.inc(-1)
  end, { description = "select previous", group = "layout" }),
})

awful.keyboard.append_global_keybindings({
  awful.key({
    modifiers = { modkey },
    keygroup = "numrow",
    description = "only view tag",
    group = "tag",
    on_press = function(index)
      local screen = awful.screen.focused()
      local tag = screen.tags[index]
      if tag then
        tag:view_only()
      end
    end,
  }),
  awful.key({
    modifiers = { modkey, "Control" },
    keygroup = "numrow",
    description = "toggle tag",
    group = "tag",
    on_press = function(index)
      local screen = awful.screen.focused()
      local tag = screen.tags[index]
      if tag then
        awful.tag.viewtoggle(tag)
      end
    end,
  }),
  awful.key({
    modifiers = { modkey, "Shift" },
    keygroup = "numrow",
    description = "move focused client to tag",
    group = "tag",
    on_press = function(index)
      if client.focus then
        local tag = client.focus.screen.tags[index]
        if tag then
          client.focus:move_to_tag(tag)
        end
      end
    end,
  }),
  awful.key({
    modifiers = { modkey, "Control", "Shift" },
    keygroup = "numrow",
    description = "toggle focused client on tag",
    group = "tag",
    on_press = function(index)
      if client.focus then
        local tag = client.focus.screen.tags[index]
        if tag then
          client.focus:toggle_tag(tag)
        end
      end
    end,
  }),
  awful.key({
    modifiers = { modkey },
    keygroup = "numpad",
    description = "select layout directly",
    group = "layout",
    on_press = function(index)
      local t = awful.screen.focused().selected_tag
      if t then
        t.layout = t.layouts[index] or t.layout
      end
    end,
  }),
})

awful.keyboard.append_global_keybindings({
  -- Applications Prompt
  awful.key({ modkey }, "d", function()
    awful.util.spawn("rofi -show drun")
  end, { description = "applications prompt", group = "launcher" }),

  -- Run Prompt
  awful.key({ modkey }, "p", function()
    awful.util.spawn("rofi -show run")
  end, { description = "run prompt", group = "launcher" }),

  -- Terminal
  awful.key({ modkey }, "Return", function()
    awful.spawn(terminal)
  end, { description = "open a terminal", group = "launcher" }),

  -- Browser
  awful.key({ modkey }, "b", function()
    awful.util.spawn("brave")
  end, { description = "open browser", group = "launcher" }),

  -- Slack
  awful.key({ modkey }, "s", function()
    awful.util.spawn("slack")
  end, { description = "open slack", group = "launcher" }),
})

client.connect_signal("request::default_keybindings", function()
  awful.keyboard.append_client_keybindings({
    awful.key({ modkey }, "f", function(c)
      c.fullscreen = not c.fullscreen
      c:raise()
    end, { description = "toggle fullscreen", group = "client" }),
    awful.key({ modkey }, "q", function(c)
      c:kill()
    end, { description = "close", group = "client" }),
    awful.key(
      { modkey, "Control" },
      "space",
      awful.client.floating.toggle,
      { description = "toggle floating", group = "client" }
    ),
    awful.key({ modkey, "Control" }, "Return", function(c)
      c:swap(awful.client.getmaster())
    end, { description = "move to master", group = "client" }),
    awful.key({ modkey }, "o", function(c)
      c:move_to_screen()
    end, { description = "move to screen", group = "client" }),
    -- awful.key({ modkey }, "t", function(c)
    --   c.ontop = not c.ontop
    -- end, { description = "toggle keep on top", group = "client" }),
    -- awful.key({ modkey }, "n", function(c)
    --     -- The client currently has the input focus, so it cannot be
    --     -- minimized, since minimized clients can't have the focus.
    --     c.minimized = true
    -- end, { description = "minimize", group = "client" }),
    awful.key({ modkey }, "m", function(c)
      c.maximized = not c.maximized
      c:raise()
    end, { description = "(un)maximize", group = "client" }),
    awful.key({ modkey, "Control" }, "m", function(c)
      c.maximized_vertical = not c.maximized_vertical
      c:raise()
    end, {
      description = "(un)maximize vertically",
      group = "client",
    }),
    awful.key({ modkey, "Shift" }, "m", function(c)
      c.maximized_horizontal = not c.maximized_horizontal
      c:raise()
    end, {
      description = "(un)maximize horizontally",
      group = "client",
    }),
  })
end)

client.connect_signal("request::default_mousebindings", function()
  awful.mouse.append_client_mousebindings({
    awful.button({}, 1, function(c)
      c:activate({ context = "mouse_click" })
    end),
    awful.button({ modkey }, 1, function(c)
      c:activate({ context = "mouse_click", action = "mouse_move" })
    end),
    awful.button({ modkey }, 3, function(c)
      c:activate({ context = "mouse_click", action = "mouse_resize" })
    end),
  })
end)

-- }}}

-- {{{ Rules
-- Rules to apply to new clients.
ruled.client.connect_signal("request::rules", function()
  -- All clients will match this rule.
  ruled.client.append_rule({
    id = "global",
    rule = {},
    properties = {
      focus = awful.client.focus.filter,
      raise = true,
      screen = awful.screen.preferred,
      placement = awful.placement.no_overlap + awful.placement.no_offscreen,
    },
  })

  -- Floating clients.
  ruled.client.append_rule({
    id = "floating",
    rule_any = {
      instance = { "copyq", "pinentry" },
      class = {
        "Arandr",
        "Blueman-manager",
        "Gpick",
        "Kruler",
        "Sxiv",
        "Tor Browser", -- Needs a fixed window size to avoid fingerprinting by screen size.
        "Wpa_gui",
        "veromix",
        "xtightvncviewer",
      },
      -- Note that the name property shown in xprop might be set slightly after creation of the client
      -- and the name shown there might not match defined rules here.
      name = {
        "Event Tester", -- xev.
      },
      role = {
        "AlarmWindow", -- Thunderbird's calendar.
        "ConfigManager", -- Thunderbird's about:config.
        "pop-up", -- e.g. Google Chrome's (detached) Developer Tools.
      },
    },
    properties = {
      floating = true,
      placement = awful.placement.centered,
    },
  })

  -- Add titlebars to normal clients and dialogs
  ruled.client.append_rule({
    id = "titlebars",
    rule_any = { type = { "normal", "dialog" } },
    properties = { titlebars_enabled = true },
  })

  -- Always open slack in on tag "4"
  ruled.client.append_rule({
    id = "slack",
    rule = { class = "Slack" },
    properties = { tag = "4" },
  })
  -- Set Firefox to always map on the tag named "2" on screen 1.
  -- ruled.client.append_rule {
  --     rule       = { class = "Firefox"     },
  --     properties = { screen = 1, tag = "2" }
  -- }
end)

-- }}}

-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal("mouse::enter", function(c)
  c:activate({ context = "mouse_enter", raise = false })
end)

-- {{{ Notifications
ruled.notification.connect_signal("request::rules", function()
  -- All notifications will match this rule.
  ruled.notification.append_rule({
    rule = {},
    properties = {
      screen = awful.screen.preferred,
      implicit_timeout = 5,
    },
  })
end)
naughty.connect_signal("request::display", function(n)
  naughty.layout.box({ notification = n })
end)
-- }}}

-- Gaps
beautiful.useless_gap = 0

-- Autostart
awful.spawn.with_shell("bash ~/scripts/autostart")
