#!/bin/bash

export BROWSER='firefox'
export DE='openbox'

# allow root to access user X server
xhost +si:localuser:root

[ -x '/usr/bin/xmodmap' -a -r "$HOME/.Xmodmap" ] \
  && xmodmap "$HOME/.Xmodmap"

exec dbus-run-session openbox-session

# vim: set filetype=sh foldmethod=marker foldlevel=0 nowrap:
