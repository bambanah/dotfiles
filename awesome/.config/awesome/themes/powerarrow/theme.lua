local gears = require("gears")
local lain = require("lain")
local awful = require("awful")
local wibox = require("wibox")

local beautiful = require("beautiful")
local xrdb = beautiful.xresources.get_current_theme()

-- Assign xresources colours
x = {
  bg = xrdb.color0,
  fg = xrdb.color7,
  color0 = xrdb.color0,
  color1 = xrdb.color1,
  color2 = xrdb.color2,
  color3 = xrdb.color3,
  color4 = xrdb.color4,
  color5 = xrdb.color5,
  color6 = xrdb.color6,
  color7 = xrdb.color7,
  color8 = xrdb.color8,
  color9 = xrdb.color9,
  color10 = xrdb.color10,
  color11 = xrdb.color11,
  color12 = xrdb.color12,
  color13 = xrdb.color13,
  color14 = xrdb.color14,
  color15 = xrdb.color15
}

local math, string, os = math, string, os
local my_table = awful.util.table or gears.table -- 4.{0,1} compatibility

-- Initialise theme
local theme = {}
theme.dir = os.getenv("HOME") .. "/.config/awesome/themes/powerarrow"

-- Fonts
theme.font = "Iosevka Nerd Font Regular 11"
theme.bar_height = 25

-- Base colours
theme.fg_normal = x.fg
theme.fg_focus = x.color2 -- "#7b88d3"
theme.fg_urgent = "#b74822"
theme.bg_normal = x.bg
theme.bg_focus = "#1E2320"
theme.bg_urgent = "#3F3F3F"

-- Right click menu
theme.menu_height = 18
theme.menu_width = 140

-- Notifications
theme.notificaion_width = 1000

-- Taglist (workspaces)
theme.taglist_font = "Noto Sans Regular 11"
theme.taglist_fg_focus = x.bg -- "#7b88d3"
theme.taglist_bg_focus = x.fg

-- Borders
theme.border_width = 2
theme.border_normal = x.bg -- "#3F3F3F"
theme.border_focus = x.color5 -- "#6F6F6F"
theme.border_marked = "#CC9393"

-- Titlebar
theme.titlebar_bg_focus = "#3F3F3F"
theme.titlebar_bg_normal = "#3F3F3F"
theme.titlebar_bg_focus = theme.bg_focus
theme.titlebar_bg_normal = theme.bg_normal
theme.titlebar_fg_focus = theme.fg_focus



-- Tasklist
theme.tasklist_bg_focus = "#222222"
theme.tasklist_fg_focus = "#7b88d3"
theme.tasklist_plain_task_name = true
theme.tasklist_disable_icon = true

-- Gaps
theme.useless_gap = 5

-- Icons
theme.menu_submenu_icon = theme.dir .. "/icons/submenu.png"
theme.awesome_icon = theme.dir .. "/icons/awesome.png"
theme.taglist_squares_sel = theme.dir .. "/icons/square_sel.png"
theme.taglist_squares_unsel = theme.dir .. "/icons/square_unsel.png"

-- Layout Icons
theme.layout_tile = theme.dir .. "/icons/tile.png"
theme.layout_tileleft = theme.dir .. "/icons/tileleft.png"
theme.layout_tilebottom = theme.dir .. "/icons/tilebottom.png"
theme.layout_tiletop = theme.dir .. "/icons/tiletop.png"
theme.layout_fairv = theme.dir .. "/icons/fairv.png"
theme.layout_fairh = theme.dir .. "/icons/fairh.png"
theme.layout_spiral = theme.dir .. "/icons/spiral.png"
theme.layout_dwindle = theme.dir .. "/icons/dwindle.png"
theme.layout_max = theme.dir .. "/icons/max.png"
theme.layout_fullscreen = theme.dir .. "/icons/fullscreen.png"
theme.layout_magnifier = theme.dir .. "/icons/magnifier.png"
theme.layout_floating = theme.dir .. "/icons/floating.png"

