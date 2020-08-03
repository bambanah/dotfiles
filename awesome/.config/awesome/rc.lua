local awesome, client, mouse, screen, tag = awesome, client, mouse, screen, tag
local ipairs, string, os, table, tostring, tonumber, type = ipairs, string, os, table, tostring, tonumber, type

-- Standard awesome library
local gears = require("gears") --Utilities such as color parsing and objects
local awful = require("awful") --Everything related to window managment
require("awful.autofocus")
-- Widget and layout library
local wibox = require("wibox")

-- Theme handling library
local beautiful = require("beautiful")

-- Notification library
local naughty = require("naughty")
naughty.config.defaults['icon_size'] = 100

local lain = require("lain")
local freedesktop = require("freedesktop")

-- Custom Imports
local keys = require("keys")

-- Enable hotkeys help widget for VIM and other apps
-- when client with a matching name is opened:
local hotkeys_popup = require("awful.hotkeys_popup").widget
require("awful.hotkeys_popup.keys")
local my_table = awful.util.table or gears.table -- 4.{0,1} compatibility

if awesome.startup_errors then
  naughty.notify({ preset = naughty.config.presets.critical,
    title = "Oops, there were errors during startup!",
  text = awesome.startup_errors })
end

-- Handle runtime errors after startup
do
  local in_error = false
  awesome.connect_signal("debug::error", function (err)
    -- Make sure we don't go into an endless error loop
    if in_error then return end
    in_error = true

    naughty.notify({ preset = naughty.config.presets.critical,
      title = "Oops, an error happened!",
    text = tostring(err) })
    in_error = false
  end)
end

local function run_once(cmd_arr)
  for _, cmd in ipairs(cmd_arr) do
    awful.spawn.with_shell(string.format("pgrep -u $USER -fx '%s' > /dev/null || (%s)", cmd, cmd))
  end
end

run_once({ "unclutter -root" }) -- entries must be comma-separated

local themes = {
  "powerarrow", -- 1
}

-- choose your theme here
local chosen_theme = themes[1]
local theme_path = string.format("%s/.config/awesome/themes/%s/theme.lua", os.getenv("HOME"), chosen_theme)
beautiful.init(theme_path)

local modkey = "Mod4"
local altkey = "Mod1"
local modkey1 = "Control"

-- personal variables
local config = require("config")

-- awesome variables
awful.util.terminal = config.terminal
-- awful.util.tagnames = {  " ", " ", " ", " ", " ", " ", " ", " ", " ", " "  }
awful.util.tagnames = { " 1 ", " 2 ", " 3 ", " 4", " 5 ", " 6 ", " 7 ", " 8 ", " 9 " }
awful.layout.suit.tile.left.mirror = true
awful.layout.layouts = {
  awful.layout.suit.tile,
  awful.layout.suit.floating,
}

awful.util.taglist_buttons = my_table.join(
  awful.button({ }, 1, function(t) t:view_only() end),
  awful.button({ modkey }, 1, function(t)
    if client.focus then
    client.focus:move_to_tag(t)
  end
end),
awful.button({ }, 3, awful.tag.viewtoggle),
awful.button({ modkey }, 3, function(t)
  if client.focus then
  client.focus:toggle_tag(t)
end
end),
awful.button({ }, 4, function(t) awful.tag.viewprev(t.screen) end),
awful.button({ }, 5, function(t) awful.tag.viewnext(t.screen) end)
)

awful.util.tasklist_buttons = my_table.join(
awful.button({ }, 1, function (c)
if c == client.focus then
c.minimized = true
else
c:emit_signal("request::activate", "tasklist", {raise = true})
end
end),
awful.button({ }, 3, function ()
local instance = nil

return function ()
if instance and instance.wibox.visible then
  instance:hide()
  instance = nil
else
  instance = awful.menu.clients({theme = {width = 250}})
end
end
end),
awful.button({ }, 4, function () awful.client.focus.byidx(1) end),
awful.button({ }, 5, function () awful.client.focus.byidx(-1) end)
)

