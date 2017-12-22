#!/usr/bin/env sh

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -x polybar >/dev/null; do sleep 1; done

# Launch bar1 and bar2
MONITOR=eDP1 polybar top & # laptop
MONITOR=DisplayPort-0 polybar top &
MONITOR=DisplayPort-1 polybar top &
MONITOR=DisplayPort-2 polybar top &
MONITOR=HDMI-A-0 polybar top &


MONITOR=eDP1 polybar bottom & # laptop
MONITOR=DisplayPort-0 polybar bottom &
MONITOR=HDMI-A-0 polybar bottom &

echo "Bars launched..."