-- Widget Icons
theme.widget_ac = theme.dir .. "/icons/ac.png"
theme.widget_battery = theme.dir .. "/icons/battery.png"
theme.widget_battery_low = theme.dir .. "/icons/battery_low.png"
theme.widget_battery_empty = theme.dir .. "/icons/battery_empty.png"
theme.widget_mem = theme.dir .. "/icons/mem.png"
theme.widget_cpu = theme.dir .. "/icons/cpu.png"
theme.widget_temp = theme.dir .. "/icons/temp.png"
theme.widget_net = theme.dir .. "/icons/net.png"
theme.widget_hdd = theme.dir .. "/icons/hdd.png"
theme.widget_music = theme.dir .. "/icons/note.png"
theme.widget_music_on = theme.dir .. "/icons/note.png"
theme.widget_music_pause = theme.dir .. "/icons/pause.png"
theme.widget_music_stop = theme.dir .. "/icons/stop.png"
theme.widget_vol = theme.dir .. "/icons/vol.png"
theme.widget_vol_low = theme.dir .. "/icons/vol_low.png"
theme.widget_vol_no = theme.dir .. "/icons/vol_no.png"
theme.widget_vol_mute = theme.dir .. "/icons/vol_mute.png"
theme.widget_mail = theme.dir .. "/icons/mail.png"
theme.widget_mail_on = theme.dir .. "/icons/mail_on.png"
theme.widget_task = theme.dir .. "/icons/task.png"
theme.widget_scissors = theme.dir .. "/icons/scissors.png"
theme.widget_weather = theme.dir .. "/icons/dish.png"

-- Titlebar Icons
theme.titlebar_close_button_focus = theme.dir .. "/icons/titlebar/close_focus.png"
theme.titlebar_close_button_normal = theme.dir .. "/icons/titlebar/close_normal.png"
theme.titlebar_ontop_button_focus_active = theme.dir .. "/icons/titlebar/ontop_focus_active.png"
theme.titlebar_ontop_button_normal_active = theme.dir .. "/icons/titlebar/ontop_normal_active.png"
theme.titlebar_ontop_button_focus_inactive = theme.dir .. "/icons/titlebar/ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_inactive = theme.dir .. "/icons/titlebar/ontop_normal_inactive.png"
theme.titlebar_sticky_button_focus_active = theme.dir .. "/icons/titlebar/sticky_focus_active.png"
theme.titlebar_sticky_button_normal_active = theme.dir .. "/icons/titlebar/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_inactive = theme.dir .. "/icons/titlebar/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_inactive = theme.dir .. "/icons/titlebar/sticky_normal_inactive.png"
theme.titlebar_floating_button_focus_active = theme.dir .. "/icons/titlebar/floating_focus_active.png"
theme.titlebar_floating_button_normal_active = theme.dir .. "/icons/titlebar/floating_normal_active.png"
theme.titlebar_floating_button_focus_inactive = theme.dir .. "/icons/titlebar/floating_focus_inactive.png"
theme.titlebar_floating_button_normal_inactive = theme.dir .. "/icons/titlebar/floating_normal_inactive.png"
theme.titlebar_maximized_button_focus_active = theme.dir .. "/icons/titlebar/maximized_focus_active.png"
theme.titlebar_maximized_button_normal_active = theme.dir .. "/icons/titlebar/maximized_normal_active.png"
theme.titlebar_maximized_button_focus_inactive = theme.dir .. "/icons/titlebar/maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_inactive = theme.dir .. "/icons/titlebar/maximized_normal_inactive.png"

local markup = lain.util.markup
local separators = lain.util.separators


-- Textclock
local clockicon = wibox.widget.imagebox(markup(theme.bg_normal, theme.widget_clock))
local clock = awful.widget.watch(
  "date +'%a %d %b %R'", 60,
  function(widget, stdout)
    widget:set_markup(" " .. markup.font(theme.font, markup(theme.bg_normal, stdout)))
  end
)

-- Calendar
theme.cal = lain.widget.cal({
  attach_to = { clock },
  notification_preset = {
    font = "Noto Sans Mono Medium 10",
    fg = theme.fg_normal,
    bg = theme.bg_normal
  }
})


-- ALSA volume
theme.volume = lain.widget.alsabar({
  --togglechannel = "IEC958,3",
  notification_preset = { font = theme.font, fg = theme.fg_normal },
})

