_quixand_down() {
  [[ -r "$HOME/.functions.d/quixand.sh" ]] \
    && source "$HOME/.functions.d/quixand.sh"
  quixand_down
}
[[ -x '/usr/bin/quixand' ]] && _quixand_down
clear