lain.layout.termfair.nmaster = 3
lain.layout.termfair.ncol = 1
lain.layout.termfair.center.nmaster = 3
lain.layout.termfair.center.ncol = 1
lain.layout.cascade.tile.offset_x = 2
lain.layout.cascade.tile.offset_y = 32
lain.layout.cascade.tile.extra_padding = 5
lain.layout.cascade.tile.nmaster = 5
lain.layout.cascade.tile.ncol = 2

beautiful.init(string.format(gears.filesystem.get_configuration_dir() .. "/themes/%s/theme.lua", chosen_theme))

local myawesomemenu = {
{ "hotkeys", function() return false, hotkeys_popup.show_help end },
{ "manual", config.terminal .. " -e 'man awesome'" },
{ "edit config", config.terminal.." vim /home/dt/.config/awesome/rc.lua" },
{ "arandr", "arandr" },
{ "restart", awesome.restart },
}

awful.util.mymainmenu = freedesktop.menu.build({
icon_size = beautiful.menu_height or 16,
before = {
{ "Awesome", myawesomemenu, beautiful.awesome_icon },
-- { "Atom", "atom" },
-- other triads can be put here
},
after = {
{ "Terminal", config.terminal },
{ "Log out", function() awesome.quit() end },
{ "Sleep", "systemctl suspend" },
{ "Restart", "systemctl reboot" },
{ "Exit", "systemctl poweroff" },
-- other triads can be put here
}
})
--menubar.utils.terminal = terminal -- Set the Menubar terminal for applications that require it

-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal("property::geometry", function(s)
-- Wallpaper
if beautiful.wallpaper then
local wallpaper = beautiful.wallpaper
-- If wallpaper is a function, call it with the screen
if type(wallpaper) == "function" then
wallpaper = wallpaper(s)
end
gears.wallpaper.maximized(wallpaper, s, true)
end
end)
-- Create a wibox for each screen and add it
awful.screen.connect_for_each_screen(function(s) beautiful.at_screen_connect(s) end)

root.buttons(my_table.join(
awful.button({ }, 3, function () awful.util.mymainmenu:toggle() end),
awful.button({ }, 4, awful.tag.viewprev),
awful.button({ }, 5, awful.tag.viewnext)
))

-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {
-- All clients will match this rule.
{ rule = { },
properties = { border_width = beautiful.border_width,
border_color = beautiful.border_normal,
focus = awful.client.focus.filter,
raise = true,
keys = keys.clientkeys,
buttons = keys.clientbuttons,
screen = awful.screen.preferred,
placement = awful.placement.no_overlap + awful.placement.no_offscreen,
size_hints_honor = false
}
},

-- Titlebars
{ rule_any = { type = { "dialog", "normal" } },
properties = { titlebars_enabled = false } },

-- Set applications to always map on the tag 1 on screen 1.
-- find class or role via xprop command
--{ rule = { class = browser1 },
--properties = { screen = 1, tag = awful.util.tagnames[1] } },

--{ rule = { class = editorgui },
--properties = { screen = 1, tag = awful.util.tagnames[2] } },

--{ rule = { class = "Geany" },
--properties = { screen = 1, tag = awful.util.tagnames[2] } },

-- Set applications to always map on the tag 3 on screen 1.
--{ rule = { class = "Inkscape" },
--properties = { screen = 1, tag = awful.util.tagnames[3] } },

-- Set applications to always map on the tag 4 on screen 1.
--{ rule = { class = "Gimp" },
--properties = { screen = 1, tag = awful.util.tagnames[4] } },

-- Set applications to be maximized at startup.
-- find class or role via xprop command

{ rule = { class = config.editorgui },
properties = { maximized = true } },

{ rule = { class = "Gimp*", role = "gimp-image-window" },
properties = { maximized = true } },

{ rule = { class = "inkscape" },
properties = { maximized = true } },

{ rule = { class = config.mediaplayer },
properties = { maximized = true } },

{ rule = { class = "Vlc" },
properties = { maximized = true } },

{ rule = { class = "VirtualBox Manager" },
properties = { maximized = true } },

{ rule = { class = "VirtualBox Machine" },
properties = { maximized = true } },

{ rule = { class = "Xfce4-settings-manager" },
properties = { floating = false } },



-- Floating clients.
{ rule_any = {
instance = {
"DTA", -- Firefox addon DownThemAll.
"copyq", -- Includes session name in class.
},
class = {
"Arandr",
"Blueberry",
"Galculator",
"Gnome-font-viewer",
"Gpick",
"Imagewriter",
"Font-manager",
"Kruler",
"MessageWin", -- kalarm.
"Oblogout",
"Peek",
"Skype",
"System-config-printer.py",
"Sxiv",
"Unetbootin.elf",
"Wpa_gui",
"pinentry",
"veromix",
"xtightvncviewer"},

name = {
"Event Tester", -- xev.
},
role = {
"AlarmWindow", -- Thunderbird's calendar.
"pop-up", -- e.g. Google Chrome's (detached) Developer Tools.
"Preferences",
"setup",
}
}, properties = { floating = true }},

}

