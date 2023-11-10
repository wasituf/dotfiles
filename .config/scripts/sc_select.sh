#!/run/current-system/sw/bin/bash

path="$HOME/Screenshots/$(date +%F_%T).png" && 
  maim -s -B -u -f png "$path" -l -c 0.71,0.75,1,0.3 && 
  xclip -selection clipboard -t image/png "$path" &&
  ACTION=$(dunstify -i "$path" \
  -t 5000 \
  --action="default,openImage" \
  -a "Screenshot" \
  "Screenshot Captured" \
  "<br>Screenshot is copied to system clipboard. <i>(Click to Open)</i>" \
)

case "$ACTION" in
  "default")
    org.gnome.Loupe $path
    ;;
  "2")
    org.gnome.Loupe $path
    ;;
esac
