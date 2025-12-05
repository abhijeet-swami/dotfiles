#!/bin/bash
wall_dir="${HOME}/Wallpapers"
cache_dir="${HOME}/.cache/thumbnails/wal_selector"
rofi_config_path="${HOME}/.config/rofi/rofi-wallpaper-sel.rasi"
THUMBNAIL_SIZE=512

mkdir -p "${cache_dir}"

shopt -s nullglob
for imagen in "${wall_dir}"/*.{jpg,jpeg,png,webp,JPG,JPEG,PNG,WEBP}; do
  [ -f "$imagen" ] || continue
  filename=$(basename "$imagen")
  if [ ! -f "${cache_dir}/${filename}" ]; then
    magick "$imagen" -thumbnail ${THUMBNAIL_SIZE}x${THUMBNAIL_SIZE}^ -gravity center -extent ${THUMBNAIL_SIZE}x${THUMBNAIL_SIZE} "${cache_dir}/${filename}"
  fi
done
shopt -u nullglob

wall_selection=$(find "${wall_dir}" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.webp" \) -printf "%f\n" |
  while read -r filename; do
    echo -en "${filename}\x00icon\x1f${cache_dir}/${filename}\n"
  done | rofi -dmenu -show-icons -config "${rofi_config_path}")

[[ -n "${wall_selection:-}" ]] || exit 1

selected_path="${wall_dir}/${wall_selection}"

if command -v matugen >/dev/null 2>&1; then
  matugen image "$selected_path"
fi

CURRENT_LINK="${wall_dir}/current_wallpaper"
ln -sf -- "$selected_path" "$CURRENT_LINK"

gsettings set org.gnome.desktop.interface gtk-theme adw-gtk3-tmp
gsettings set org.gnome.desktop.interface gtk-theme adw-gtk3

exit 0
