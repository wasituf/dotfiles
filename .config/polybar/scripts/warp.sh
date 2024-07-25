if [ -f "$HOME/.config/polybar/scripts/warp-flag" ]; then
  warp-cli disconnect && rm "$HOME/.config/polybar/scripts/warp-flag"
else
  warp-cli connect && touch "$HOME/.config/polybar/scripts/warp-flag"
fi
