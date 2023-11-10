#!/run/current-system/sw/bin/bash

flag_file=".recording_flag"

if [ -e "$flag_file" ]; then
    echo "%{F#cc0033} 󰑋  %{F-}Recording... "
else
    echo "%{F#B4BEFE}   %{F-}Record "
fi

