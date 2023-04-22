# Copyright (c) 2010 Aldo Cortesi
# Copyright (c) 2010, 2014 dequis
# Copyright (c) 2012 Randall Ma
# Copyright (c) 2012-2014 Tycho Andersen
# Copyright (c) 2012 Craig Barnes
# Copyright (c) 2013 horsik
# Copyright (c) 2013 Tao Sauvage
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

from libqtile import bar, layout, widget
from libqtile.config import Click, Drag, Group, Key, Match, Screen
from libqtile.lazy import lazy
from libqtile.utils import guess_terminal

from libqtile import hook
import subprocess
import os


# @hook.subscribe.startup
# def dbus_register():
#     id = os.environ.get('DESKTOP_AUTOSTART_ID')
#     if not id:
#         return
#     subprocess.Popen(['dbus-send',
#                       '--session',
#                       '--print-reply',
#                       '--dest=org.gnome.SessionManager',
#                       '/org/gnome/SessionManager',
#                       'org.gnome.SessionManager.RegisterClient',
#                       'string:qtile',
#                       'string:' + id])


@hook.subscribe.startup_once
def launch_apps():
    home = os.path.expanduser("~/.config/qtile/autostart.sh")
    subprocess.run([home])


mod = "mod4"
terminal = guess_terminal()

keys = [
    # A list of available commands that can be bound to keys can be found
    # at https://docs.qtile.org/en/latest/manual/config/lazy.html
    # Switch between windows
    # Key([mod], "h", lazy.layout.left(), desc="Move focus to left"),
    # Key([mod], "l", lazy.layout.right(), desc="Move focus to right"),
    Key([mod], "j", lazy.layout.down(), desc="Move focus down"),
    Key([mod], "k", lazy.layout.up(), desc="Move focus up"),
    # Key([mod], "space", lazy.layout.next(),
    #     desc="Move window focus to other window"),
    # Move windows between left/right columns or move up/down in current stack.
    # Moving out of range in Columns layout will create new column.
    # Key([mod, "shift"], "h", lazy.layout.shuffle_left(),
    #     desc="Move window to the left"),
    # Key([mod, "shift"], "l", lazy.layout.shuffle_right(),
    #     desc="Move window to the right"),
    Key(
        [mod, "shift"],
        "j",
        lazy.layout.shuffle_down(),
        desc="Move window down"
    ),
    Key([mod, "shift"], "k", lazy.layout.shuffle_up(), desc="Move window up"),
    # Grow windows. If current window is on the edge of screen and direction
    # will be to screen edge - window would shrink.
    Key([mod, "control"], "h", lazy.layout.grow_left(),
        desc="Grow window to the left"),
    Key([mod, "control"], "l", lazy.layout.grow_right(),
        desc="Grow window to the right"),
    Key(
        [mod, "control"],
        "j",
        lazy.layout.grow_down(),
        desc="Grow window down"
    ),
    Key([mod, "control"], "k", lazy.layout.grow_up(), desc="Grow window up"),
    Key([mod], "n", lazy.layout.normalize(), desc="Reset all window sizes"),
    Key([mod, "shift"], "f", lazy.layout.flip()),
    # Toggle between split and unsplit sides of stack.
    # Split = all windows displayed
    # Unsplit = 1 window displayed, like Max layout, but still with
    # multiple stack panes
    # Key(
    #     [mod, "shift"],
    #     "Return",
    #     lazy.layout.toggle_split(),
    #     desc="Toggle between split and unsplit sides of stack",
    # ),
    Key(
        [mod, "shift"],
        "Return",
        lazy.spawn(terminal),
        desc="Launch terminal"
    ),
    # Toggle between different layouts as defined below
    Key([mod], "Tab", lazy.next_layout(), desc="Toggle between layouts"),
    Key(
        [mod, "shift"],
        "Tab",
        lazy.prev_layout(),
        desc="Toggle between layouts"
    ),
    Key([mod, "shift"], "q", lazy.window.kill(), desc="Kill focused window"),
    Key([mod, "shift"], "r", lazy.reload_config(), desc="Reload the config"),
    Key([mod, "control"], "q", lazy.shutdown(), desc="Shutdown Qtile"),
    Key(
        [mod],
        "slash",
        lazy.spawn("rofi -show drun"),
        desc="Spawn a command using rofi"
    ),
    Key(
        [mod],
        "backslash",
        lazy.spawn("firefox"),
        desc="Spawn a command using rofi"
    ),
    Key(
        [mod, "shift"],
        "backslash",
        lazy.spawn("google-chrome-stable"),
        desc="Spawn a command using rofi"
    ),
    Key(
        [],
        "Print",
        lazy.spawn(
            "maim | xclip -selection clipboard -t image/png",
            shell=True
        ),
        desc="Take a full screenshot"
    ),
    Key(
        [mod, "shift"],
        "s",
        lazy.spawn(
            "maim -s | xclip -selection clipboard -t image/png",
            shell=True
        ),
        desc="Take a partial screenshot"
    ),
    Key(
        [],
        "XF86Calculator",
        lazy.spawn("alacritty -e python3"),
        desc="Spawn a python shell as calculator"
    ),
    Key(
        [],
        "XF86AudioRaiseVolume",
        lazy.spawn("pactl set-sink-volume @DEFAULT_SINK@ +2%"),
        desc="Increase volume"
    ),
    Key(
        [],
        "XF86AudioLowerVolume",
        lazy.spawn("pactl set-sink-volume @DEFAULT_SINK@ -2%"),
        desc="Decrease volume"
    ),
    Key(
        [],
        "XF86AudioMute",
        lazy.spawn("pactl set-sink-mute @DEFAULT_SINK@ toggle"),
        desc="Toggle volume mute"
    ),
    Key(
        [],
        "XF86AudioPlay",
        lazy.spawn("playerctl --player=spotify play-pause"),
        desc="Toggle play-pause media"
    ),
    Key(
        [],
        "XF86AudioPrev",
        lazy.spawn("playerctl previous"),
        desc="Go previous song"
    ),
    Key(
        [],
        "XF86AudioNext",
        lazy.spawn("playerctl next"),
        desc="Go next song"
    ),
]

