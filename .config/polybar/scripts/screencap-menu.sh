#!/usr/bin/env bash

dir="~/.config/polybar/scripts/rofi"
rofi_command="rofi -no-config -theme $dir/powermenu.rasi"

flag_file=".recording_flag"

if [ -e "$flag_file" ]; then
  sh ~/.config/polybar/scripts/screencap.sh
  exit
fi

# Options
system="󰓃  Record: System Audio"
mic="󰍬  Record: Microphone Audio"
both="󰢴  Record: System & Microphone (Dual)"
silent="󰖁  Record: No Audio (Silent)"

# Variable passed to rofi
options="$system\n$mic\n$both\n$silent"

chosen="$(echo -e "$options" | $rofi_command -p "Screen Recording Options" -dmenu -selected-row 0)"
case $chosen in
    $system)
      sh ~/.config/polybar/scripts/screencap.sh system
        ;;
    $mic)
      sh ~/.config/polybar/scripts/screencap.sh mic
        ;;
    $both)
      sh ~/.config/polybar/scripts/screencap.sh both
        ;;
    $silent)
      sh ~/.config/polybar/scripts/screencap.sh silent
        ;;
esac
