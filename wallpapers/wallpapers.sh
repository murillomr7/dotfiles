#!/bin/bash

while true; do
  # Set a random wallpaper from the specified folder
  feh --randomize --bg-fill . #/home/murillomr7/Downloads/wallpapers/*

  # Get the current wallpaper from .fehbg
  wallpaper="$(cat "${HOME}/.fehbg" | awk -F "'" '{print $2}')"

  # Apply pywal color scheme to desktop
  wal -i $wallpaper

  # Sleep for one minute before setting a new wallpaper
  sleep 5
done
