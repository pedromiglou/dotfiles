#!/usr/bin/env bash

# Terminate already running bar instances
# If all your bars have ipc enabled, you can use 
polybar-msg cmd quit
# Otherwise you can use the nuclear option:
# killall -q polybar

# Launch mybar
echo "---" | tee -a /tmp/mybar.log
if type "xrandr"; then
  for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
    MONITOR=$m polybar mybar 2>&1 | tee -a /tmp/mybar.log & disown
  done
else
  polybar --reload example &
fi
# polybar mybar 2>&1 | tee -a /tmp/mybar.log & disown
echo "Bars launched..."
