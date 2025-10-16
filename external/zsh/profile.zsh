if [ -z "$WAYLAND_DISPLAY" ] && [ "$XDG_VTNR" = 1 ]; then
  exec Hyprland
fi

if [ -z "$KITTY_WINDOW_ID" ]; then
  export FF_NO_KITGET=1
fi