# groups = [Group(i) for i in "聆阮ﭮ"]
# groups = [Group(i) for i in "123456789"]
groups = [
    Group("1", matches=[
          Match(wm_class=["Google-chrome", "firefox", "firefox-beta"])]),
    # Group("1", matches=[Match(wm_class=["Google-chrome"])]),
    Group("2"),
    Group("3"),
    Group("4"),
    Group("5"),
    Group("6"),
    Group("7"),
    # Group("7", matches=[Match(wm_class=["Slack"])]),
    Group("8", matches=[Match(wm_class=["Slack-Desktop-Firefox", "Slack"])]),
    Group("9", layout="max", matches=[Match(wm_class=["discord", "Spotify"])]),
]

for i, group in enumerate(groups):
    keys.extend(
        [
            # mod1 + letter of group = switch to group
            Key(
                [mod],
                str(i+1),
                lazy.group[group.name].toscreen(),
                desc="Switch to group {}".format(group.name),
            ),
            # mod1 + shift + letter of group =
            # switch to & move focused window to group
            Key(
                [mod, "shift"],
                str(i+1),
                lazy.window.togroup(group.name, switch_group=True),
                desc="Switch to & move focused window to group {}".format(
                    group.name),
            ),
            # Or, use below if you prefer not to switch to that group.
            # mod1 + shift + letter of group = move focused window to group
            # Key([mod, "shift"], str(i+1), lazy.window.togroup(group.name),
            #     desc="move focused window to group {}".format(group.name)),
        ]
    )
layout_defaults = dict(
    margin=10,
    border_normal="45475a",
    border_focus="b4befe",
    border_width=3
)

layouts = [
    # layout.Columns(
    #     border_focus_stack=["#d75f5f", "#8f3d3d"],
    #     border_width=4
    # ),
    # Try more layouts by unleashing below layouts.
    # layout.Stack(**layout_defaults),
    # layout.Bsp(**layout_defaults),
    # layout.Matrix(**layout_defaults),
    layout.MonadTall(**layout_defaults),
    layout.MonadWide(**layout_defaults),
    layout.RatioTile(**layout_defaults),
    layout.Tile(**layout_defaults),
    # layout.TreeTab(**layout_defaults),
    layout.VerticalTile(**layout_defaults),
    layout.Max(**layout_defaults),
    # layout.Zoomy(**layout_defaults),
]

widget_defaults = dict(
    font="JetBrainsMono Nerd Font",
    fontsize=12,
    padding=8,
    foreground="cdd6f4",
)
extension_defaults = widget_defaults.copy()

screens = [
    Screen(
        top=bar.Bar(
            [
                widget.GroupBox(highlight_method="line",
                                this_current_screen_border="b4befe"),
                widget.Prompt(),
                widget.Spacer(),
                widget.Clock(format="%A, %d %B, %Y"),
                widget.Clock(format="%I:%M:%S %p"),
                widget.Spacer(),
                # widget.TextBox("default config", name="default"),
                # widget.TextBox("Press &lt;M-r&gt; to spawn",
                #                foreground="#d75f5f"),
                widget.Systray(),
                widget.PulseVolume(
                    update_interval=0.01
                ),
                widget.CurrentLayout(),
            ],
            32,
            # background=["ffa771", "80553800"],
            background="1e1e2e",
            # Borders are magenta
            # border_color=["000000", "000000", "805538", "000000"]
        ),
    ),
]

# Drag floating layouts.
mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(),
         start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(),
         start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front()),
]

dgroups_key_binder = None
dgroups_app_rules = []  # type: list
follow_mouse_focus = True
bring_front_click = False
cursor_warp = False
floating_layout = layout.Floating(
    float_rules=[
        # Run the utility of `xprop` to see
        # the wm class and name of an X client.
        *layout.Floating.default_float_rules,
        Match(wm_class="confirmreset"),  # gitk
        Match(wm_class="makebranch"),  # gitk
        Match(wm_class="maketag"),  # gitk
        Match(wm_class="ssh-askpass"),  # ssh-askpass
        Match(title="branchdialog"),  # gitk
        Match(title="pinentry"),  # GPG key password entry
    ]
)
auto_fullscreen = True
focus_on_window_activation = "smart"
reconfigure_screens = True

# If things like steam games want to auto-minimize themselves when losing
# focus, should we respect this or not?
auto_minimize = True

# When using the Wayland backend, this can be used to configure input devices.
wl_input_rules = None

# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, GitHub issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
wmname = "Qtile"
