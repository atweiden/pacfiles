#!/bin/bash

export BROWSER='firefox'
export DE='openbox'
[ -x '/usr/bin/xmodmap' ] && [ -r "$HOME/.Xmodmap" ] \
  && xmodmap "$HOME/.Xmodmap"
exec dbus-launch openbox-session

# vim: set filetype=sh foldmethod=marker foldlevel=0 nowrap:
