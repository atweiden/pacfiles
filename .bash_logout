#
# ~/.bash_logout
#

_quixand_down() {
  [[ -f "$HOME/.functions.d/quixand.sh" ]] \
    && source "$HOME/.functions.d/quixand.sh"
  quixand_down
}
[[ -x '/usr/bin/quixand' ]] && _quixand_down
