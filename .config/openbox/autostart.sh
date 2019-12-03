#!/bin/bash

[ -x '/usr/bin/tint2' ] \
  && tint2 &
[ -x '/usr/bin/conky' ] \
  && conky --config="$HOME/.config/conky/conkyrc" -qd &
[ -x '/usr/bin/volumeicon' ] \
  && volumeicon &
[ -x '/usr/bin/nitrogen' ] \
  && nitrogen --restore &
[ -x '/usr/bin/xautolock' ] && [ -x '/usr/bin/i3lock' ] \
  && xautolock -secure -time 7 -locker '/usr/bin/i3lock --color=000000' -detectsleep &
[ -x '/usr/bin/redshift' ] \
  && redshift -c "$HOME/.config/redshift/redshift.conf" &
[ -x '/usr/bin/pcmanfm' ] \
  && pcmanfm -d &
[ -x '/usr/bin/cbatticon' ] \
  && (sleep 3 && cbatticon) &
[ -x '/usr/bin/picom' ] \
  && picom --config "$HOME/.config/picom/picom.conf" -b &

# vim: set filetype=sh foldmethod=marker foldlevel=0 nowrap:
