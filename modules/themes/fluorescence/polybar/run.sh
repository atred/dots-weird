#!/usr/bin/env bash

BATNUM=$(find /sys/class/power_supply/BAT* | wc -l)
if [ $BATNUM -ge 2 ]; then
    polybar -rq bat2bar >$XDG_DATA_HOME/polybar.log 2>&1 &
elif [ $BATNUM -eq 1 ]; then
    polybar -rq bat1bar >$XDG_DATA_HOME/polybar.log 2>&1 &
else
    polybar -rq bat0bar >$XDG_DATA_HOME/polybar.log 2>&1 &
fi

echo 'Polybar launched...'
