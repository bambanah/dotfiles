local awful = require("awful")
local naughty = require("naughty")
local gears = require("gears")
local beautiful = require("beautiful")
-- local apps = require("apps")
-- local decorations = require("decorations")

local config = require("config")

-- local helpers = require("helpers")
local hotkeys_popup = require("awful.hotkeys_popup")

local keys = {}

superkey = "Mod4"
altkey = "Mod1"
ctrlkey = "Control"
shiftkey = "Shift"

-- {{{ Mouse Bindings
keys.mousebuttons = gears.table.join(
  awful.button({ }, 3, function () mymainmenu:toggle() end),
  awful.button({ }, 4, awful.tag.viewprev),
  awful.button({ }, 5, awful.tag.viewnext)
)
-- }}}


-- {{{ Global Bindings
keys.globalkeys = gears.table.join(
  --
  -- Globals
  --

  -- Media
  awful.key({ }, "XF86AudioRaiseVolume",
    function ()
      os.execute(string.format("amixer -q set %s 3%%+", beautiful.volume.channel))
      beautiful.volume.update()
  end),
  awful.key({ }, "XF86AudioLowerVolume",
    function ()
      os.execute(string.format("amixer -q set %s 3%%-", beautiful.volume.channel))
      beautiful.volume.update()
  end),
  awful.key({ }, "XF86AudioMute",
    function ()
      os.execute(string.format("amixer -q set %s toggle", beautiful.volume.togglechannel or beautiful.volume.channel))
  end),
  awful.key({ }, "XF86AudioPlay",
    function ()
      os.execute("playerctl play-pause")
  end),
  awful.key({ }, "XF86AudioPrev",
    function ()
      os.execute("playerctl previous")
  end),
  awful.key({ }, "XF86AudioNext",
    function ()
      os.execute("playerctl next")
  end),

  -- Miscellaneous
  awful.key({ superkey, }, "u", awful.client.urgent.jumpto,
  {description = "jump to urgent client", group = "client"}),

  -- Awesome
  awful.key({ superkey, }, "s", hotkeys_popup.show_help,
  {description = "show help", group = "awesome"}),
  awful.key({ superkey, ctrlkey}, "r", awesome.restart,
  {description = "reload awesome", group = "awesome"}),
  awful.key({ superkey, altkey }, "Escape", awesome.quit,
  {description = "quit awesome", group = "awesome"}),

  -- Launchers
  awful.key({ superkey }, "space", function () awful.util.spawn("rofi -show run") end,
  {description = "run prompt", group = "launcher"}),
  awful.key({ superkey }, "Return", function () awful.spawn(config.terminal) end,
  {description = "open a terminal", group = "launcher"}),
  awful.key({ superkey, shiftkey}, "Return", function () awful.util.spawn("dmenu_run") end,
  {description = "run dmenu", group = "launcher"}),

  awful.key({ superkey }, "w", function () awful.spawn(config.browser) end,
  {description = "open browser", group = "launcher"}),

  -- Cycle tags
  awful.key({ superkey, }, "[", awful.tag.viewprev,
  {description = "view previous", group = "tag"}),
  awful.key({ superkey, }, "]", awful.tag.viewnext,
  {description = "view next", group = "tag"}),

  -- Cycle clients
  awful.key({ superkey }, "z",
    function ()
      awful.client.focus.byidx(1)
    end,
  {description = "focus next by index", group = "client"}),
  awful.key({ superkey, shiftkey }, "z",
    function ()
      awful.client.focus.byidx(-1)
    end,
  {description = "focus next by index", group = "client"}),

  -- Cycle screens
  awful.key({ superkey, shiftkey }, "z", function () awful.screen.focus_relative( 1) end,
  {description = "focus the next screen", group = "screen"}),

  -- Focus client by direction (hjkl)
  awful.key({ superkey }, "h",
    function ()
      awful.client.focus.global_bydirection("left")
    end,
    {description = "focus left", group = "client"}
  ),
  awful.key({ superkey }, "j",
    function ()
      awful.client.focus.global_bydirection("down")
    end,
    {description = "focus down", group = "client"}
  ),
  awful.key({ superkey, }, "k",
    function ()
      awful.client.focus.global_bydirection("up")
    end,
    {description = "focus up", group = "client"}
  ),
  awful.key({ superkey }, "l",
    function ()
      awful.client.focus.global_bydirection("right")
    end,
    {description = "focus right", group = "client"}
  ),

  -- Focus client by direction (arrow keys)
  awful.key({ superkey }, "Down",
    function()
      awful.client.focus.global_bydirection("down")
    end,
  {description = "focus down", group = "client"}),
  awful.key({ superkey }, "Up",
    function()
      awful.client.focus.global_bydirection("up")
    end,
  {description = "focus up", group = "client"}),
  awful.key({ superkey }, "Left",
    function()
      awful.client.focus.global_bydirection("left")
    end,
  {description = "focus left", group = "client"}),
  awful.key({ superkey }, "Right",
    function()
      awful.client.focus.global_bydirection("right")
    end,
  {description = "focus right", group = "client"}),




  --
  -- === Layout manipulation ===
  --

  -- Move client by direction (hjkl)
  awful.key({ superkey, shiftkey }, "h",
    function ()
      awful.client.swap.global_bydirection("left")
    end,
    {description = "move client left", group = "client"}
  ),
  awful.key({ superkey, shiftkey }, "j",
    function ()
      awful.client.swap.global_bydirection("down")
    end,
    {description = "move client down", group = "client"}
  ),
  awful.key({ superkey, shiftkey }, "k",
    function ()
      awful.client.swap.global_bydirection("up")
    end,
    {description = "move client up", group = "client"}
  ),
  awful.key({ superkey, shiftkey }, "l",
    function ()
      awful.client.swap.global_bydirection("right")
    end,
    {description = "move client right", group = "client"}
  ),

  -- Focus client by direction (arrow keys)
  awful.key({ superkey, shiftkey }, "Down",
    function()
      awful.client.swap.global_bydirection("down")
    end,
  {description = "move client down", group = "client"}),
  awful.key({ superkey, shiftkey }, "Up",
    function()
      awful.client.swap.global_bydirection("up")
    end,
  {description = "move client up", group = "client"}),
  awful.key({ superkey, shiftkey }, "Left",
    function()
      awful.client.swap.global_bydirection("left")
    end,
  {description = "move client left", group = "client"}),
  awful.key({ superkey, shiftkey }, "Right",
    function()
      awful.client.swap.global_bydirection("right")
    end,
  {description = "move client right", group = "client"}),

  --
  -- === Standard Programs ===
  --

  -- Standard program
  awful.key({ superkey, altkey }, "Right", function () awful.tag.incmwfact( 0.05) end,
  {description = "increase master width factor", group = "layout"}),
  awful.key({ superkey, altkey }, "Left", function () awful.tag.incmwfact(-0.05) end,
  {description = "decrease master width factor", group = "layout"}),

  awful.key({ superkey }, "t", function () awful.layout.inc(-1) end,
  {description = "select previous", group = "layout"}),

  -- awful.key({ superkey, ctrlkey }, "n",
  --   function ()
  --     local c = awful.client.restore()
  --     -- Focus restored client
  --     if c then
  --       c:emit_signal(
  --         "request::activate", "key.unminimize", {raise = true}
  --       )
  --     end
  --   end,
  -- {description = "restore minimized", group = "client"}),



  awful.key({ superkey }, "x",
    function ()
      awful.prompt.run {
        prompt = "Run Lua code: ",
        textbox = awful.screen.focused().mypromptbox.widget,
        exe_callback = awful.util.eval,
        history_path = awful.util.get_cache_dir() .. "/history_eval"
      }
    end,
  {description = "lua execute prompt", group = "awesome"}),
  -- Menubar
  awful.key({ superkey }, "p", function() menubar.show() end,
  {description = "show the menubar", group = "launcher"})
)

keys.clientkeys = gears.table.join(
  awful.key({ superkey, }, "f",
    function (c)
      c.fullscreen = not c.fullscreen
      c:raise()
    end,
  {description = "toggle fullscreen", group = "client"}),
  awful.key({ superkey, }, "q", function (c) c:kill() end,
  {description = "close", group = "client"}),
  awful.key({ superkey, ctrlkey }, "space", awful.client.floating.toggle,
  {description = "toggle floating", group = "client"}),
  awful.key({ superkey, ctrlkey }, "Return", function (c) c:swap(awful.client.getmaster()) end,
  {description = "move to master", group = "client"}),
  awful.key({ superkey, }, "o", function (c) c:move_to_screen() end,
  {description = "move to screen", group = "client"}),
  awful.key({ superkey, }, "t", function (c) c.ontop = not c.ontop end,
  {description = "toggle keep on top", group = "client"}),
  awful.key({ superkey, }, "n",
    function (c)
      -- The client currently has the input focus, so it cannot be
      -- minimized, since minimized clients can't have the focus.
      c.minimized = true
    end,
  {description = "minimize", group = "client"}),
  awful.key({ superkey, }, "m",
    function (c)
      c.maximized = not c.maximized
      c:raise()
    end,
  {description = "(un)maximize", group = "client"}),
  awful.key({ superkey, ctrlkey }, "m",
    function (c)
      c.maximized_vertical = not c.maximized_vertical
      c:raise()
    end,
  {description = "(un)maximize vertically", group = "client"}),
  awful.key({ superkey, shiftkey }, "m",
    function (c)
      c.maximized_horizontal = not c.maximized_horizontal
      c:raise()
    end,
  {description = "(un)maximize horizontally", group = "client"})
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it work on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
local ntags = 6
for i = 1, ntags do
  keys.globalkeys = gears.table.join(keys.globalkeys,
    -- View tag only.
    awful.key({ superkey }, "#" .. i + 9,
      function ()
        local screen = awful.screen.focused()
        local tag = screen.tags[i]
        if tag then
          tag:view_only()
        end
      end,
    {description = "view tag #"..i, group = "tag"}),
    -- Toggle tag display.
    awful.key({ superkey, ctrlkey }, "#" .. i + 9,
      function ()
        local screen = awful.screen.focused()
        local tag = screen.tags[i]
        if tag then
          awful.tag.viewtoggle(tag)
        end
      end,
    {description = "toggle tag #" .. i, group = "tag"}),
    -- Move client to tag.
    awful.key({ superkey, shiftkey }, "#" .. i + 9,
      function ()
        if client.focus then
          local tag = client.focus.screen.tags[i]
          if tag then
            client.focus:move_to_tag(tag)
          end
        end
      end,
    {description = "move focused client to tag #"..i, group = "tag"}),
    -- Toggle tag on focused client.
    awful.key({ superkey, ctrlkey, shiftkey }, "#" .. i + 9,
      function ()
        if client.focus then
          local tag = client.focus.screen.tags[i]
          if tag then
            client.focus:toggle_tag(tag)
          end
        end
      end,
    {description = "toggle focused client on tag #" .. i, group = "tag"})
  )
end

-- Mouse buttons on the client (whole window, not just titlebar)
keys.clientbuttons = gears.table.join(
  awful.button({ }, 1, function (c)
    c:emit_signal("request::activate", "mouse_click", {raise = true})
  end),
  awful.button({ superkey }, 1, function (c)
    c:emit_signal("request::activate", "mouse_click", {raise = true})
    awful.mouse.client.move(c)
  end),
  awful.button({ superkey }, 3, function (c)
    c:emit_signal("request::activate", "mouse_click", {raise = true})
    awful.mouse.client.resize(c)
  end)
)

-- Mouse buttons on the tasklist
-- Use 'Any' modifier so that the same buttons can be used in the floating
-- tasklist displayed by the window switcher while the superkey is pressed
keys.tasklist_buttons = gears.table.join(
  awful.button({ 'Any' }, 1,
    function (c)
      if c == client.focus then
        c.minimized = true
      else
        -- Without this, the following
        -- :isvisible() makes no sense
        c.minimized = false
        if not c:isvisible() and c.first_tag then
          c.first_tag:view_only()
        end
        -- This will also un-minimize
        -- the client, if needed
        client.focus = c
      end
  end),
  -- Middle mouse button closes the window (on release)
  awful.button({ 'Any' }, 2, nil, function (c) c:kill() end),
  awful.button({ 'Any' }, 3, function (c) c.minimized = true end),
  awful.button({ 'Any' }, 4, function ()
    awful.client.focus.byidx(-1)
  end),
  awful.button({ 'Any' }, 5, function ()
    awful.client.focus.byidx(1)
  end),

  -- Side button up - toggle floating
  awful.button({ 'Any' }, 9, function(c)
    c.floating = not c.floating
  end),
  -- Side button down - toggle ontop
  awful.button({ 'Any' }, 8, function(c)
    c.ontop = not c.ontop
  end)
)

-- Mouse buttons on a tag of the taglist widget
keys.taglist_buttons = gears.table.join(
  awful.button({ }, 1, function(t)
    -- t:view_only()
    helpers.tag_back_and_forth(t.index)
  end),
  awful.button({ superkey }, 1, function(t)
    if client.focus then
    client.focus:move_to_tag(t)
  end
end),

-- awful.button({ }, 3, awful.tag.viewtoggle),
awful.button({ }, 3, function(t)
  if client.focus then
  client.focus:move_to_tag(t)
end
end),
awful.button({ superkey }, 3, function(t)
if client.focus then
client.focus:toggle_tag(t)
end
end),
awful.button({ }, 4, function(t) awful.tag.viewprev(t.screen) end),
awful.button({ }, 5, function(t) awful.tag.viewnext(t.screen) end)
)


-- Mouse buttons on the primary titlebar of the window
keys.titlebar_buttons = gears.table.join(
-- Left button - move
-- (Double tap - Toggle maximize) -- A little BUGGY
awful.button({ }, 1, function()
local c = mouse.object_under_pointer()
client.focus = c
awful.mouse.client.move(c)
-- local function single_tap()
--   awful.mouse.client.move(c)
-- end
-- local function double_tap()
--   gears.timer.delayed_call(function()
--       c.maximized = not c.maximized
--   end)
-- end
-- helpers.single_double_tap(single_tap, double_tap)
-- helpers.single_double_tap(nil, double_tap)
end),
-- Middle button - close
awful.button({ }, 2, function ()
local c = mouse.object_under_pointer()
c:kill()
end),
-- Right button - resize
awful.button({ }, 3, function()
local c = mouse.object_under_pointer()
client.focus = c
awful.mouse.client.resize(c)
-- awful.mouse.resize(c, nil, {jump_to_corner=true})
end),
-- Side button up - toggle floating
awful.button({ }, 9, function()
local c = mouse.object_under_pointer()
client.focus = c
--awful.placement.centered(c,{honor_padding = true, honor_workarea=true})
c.floating = not c.floating
end),
-- Side button down - toggle ontop
awful.button({ }, 8, function()
local c = mouse.object_under_pointer()
client.focus = c
c.ontop = not c.ontop
-- Double Tap - toggle sticky
-- local function single_tap()
--   c.ontop = not c.ontop
-- end
-- local function double_tap()
--   c.sticky = not c.sticky
-- end
-- helpers.single_double_tap(single_tap, double_tap)
end)
)

-- }}}

-- Set root (desktop) keys
root.keys(keys.globalkeys)
root.buttons(keys.mousebuttons)

return keys
