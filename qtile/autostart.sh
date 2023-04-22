#!/bin/env zsh

xrandr --output DP-0 --mode 2560x1440 --rate 144
picom --config ~/.config/picom/picom.conf -b
# feh --bg-scale ~/Pictures/Bridge.jpg
feh --bg-scale ~/Pictures/bailey-zindel-NRQV-hBF10M-unsplash.jpg
numlockx &

# launch apps
discord &
# LD_PRELOAD=/home/ale/Projects/misc/spotifywm/spotifywm.so /snap/bin/spotify &
spotify &
# firefox -p Slack-Desktop -url=https://app.slack.com --class Slack-Desktop-Firefox &
slack &
firefox &
