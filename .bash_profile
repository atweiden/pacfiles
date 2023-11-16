[[ -r "$HOME/.bashrc" ]] \
  && source "$HOME/.bashrc"

# wayland {{{

# configure clutter for wayland
export CLUTTER_BACKEND="wayland"

# configure firefox for wayland
export MOZ_ENABLE_WAYLAND=1

# enable firefox touch scrolling and multitouch support
export MOZ_USE_XINPUT2=1

# make firefox aware of wayland instance when launched from x11
export MOZ_DBUS_REMOTE=1

# configure gtk for wayland
export GDK_BACKEND="wayland"

# prevent waiting for xdg-desktop-portal (flatpak)
export GTK_USE_PORTAL=0

# configure java applications for sway
export _JAVA_AWT_WM_NONREPARENTING=1

# configure qt for wayland/sway
export QT_QPA_PLATFORM="wayland;xcb"
export QT_QPA_PLATFORMTHEME="qt5ct"
export QT_WAYLAND_DISABLE_WINDOWDECORATION=1

# configure sdl for wayland
export SDL_VIDEODRIVER="wayland"

# configure seatd
export LIBSEAT_BACKEND="seatd"

# configure xdg for wayland/sway
export DESKTOP_SESSION="sway"
export XDG_CURRENT_DESKTOP="sway"
export XDG_SESSION_DESKTOP="sway"
export XDG_SESSION_TYPE="wayland"

# end wayland }}}
# gtk {{{

# configure gtk3 manually for wayland since most values aren't read from
# config file; config file needs to be available for applications which
# still use it
gtkcfg="$XDG_CONFIG_HOME/gtk-3.0/settings.ini"
if [[ -f "$gtkcfg" ]]; then
  gnome_interface_schema="org.gnome.desktop.interface"
  # parse some entries from settings to avoid manual updates
  gtk_theme="$(grep 'gtk-theme-name' "$gtkcfg" | sed 's/.*\s*=\s*//')"
  icon_theme="$(grep 'gtk-icon-theme-name' "$gtkcfg" | sed 's/.*\s*=\s*//')"
  cursor_theme="$(grep 'gtk-cursor-theme-name' "$gtkcfg" | sed 's/.*\s*=\s*//')"
  font_name="$(grep 'gtk-font-name' "$gtkcfg" | sed 's/.*\s*=\s*//')"
  # configure settings via interface
  gsettings set "$gnome_interface_schema" gtk-theme "$gtk_theme"
  gsettings set "$gnome_interface_schema" icon-theme "$icon_theme"
  gsettings set "$gnome_interface_schema" cursor-theme "$cursor_theme"
  gsettings set "$gnome_interface_schema" font-name "$font_name"
  # some settings which can't be parsed from settings file
  gsettings set $gnome_interface_schema monospace-font-name "MonoLisa 10"
  gsettings set $gnome_interface_schema toolbar-style "text"
  gsettings set $gnome_interface_schema toolbar-icons-size "small"
fi

# end gtk }}}

# vim: set filetype=sh foldmethod=marker foldlevel=0 nowrap:
