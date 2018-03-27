#!/bin/bash

_quixand_dirs=("$HOME/.cache"
               "$HOME/.thumbnails"
               "$HOME/.vim/.backups"
               "$HOME/.vim/.swaps"
               "$HOME/.vim/.tmp"
               "$HOME/.vim/.undo"
               "$HOME/.vim/view"
               "$HOME/Sandbox")

_quixand_files=("$HOME/.bash_history"
                "$HOME/.gmrun_history"
                "$HOME/.lesshst"
                "$HOME/.local/share/recently-used.xbel"
                "$HOME/.sdcv_history"
                "$HOME/.vim/.netrwhist"
                "$HOME/.vim_mru_files"
                "$HOME/.viminfo")

srm_file() {
  if [[ -f "$1" ]]; then
    /usr/bin/shred -vz -n 7 "$1"
    /usr/bin/rm -f "$1"
  fi
}

srm_dir() {
  /usr/bin/find "$1" -mindepth 1 -maxdepth 1 -type d \
    | while read -r -d '' _d; do srm_dir "$_d"; done
  /usr/bin/find "$1" -mindepth 1 -maxdepth 1 \
    | while read -r -d '' _f; do srm_file "$_f"; done
  [[ -d "$1" ]] && /usr/bin/rmdir "$1"
}

quixand_rm_stragglers() {
  for _straggler in "${_quixand_files[@]}" "${_quixand_dirs[@]}"; do
    [[ -d "$_straggler" ]] && srm_dir "$_straggler"
    [[ -f "$_straggler" ]] && srm_file "$_straggler"
  done
}

quixand_up() {
  # needed for ensured quixand setup
  quixand_rm_stragglers
  /usr/bin/quixand "${_quixand_files[@]}" -d "${_quixand_dirs[@]}"
}

quixand_down() {
  /usr/bin/quixand -p "${_quixand_files[@]}" -d "${_quixand_dirs[@]}"
  quixand_rm_stragglers
}
