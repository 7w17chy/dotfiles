#!/usr/bin/env sh
# copied from https://github.com/jonhoo/configs/blob/12ce44247b0850c76e92d3e36777194df8c56ddb/gui/.config/polybar/launch.sh

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# https://github.com/polybar/polybar/issues/763
if type "xrandr"; then
  for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
    MONITOR=$m polybar --reload example &
  done
else
	polybar --reload example &
fi
