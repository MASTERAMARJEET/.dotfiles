local gears = require("gears")
local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local dpi = require("beautiful.xresources").apply_dpi
local widgets = require("widgets")
local utils = require("utils")
local naughty = require("naughty")
local inspect = require("inspect")

-- Function to call on screen startup
local function screen_decoration(s)
    local colors = {
        -- Background
        bg = "#282828",
        bg0 = "#282828",
        bg0_s = "#32302f",
        bg0_h = "#1d2021",
        bg1 = "#3c3836",
        bg2 = "#504945",
        bg3 = "#665c54",
        bg4 = "#7c6f64",

        -- Foreground
        fg = "#ebdbb2",
        fg0 = "#fbf1c7",
        fg1 = "#ebdbb2",
        fg2 = "#d5c4a1",
        fg3 = "#bdae93",
        fg4 = "#a89984",

        -- Grayer
        gray = "#928374",
        gray1 = "#a89984",
        gray2 = "#928374",

        -- Normal Colors
        red = "#cc241d",
        green = "#98971a",
        yellow = "#d79921",
        blue = "#458588",
        purple = "#b16286",
        aqua = "#689d6a",
        orange = "#d65d0e",

        -- Light colors
        light_red = "#fb4934",
        light_green = "#b8bb26",
        light_yellow = "#fabd2f",
        light_blue = "#83a598",
        light_purple = "#d3869b",
        light_aqua = "#8ec07c",
        light_orange = "#fe8019",
    }

    beautiful.colors = colors
    -- -- If wallpaper is a function, call it with the screen
    -- local wallpaper = beautiful.wallpaper
    -- if type(wallpaper) == "function" then
    --     wallpaper = wallpaper(s)
    -- end
    -- gears.wallpaper.maximized(wallpaper, s, true)
    --
    -- -- Tags
    awful.tag({ "1", "2", "3", "4", "5" }, s, awful.layout.layouts[1])

    -- Sidebar
    local sidebar = widgets.sidebar.sidebar:new({
        screen = s,
    })

    -- Date widget
    local date_w = widgets.base:new({
        icon = { markup = "  ", bg = beautiful.colors.light_red },
        inner_widget = wibox.widget.textclock("%a %b %d"),
        bg_normal = "#00000000",
        bg_active = beautiful.colors.light_red,
    })

    -- Time widget
    local time_w = widgets.base:new({
        icon = { markup = "  ", bg = beautiful.colors.light_orange },
        inner_widget = wibox.widget.textclock("%H:%M"),
        bg_normal = "#00000000",
        bg_active = beautiful.colors.light_orange,
    })

    -- -- Systray widget
    -- local systray_w = wibox.widget.systray()

    -- Hostname widget
    local hostname_w = widgets.base:new({
        icon = { markup = "  ", bg = beautiful.colors.bg3 },
        inner_widget = wibox.widget.textbox(awful.util.hostname),
        bg_normal = "#00000000",
        bg_active = beautiful.colors.bg3,
    })

    -- Power widget
    local power_w = widgets.base:new({
        --markup = "  ",
        markup = "  ",
        bg_normal = beautiful.colors.purple,
        bg_active = beautiful.colors.light_purple,
        margins = { left = dpi(2), right = dpi(2) },
    })
    local power_w_tooltip = awful.tooltip({
        objects = { power_w.widget },
        bg = beautiful.colors.bg1,
        fg = beautiful.colors.fg,
    })
    power_w:connect_signal("mouse::enter", function()
        power_w_tooltip.text = "Menu"
    end)
    power_w:buttons(gears.table.join(awful.button({}, 1, function()
        sidebar:show(nil)
    end)))

    -- Brightness widget
    local brightness_w = widgets.brightness:new({
        widget = widgets.base:new({
            icon = { markup = "  ", bg = beautiful.colors.light_aqua },
            markup = " 0% ",
            bg_normal = "#00000000",
            bg_active = beautiful.colors.light_aqua,
        }),
        settings = function(self)
            local text_value = self.brightness .. "%"
            self.widget:get_children_by_id("text")[1]:set_markup(text_value)
            --self.widget:get_children_by_id("icon")[1]:set_markup(bat_header)
        end,
    })
    brightness_w.widget:buttons(gears.table.join(
        awful.button({}, 4, function()
            local brightness_controller = utils.brightness({})
            brightness_controller:inc(10)
        end),
        awful.button({}, 5, function()
            local brightness_controller = utils.brightness({})
            brightness_controller:dec(10)
        end)
    ))
    local brightness_slider = widgets.brightness_slider:new({
        parent = brightness_w.widget,
    })
    s.brightness_popup = widgets.brightness_popup:new()

    -- Audio widget
    local audio_w = widgets.audio:new({
        widget = widgets.base:new({
            icon = { markup = " 墳 ", bg = beautiful.colors.light_purple },
            markup = "0%",
            bg_normal = "#00000000",
            bg_active = beautiful.colors.light_purple,
        }),
        settings = function(self)
            local text_value = ""
            if self.volume.left == self.volume.right then
                text_value = self.volume.left .. "%"
            else
                text_value = self.volume.left
                    .. "% - "
                    .. self.volume.right
                    .. "%"
            end

            local background =
                self.widget:get_children_by_id(
                    "background_role"
                )[1]
            local icon_background = self.widget:get_children_by_id(
                "icon_background_role"
            )[1]

            local icon_value = " 墳 "

            if self.ports[self.active_port].type == "Headphones" then
                if self.muted then
                    icon_value = " ﳌ "
                else
                    icon_value = "  "
                end
            else
                if self.muted then
                    icon_value = " 婢 "
                else
                    icon_value = " 墳 "
                end
            end

            if self.muted then
                background.bg_active = beautiful.colors.light_red
                icon_background.bg = beautiful.colors.light_red
            else
                background.bg_active = beautiful.colors.light_purple
                icon_background.bg = beautiful.colors.light_purple
            end

            self.widget:get_children_by_id("text")[1]:set_markup(text_value)
            self.widget:get_children_by_id("icon")[1]:set_markup(icon_value)
        end,
    })
    local audio_slider = widgets.audio_slider:new({
        parent = audio_w.widget,
    })
    s.audio_popup = widgets.audio_popup:new({})

    -- Battery widget
    local battery_w = widgets.battery:new({
        widget = widgets.base:new({
            icon = { markup = "  ", bg = beautiful.colors.light_green },
            markup = " 0% ",
            bg_normal = "#00000000",
            bg_active = beautiful.colors.light_green,
        }),
        critic_perc = { 10, 20 },
        settings = function(self)
            local bat_header = ""
            if self.perc >= 99 then
                bat_header = "  "
            elseif self.perc >= 90 then
                bat_header = "  "
            elseif self.perc >= 80 then
                bat_header = "  "
            elseif self.perc >= 70 then
                bat_header = "  "
            elseif self.perc >= 60 then
                bat_header = "  "
            elseif self.perc >= 50 then
                bat_header = "  "
            elseif self.perc >= 40 then
                bat_header = "  "
            elseif self.perc >= 30 then
                bat_header = "  "
            elseif self.perc >= 20 then
                bat_header = "  "
            elseif self.perc >= 10 then
                bat_header = "  "
            else
                bat_header = "  "
            end

            if self.ac_status == 1 then
                bat_header = bat_header .. " "
            end

            local background =
                self.widget:get_children_by_id(
                    "background_role"
                )[1]
            local icon_background = self.widget:get_children_by_id(
                "icon_background_role"
            )[1]

            if self.perc >= 30 then
                background.bg_active = beautiful.colors.light_green
                icon_background.bg = beautiful.colors.light_green
            elseif self.perc >= 15 then
                background.bg_active = beautiful.colors.yellow
                icon_background.bg = beautiful.colors.yellow
            else
                background.bg_active = beautiful.colors.red
                icon_background.bg = beautiful.colors.red
            end

            local text_value = self.perc .. "%"

            self.widget:get_children_by_id("text")[1]:set_markup(text_value)
            self.widget:get_children_by_id("icon")[1]:set_markup(bat_header)
        end,
    })
    battery_w.widget:buttons(gears.table.join(awful.button({}, 1, function()
        battery_w:full_update()
    end)))
    local battery_w_tooltip = awful.tooltip({
        objects = { battery_w.widget },
        bg = beautiful.colors.bg1,
        fg = beautiful.colors.fg,
    })
    battery_w.widget:connect_signal("mouse::enter", function()
        battery_w_tooltip.text = battery_w.status or "N/A"
    end)

    -- Layout widget
    local layoutbox_w = awful.widget.layoutbox(s)

    layoutbox_w:buttons(gears.table.join(
        awful.button({}, 1, function()
            awful.layout.inc(1)
        end),
        awful.button({}, 2, function()
            awful.layout.set(awful.layout.layouts[1])
        end),
        awful.button({}, 3, function()
            awful.layout.inc(-1)
        end),
        awful.button({}, 4, function()
            awful.layout.inc(1)
        end),
        awful.button({}, 5, function()
            awful.layout.inc(-1)
        end)
    ))

    local taglist_w = awful.widget.taglist({
        screen = s,
        filter = awful.widget.taglist.filter.all,
        buttons = awful.util.taglist_buttons,
        style = {
            shape = gears.shape.circle,
        },
        layout = {
            spacing = 2,
            spacing_widget = {
                color = "#00000000",
                shape = gears.shape.rectangle,
                widget = wibox.widget.separator,
            },
            layout = wibox.layout.fixed.horizontal,
        },
        widget_template = {
            {
                {
                    {
                        id = "text",
                        widget = wibox.widget.textbox,
                    },
                    layout = wibox.layout.fixed.horizontal,
                },
                left = dpi(4),
                right = dpi(4),
                widget = wibox.container.margin,
            },
            id = "background_role",
            widget = wibox.container.background,
            inactive_bg = "#00000000",
            hover_bg = beautiful.taglist_bg_hover,

            create_callback = function(self, tag, index, objects)
                self:get_children_by_id("text")[1].markup = "<b>  </b>"
                self:connect_signal("mouse::enter", function()
                    self.bg = self.hover_bg
                    --if #tag:clients() > 0 then
                    ---- BLING: Update the widget with the new tag
                    --awesome.emit_signal("bling::tag_preview::update", tag)
                    ---- BLING: Show the widget
                    --awesome.emit_signal("bling::tag_preview::visibility", s, true)
                    --else
                    --awesome.emit_signal("bling::tag_preview::visibility", s, false)
                    --end
                end)
                self:connect_signal("mouse::leave", function()
                    if tag.selected then
                        self.bg = beautiful.taglist_bg_focus
                    elseif #tag:clients() > 0 then
                        self.bg = beautiful.taglist_bg_occupied
                    else
                        self.bg = self.inactive_bg
                    end

                    --awesome.emit_signal("bling::tag_preview::visibility", s, false)
                end)
                self:update_callback(tag, index, objects)
            end,
            ---@diagnostic disable-next-line: unused-local
            update_callback = function(self, tag, index, objects)
                if tag.selected then
                    self:get_children_by_id("text")[1].markup = "<b>  </b>"
                    self.bg = beautiful.taglist_bg_focus
                elseif #tag:clients() > 0 then
                    self:get_children_by_id("text")[1].markup = "<b>  </b>"
                    self.bg = beautiful.taglist_bg_occupied
                else
                    self:get_children_by_id("text")[1].markup =
                        "<span color='#a89984'><b>  </b></span>"
                    self.bg = self.inactive_bg
                end
            end,
        },
    })
    -- local tasklist_w = awful.widget.tasklist({
    --     screen = s,
    --     filter = awful.widget.tasklist.filter.currenttags,
    --     buttons = awful.util.tasklist_buttons,
    --     layout = {
    --         spacing = 10,
    --         layout = wibox.layout.flex.horizontal,
    --     },
    --     widget_template = {
    --         {
    --             {
    --                 {
    --                     {
    --                         id = "icon_role",
    --                         widget = wibox.widget.imagebox,
    --                     },
    --                     margins = 2,
    --                     widget = wibox.container.margin,
    --                 },
    --                 {
    --                     id = "text_role",
    --                     widget = wibox.widget.textbox,
    --                 },
    --                 layout = wibox.layout.fixed.horizontal,
    --             },
    --             left = 10,
    --             right = 10,
    --             widget = wibox.container.margin,
    --         },
    --         id = "background_role",
    --         bg = beautiful.tasklist_bg_focus,
    --         widget = wibox.container.background,
    --
    --         --@diagnostic disable-next-line: unused-local
    --         create_callback = function(self, task, index, objects)
    --             self:connect_signal("mouse::enter", function()
    --                 if client.focus == task then
    --                     self.bg = beautiful.tasklist_bg_hover
    --                 elseif task.minimized then
    --                     self.bg = beautiful.tasklist_bg_hover
    --                 else
    --                     self.bg = beautiful.tasklist_bg_hover
    --                 end
    --             end)
    --             self:connect_signal("mouse::leave", function()
    --                 if client.focus == task then
    --                     self.bg = beautiful.tasklist_bg_focus
    --                 elseif task.minimized then
    --                     self.bg = beautiful.tasklist_bg_minimize
    --                 else
    --                     self.bg = beautiful.tasklist_bg_normal
    --                 end
    --             end)
    --         end,
    --         --@diagnostic disable-next-line: unused-local
    --         update_callback = function(self, task, index, objects)
    --             local text_widget = self:get_children_by_id("text_role")[1]
    --             if task.minimized then
    --                 text_widget.visible = false
    --             else
    --                 text_widget.visible = true
    --             end
    --         end,
    --     },
    -- })
    --
    local wibox_bar = awful.wibar({
        screen = s,
        position = "top",
        type = "desktop",
        height = 24,
        ontop = true,
        bg = beautiful.wibar_bg,
    })

    wibox_bar:setup({
        widget = wibox.container.margin,
        left = dpi(4),
        right = dpi(4),
        top = dpi(4),
        bottom = dpi(4),
        {
            layout = wibox.layout.align.horizontal,
            expand = "outside",
            { -- Left widget
                {
                    hostname_w.widget,
                    layoutbox_w,

                    spacing = dpi(5),
                    layout = wibox.layout.fixed.horizontal,
                },
                shape = gears.shape.rectangle,
                widget = wibox.container.background,
            },
            {
                {
                    taglist_w,
                    layout = wibox.layout.fixed.horizontal,
                },
                left = dpi(8),
                right = dpi(8),
                widget = wibox.container.margin,
            },
            {
                {
                    layout = wibox.layout.align.horizontal,
                    nil,
                    nil,
                    {
                        -- systray_w,
                        audio_w.widget,
                        brightness_w.widget,
                        battery_w.widget,
                        date_w,
                        time_w,
                        power_w,

                        spacing = dpi(5),
                        layout = wibox.layout.fixed.horizontal,
                    },
                },
                shape = gears.shape.rectangle,
                widget = wibox.container.background,
            },
        },
    })

    local function change_wibox_visibility(client)
        if client.screen == s then
            wibox_bar.ontop = not client.fullscreen
        end
    end

    client.connect_signal("property::fullscreen", change_wibox_visibility)
    client.connect_signal("focus", change_wibox_visibility)
    s.wibox = wibox_bar

    -- s.dock = widgets.dock({
    --     screen = s,
    -- })
    -- s.sidebar = sidebar
end

return {
    screen_decoration = screen_decoration,
}

-- vim: shiftwidth=4: tabstop=4
