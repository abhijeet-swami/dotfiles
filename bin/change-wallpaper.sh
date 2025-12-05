#!/usr/bin/env bash
set -euo pipefail

WP_DIR="${HOME}/Wallpapers"
CURRENT_LINK="${WP_DIR}/current_wallpaper"

if [ ! -d "$WP_DIR" ]; then
  echo "Wallpaper directory not found: $WP_DIR" >&2
  exit 1
fi

mapfile -t files < <(
  find "$WP_DIR" -maxdepth 1 -type f \
    \( -iregex '.*\.\(jpg\|jpeg\|png\|webp\|bmp\|gif\|avif\|tiff\)' \) -print0 |
    xargs -0 -r printf '%s\n' |
    sort -V
)

if [ "${#files[@]}" -eq 0 ]; then
  echo "No wallpapers found in $WP_DIR" >&2
  exit 1
fi

current=""
if [ -L "$CURRENT_LINK" ] && [ -e "$CURRENT_LINK" ]; then
  current="$(readlink -f "$CURRENT_LINK" || true)"
fi

chosen=""

if [ -z "$current" ]; then
  chosen="${files[0]}"
else
  abs_files=()
  for f in "${files[@]}"; do
    abs_files+=("$(readlink -f "$f")")
  done

  idx=-1
  for i in "${!abs_files[@]}"; do
    if [ "${abs_files[$i]}" = "$current" ]; then
      idx=$i
      break
    fi
  done

  if [ "$idx" -ge 0 ]; then
    next=$(((idx + 1) % ${#abs_files[@]}))
    chosen="${abs_files[$next]}"
  else
    chosen="${abs_files[0]}"
  fi
fi

if ln -sf -- "$chosen" "$CURRENT_LINK"; then
  echo "Current wallpaper -> $(readlink -f "$CURRENT_LINK")"
else
  echo "Symlink failed; copying instead."
  cp -f -- "$chosen" "$CURRENT_LINK"
fi

if command -v matugen >/dev/null 2>&1; then
  matugen image "$CURRENT_LINK"
else
  echo "matugen not found; wallpaper link updated but matugen not executed." >&2
  exit 3
fi

gsettings set org.gnome.desktop.interface gtk-theme adw-gtk3-tmp
gsettings set org.gnome.desktop.interface gtk-theme adw-gtk3
exit 0
