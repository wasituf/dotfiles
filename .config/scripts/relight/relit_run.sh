#!/run/current-system/sw/bin/bash

# Handle argument.
if [ -z "$@" ]
then
    case "$@" in
      "Silicon")
        list=("From Clipboard" "From Clipboard: Highlight" "From File")
        source ./scripts/silicon/silicon.sh
      ;;
      "Password")
        rofi-rbw
      ;;
    esac
fi

list=("Silicon" "Password" "Emoji")

for li in "${list[@]}"; do
  echo "$li"
done
