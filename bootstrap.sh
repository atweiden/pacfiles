#!/bin/bash

# -----------------------------------------------------------------------------
# usage
# -----------------------------------------------------------------------------

_usage_function() {
read -r -d '' _usage_string <<EOF
Usage:
  ./bootstrap.sh [-h|--help]
  ./bootstrap.sh [-n|--name <name>]
                 [-e|--email <email>]
                 [-g|--github <github>]
                 [-i|--irssi <irssi>]
  ./bootstrap.sh [-a|--latitude <coordinate>] [-o|--longitude <coordinate>]

Options:
  -h, --help
    print this help message
  -n, --name <name>
    set full name (defaults to "$USER")
  -e, --email <email>
    set email address (defaults to "$USER@$HOSTNAME")
  -g, --github <github>
    set GitHub username (defaults to "$USER")
  -i, --irssi <irssi>
    set irssi username (defaults to "$USER")
  -a, --latitude <coordinate>
    set latitude (defaults to "45.523062")
  -o, --longitude <coordinate>
    set longitude (defaults to "-122.676482")
EOF
echo "$_usage_string"
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    -h|--help)
      _usage_function
      exit 0
      ;;
    -n|--name)
      _name="$2"
      shift
      shift
      ;;
    -e|--email)
      _email="$2"
      shift
      shift
      ;;
    -g|--github)
      _github="$2"
      shift
      shift
      ;;
    -i|--irssi)
      _irssi="$2"
      shift
      shift
      ;;
    -a|--latitude)
      _latitude="$2"
      shift
      shift
      ;;
    -o|--longitude)
      _longitude="$2"
      shift
      shift
      ;;
    *)
      # unknown option
      _usage_function
      exit 1
      ;;
  esac
done


# -----------------------------------------------------------------------------
# settings
# -----------------------------------------------------------------------------

# e.g. Andy Weidenbaum (for git/hg, aur)
name="${_name:-$USER}"
# e.g. atweiden@ioiojo.com (for git/hg, aur)
email="${_email:-$USER@$HOSTNAME}"
# e.g. atweiden (for github)
github="${_github:-$USER}"
# e.g. atweiden (for irc)
irssi="${_irssi:-$USER}"
# latitude (for redshift)
latitude="${_latitude:-45.523062}"
# longitude (for redshift)
longitude="${_longitude:--122.676482}"


# -----------------------------------------------------------------------------
# dirs
# -----------------------------------------------------------------------------

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
mkdir -p "$HOME/.src"      \
         "$HOME/Desktop"   \
         "$HOME/Documents" \
         "$HOME/Downloads" \
         "$HOME/Graphics"  \
         "$HOME/Music"     \
         "$HOME/Projects"


# -----------------------------------------------------------------------------
# rsync
# -----------------------------------------------------------------------------

# rsync options
_rsync_opts=()

# exclude files
_rsync_opts+=('--exclude=.git'
              '--exclude=.gitkeep'
              '--exclude=.hg'
              '--exclude=.subgit'
              '--exclude=doc'
              '--exclude=bootstrap.sh'
              '--exclude=fetch-pgp-keys.sh'
              '--exclude=README.txt'
              '--exclude=UNLICENSE')

# copy directories recursively
_rsync_opts+=('--recursive')

# copy symlinks as symlinks
_rsync_opts+=('--links')

# preserve permissions
_rsync_opts+=('--perms')

# backup files in ~/.local/share/dotfiles
_rsync_opts+=('--backup'
              "--backup-dir=$HOME/.local/share/dotfiles")

rsync "${_rsync_opts[@]}" "$DIR/" "$HOME"


# -----------------------------------------------------------------------------
# vim
# -----------------------------------------------------------------------------

_packager_src='https://github.com/kristijanhusak/vim-packager'
_packager_dst="$HOME/.vim/pack/packager/opt/vim-packager"
if ! [[ -d "$_packager_dst" ]]; then
  echo -n 'Installing vim plugin manager (kristijanhusak/vim-packager)... '
  git clone \
    --quiet \
    "$_packager_src" \
    "$_packager_dst"
  echo 'done.'
  echo -n 'Installing vim plugins... '
  vim \
    -c 'call PkgrSetup()' \
    -c 'call packager#install({ "on_finish": "quitall" })' > \
    /dev/null 2>&1
  echo 'done.'
fi


# -----------------------------------------------------------------------------
# makepkg
# -----------------------------------------------------------------------------

sed -i "s#yourname#$name#"         "$HOME/.config/pacman/makepkg.conf"
sed -i "s#youremail#$email#"       "$HOME/.config/pacman/makepkg.conf"


# -----------------------------------------------------------------------------
# yay
# -----------------------------------------------------------------------------

sed -i "s#yourusername#$USER#"     "$HOME/.config/yay/config.json"


# -----------------------------------------------------------------------------
# git/hg
# -----------------------------------------------------------------------------

sed -i "s#yourname#$name#"         "$HOME/.config/git/config"
sed -i "s#youremail#$email#g"      "$HOME/.config/git/config"
sed -i "s#githubusername#$github#" "$HOME/.config/git/config"
sed -i "s#yourname#$name#"         "$HOME/.config/hg/hgrc"
sed -i "s#youremail#$email#"       "$HOME/.config/hg/hgrc"
sed -i "s#githubusername#$github#" "$HOME/.ssh/config"


# -----------------------------------------------------------------------------
# irssi
# -----------------------------------------------------------------------------

sed -i "s#yourname#$irssi#"        "$HOME/.config/irssi/config"


# -----------------------------------------------------------------------------
# redshift
# -----------------------------------------------------------------------------

sed -i "s#LATITUDE#$latitude#"     "$HOME/.config/redshift/redshift.conf"
sed -i "s#LONGITUDE#$longitude#"   "$HOME/.config/redshift/redshift.conf"


# -----------------------------------------------------------------------------
# permissions
# -----------------------------------------------------------------------------

chmod 700 "$HOME/.gnupg"
chmod 700 "$HOME/.ssh"

# vim: set filetype=sh foldmethod=marker foldlevel=0 nowrap:
