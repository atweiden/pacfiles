#!/bin/bash
[[ -x /usr/bin/tint2 ]] && tint2 &
[[ -x /usr/bin/conky ]] && conky -qd &
[[ -x /usr/bin/volumeicon ]] && volumeicon &
[[ -x /usr/bin/nitrogen ]] && nitrogen --restore &
[[ -x /usr/bin/xautolock && -x /usr/bin/xlock ]] \
  && xautolock -secure -time 7 -locker "/usr/bin/xlock -mode blank" -detectsleep &
[[ -x /usr/bin/redshift ]] \
  && redshift -c ~/.config/redshift/redshift.conf &
[[ -x /usr/bin/pcmanfm ]] && pcmanfm -d &
[[ -x /usr/bin/cbatticon ]] && (sleep 3 && cbatticon) &
[[ -x /usr/bin/compton ]] && compton --config ~/.config/compton/compton.conf -b &