-- MPD
local musicplr = "urxvt -title Music -g 130x34-320+16 -e ncmpcpp"
local mpdicon = wibox.widget.imagebox(theme.widget_music)
mpdicon:buttons(my_table.join(
  awful.button({ modkey }, 1, function () awful.spawn.with_shell(musicplr) end),
  --[[awful.button({ }, 1, function ()
        awful.spawn.with_shell("mpc prev")
        theme.mpd.update()
    end),
    --]]
  awful.button({ }, 2, function ()
    awful.spawn.with_shell("mpc toggle")
    theme.mpd.update()
  end),
  awful.button({ modkey }, 3, function () awful.spawn.with_shell("pkill ncmpcpp") end),
  awful.button({ }, 3, function ()
    awful.spawn.with_shell("mpc stop")
    theme.mpd.update()
  end)))
  theme.mpd = lain.widget.mpd({
    settings = function()
    if mpd_now.state == "play" then
      artist = " " .. mpd_now.artist .. " "
      title = mpd_now.title .. " "
      mpdicon:set_image(theme.widget_music_on)
      widget:set_markup(markup.font(theme.font, markup("#FFFFFF", artist) .. " " .. title))
    elseif mpd_now.state == "pause" then
      widget:set_markup(markup.font(theme.font, " mpd paused "))
      mpdicon:set_image(theme.widget_music_pause)
    else
      widget:set_text("")
      mpdicon:set_image(theme.widget_music)
    end
  end
})

-- ALSA volume
-- local volicon = wibox.widget.imagebox(theme.widget_vol)
theme.volume = lain.widget.alsa({
  settings = function()
  local vol_icon = ""
  if volume_now.status == "off" then
    vol_icon = "婢"
  elseif tonumber(volume_now.level) == 0 then
    vol_icon = "奄"
  elseif tonumber(volume_now.level) <= 50 then
    -- volicon:set_image(theme.widget_vol_low)
    vol_icon = "奔"
  else
    vol_icon = "墳"
  end

  widget:set_markup(markup.fontfg(theme.font, theme.bg_normal, " " .. vol_icon .. " ".. volume_now.level .. "% "))
end
})

-- Net
-- local neticon = wibox.widget.imagebox(theme.widget_net)
local net = lain.widget.net({
settings = function()
widget:set_markup(markup.fontfg(theme.font, theme.bg_normal, " 直  " .. net_now.received .. " ↓↑ " .. net_now.sent .. " "))
end
})


function theme.at_screen_connect(s)
-- Quake application
-- s.quake = lain.util.quake({ app = awful.util.terminal })
s.quake = lain.util.quake({ app = "termite", height = 0.50, argname = "--name %s" })



-- If wallpaper is a function, call it with the screen
local wallpaper = theme.wallpaper
if type(wallpaper) == "function" then
wallpaper = wallpaper(s)
end
gears.wallpaper.maximized(wallpaper, s, true)

-- All tags open with layout 1
awful.tag(awful.util.tagnames, s, awful.layout.layouts[1])

-- Create a promptbox for each screen
s.mypromptbox = awful.widget.prompt()
-- Create an imagebox widget which will contains an icon indicating which layout we're using.
-- We need one layoutbox per screen.
s.mylayoutbox = awful.widget.layoutbox(s)
s.mylayoutbox:buttons(my_table.join(
awful.button({ }, 1, function () awful.layout.inc( 1) end),
awful.button({ }, 3, function () awful.layout.inc(-1) end),
awful.button({ }, 4, function () awful.layout.inc( 1) end),
awful.button({ }, 5, function () awful.layout.inc(-1) end)))
-- Create a taglist widget
s.mytaglist = awful.widget.taglist(s, awful.widget.taglist.filter.all, awful.util.taglist_buttons)

-- Create a tasklist widget
--s.mytasklist = awful.widget.tasklist(s, awful.widget.tasklist.filter.currenttags, awful.util.tasklist_buttons)

-- Create the wibox
s.mywibox = awful.wibar({ position = "top", screen = s, height = theme.bar_height, bg = theme.bg_normal, fg = theme.fg_normal })

-- Add widgets to the wibox
s.mywibox:setup {
layout = wibox.layout.align.horizontal,
{ -- Left widgets
  layout = wibox.layout.fixed.horizontal,
  --spr,
  s.mytaglist,
  spr,
},
s.mytasklist, -- Middle widget
{ -- Right widgets
  layout = wibox.layout.fixed.horizontal,
  wibox.widget.systray(),
  wibox.container.background(wibox.container.margin(wibox.widget { mpdicon, theme.mpd.widget, layout = wibox.layout.align.horizontal }, 3, 6), x.color4),
  wibox.container.background(wibox.container.margin(wibox.widget { volicon, theme.volume.widget, layout = wibox.layout.align.horizontal }, 2, 3), x.color5),
  -- wibox.container.background(wibox.container.margin(wibox.widget { nil, neticon, net.widget, layout = wibox.layout.align.horizontal }, 3, 3), x.color6),
  wibox.container.background(wibox.container.margin(clock, 4, 8), x.color6),
  s.mylayoutbox,
},
}
end

return theme
