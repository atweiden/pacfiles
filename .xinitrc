#!/bin/bash
export BROWSER=firefox
export DE=openbox
[[ -x /usr/bin/xmodmap && -f "$HOME/.Xmodmap" ]] && xmodmap "$HOME/.Xmodmap"
exec dbus-launch openbox-session