-- Signal function to execute when a new client appears.
client.connect_signal("manage", function (c)
-- Set the windows at the slave,
-- i.e. put it at the end of others instead of setting it master.
-- if not awesome.startup then awful.client.setslave(c) end

if awesome.startup and
not c.size_hints.user_position
and not c.size_hints.program_position then
-- Prevent clients from being unreachable after screen count changes.
awful.placement.no_offscreen(c)
end
end)

-- Add a titlebar if titlebars_enabled is set to true in the rules.
client.connect_signal("request::titlebars", function(c)
-- Custom
if beautiful.titlebar_fun then
beautiful.titlebar_fun(c)
return
end

-- Default
-- buttons for the titlebar
local buttons = my_table.join(
awful.button({ }, 1, function()
c:emit_signal("request::activate", "titlebar", {raise = true})
awful.mouse.client.move(c)
end),
awful.button({ }, 3, function()
c:emit_signal("request::activate", "titlebar", {raise = true})
awful.mouse.client.resize(c)
end)
)

awful.titlebar(c, {size = 21}) : setup {
{ -- Left
awful.titlebar.widget.iconwidget(c),
buttons = buttons,
layout = wibox.layout.fixed.horizontal
},
{ -- Middle
{ -- Title
align = "center",
widget = awful.titlebar.widget.titlewidget(c)
},
buttons = buttons,
layout = wibox.layout.flex.horizontal
},
{ -- Right
awful.titlebar.widget.floatingbutton (c),
awful.titlebar.widget.maximizedbutton(c),
awful.titlebar.widget.stickybutton (c),
awful.titlebar.widget.ontopbutton (c),
awful.titlebar.widget.closebutton (c),
layout = wibox.layout.fixed.horizontal()
},
layout = wibox.layout.align.horizontal
}
end)

-- No border for maximized clients
function border_adjust(c)
  if c.maximized then -- no borders if only 1 client visible
    c.border_width = beautiful.border_width
    c.border_color = beautiful.border_focus
  elseif #awful.screen.focused().clients > 1 then
    c.border_width = beautiful.border_width
    c.border_color = beautiful.border_focus
  end
end

-- turn titlebar on when client is floating
-------------------------------------------------------------------------------
client.connect_signal("property::floating", function(c)
if c.floating and not c.requests_no_titlebar then
awful.titlebar.show(c)
else
awful.titlebar.hide(c)
end
end)

-- turn tilebars on when layout is floating
-------------------------------------------------------------------------------
awful.tag.attached_connect_signal(nil, "property::layout", function (t)
local float = t.layout.name == "floating"
for _, c in pairs(t:clients()) do
c.floating = float
end
end)

-- client.connect_signal("focus", border_adjust)
client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
-- client.connect_signal("property::maximized", border_adjust)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)

-- awful.spawn.with_shell("wal -R")
awful.spawn.with_shell("~/.fehbg")
awful.spawn.with_shell("wm.start_composite")
awful.spawn.with_shell("nm-applet")
awful.spawn.with_shell("volumeicon")
