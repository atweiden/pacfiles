[[ -r "$HOME/.bashrc" ]] \
  && source "$HOME/.bashrc"

_quixand_up() {
  [[ -f "$HOME/.functions.d/quixand.sh" ]] \
    && source "$HOME/.functions.d/quixand.sh"
  quixand_up
}

[[ -x '/usr/bin/quixand' ]] \
  && _quixand_up
