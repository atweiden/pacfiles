#!/bin/bash

# -----------------------------------------------------------------------------
# safe reboot/shutdown
# -----------------------------------------------------------------------------

_quixand_down() {
  [[ -f "$HOME/.functions.d/quixand.sh" ]] \
    && source "$HOME/.functions.d/quixand.sh"
  quixand_down
}

slam() {
  [[ -x '/usr/bin/quixand' ]] && _quixand_down
  sudo shutdown now
}

slur() {
  [[ -x '/usr/bin/quixand' ]] && _quixand_down
  sudo reboot
}

unset -f _quixand_down
