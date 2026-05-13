#!/usr/bin/env bash

BAR_CHARS=("▁" "▂" "▃" "▄" "▅" "▆" "▇" "█")
CONF="$HOME/.config/waybar/scripts/cava-waybar.conf"

cava -p "$CONF" | while IFS=';' read -ra values; do
  output=""
  for val in "${values[@]}"; do
    idx=$val
    (( idx > 7 )) && idx=7
    output+="${BAR_CHARS[$idx]}"
  done
  echo "$output"
done
