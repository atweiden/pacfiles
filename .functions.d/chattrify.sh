#!/bin/bash

# ----------------------------------------------------------------------------
# chattrify: disable Btrfs copy-on-write (CoW) for single directories
# ----------------------------------------------------------------------------

# ----------------------------------------------------------------------------
#
# Args
#
#   arg 1 = DIRECTORY to disable CoW on       (required)
#   arg 2 = PERMISSIONS to chmod DIRECTORY to (optional)
#   arg 3 = USER to chown DIRECTORY to        (optional)
#   arg 4 = GROUP to chown DIRECTORY to       (optional)
#
# Examples
#
#   chattrify "DIRECTORY" "PERMISSIONS" "USER" "GROUP"
#   chattrify "/var/log/journal" "755" "root" "systemd-journal"
#   chattrify ~/.gnupg

chattrify() {
  local _path
  local _path_bak
  local _permissions
  local _user
  local _group

  [[ $# -gt 0 ]] || echo "No arguments supplied"; exit 1

  # remove trailing forward slashes from directory path
  _path="$(echo "$1" | sed 's,/\+$,,')"
  _path_bak="${_path}_old"
  _permissions="${2:-755}"
  _user="${3:-$(id -un)}"
  _group="${4:-$(id -gn)}"

  if [[ -d "${_path}" ]]; then
    echo -n "Moving original directory '${_path}' to '${_path_bak}'... "
    mv "${_path}" "${_path_bak}"
    echo "done"
  else
    echo "Sorry, couldn't find existing readable directory at '${_path}'"
    exit 1
  fi

  echo -n "Creating new directory '${_path}'... "
  mkdir -p "${_path}"
  echo "done"

  echo -n "Setting permissions on new directory '${_path}'... "
  chmod "${_permissions}" "${_path}"
  echo "done"

  echo -n "Setting owner on new directory '${_path}'... "
  chown "${_user}:${_group}" "${_path}"
  echo "done"

  echo -n "Disabling CoW on new directory '${_path}'... "
  chattr -R +C "${_path}"
  echo "done"

  if [[ -d "${_path_bak}" ]]; then
    echo -n "Copying original files into new directory '${_path}'... "
    find "${_path_bak}" -mindepth 1 -maxdepth 1 -exec cp -dpr '{}' "${_path}" \;
    echo "done"
  fi

  if [[ -d "${_path_bak}" ]]; then
    echo -n "Removing backup of original directory '${_path_bak}'... "
    rm -rf "${_path_bak}"
    echo "done"
  fi
}
