#!/bin/bash

# -----------------------------------------------------------------------------
# usage
# -----------------------------------------------------------------------------

# _usage_function() {{{

_usage_function() {
read -r -d '' _usage_string <<'EOF'
Usage:
  ./bootstrap.sh [-h|--help]
  ./bootstrap.sh [-n|--name <name>] [-e|--email <email>] [-g|--github <github>]
  ./bootstrap.sh [-a|--latitude <coordinate>] [-o|--longitude <coordinate>]

Options:
  -h, --help
    print this help message
  -n, --name <name>
    set full name (defaults to "Andy Weidenbaum")
  -e, --email <email>
    set email address (defaults to "archbaum@gmail.com")
  -g, --github <github>
    set GitHub username (defaults to "atweiden")
  -a, --latitude <coordinate>
    set latitude (defaults to "45.523062")
  -o, --longitude <coordinate>
    set longitude (defaults to "-122.676482")
EOF
echo "$_usage_string"
}

# end _usage_function() }}}

while [[ $# -gt 0 ]]; do
  case "$1" in
    -h|--help)
      _usage_function
      exit 0
      ;;
    -n|--name)
      _name="$2"
      # shift past argument and value
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

name="${_name:-Andy Weidenbaum}"       # Name    (GitHub/AUR)
email="${_email:-archbaum@gmail.com}"  # Email   (GitHub/AUR)
github="${_github:-atweiden}"          # Account (GitHub)
latitude="${_latitude:-45.523062}"     # Latitude  (Redshift)
longitude="${_longitude:--122.676482}" # Longitude (Redshift)


# -----------------------------------------------------------------------------
# dirs
# -----------------------------------------------------------------------------

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
mkdir -p "$HOME/.marks"    \
         "$HOME/.src"      \
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
              '--exclude=.hg'
              '--exclude=.subgit'
              '--exclude=bootstrap.sh'
              '--exclude=fetch-pgp-keys.sh'
              '--exclude=README.txt'
              '--exclude=UNLICENSE')

# copy directories recursively
_rsync_opts+=('--recursive')

# preserve permissions
_rsync_opts+=('--perms')

# backup files in ~/.local/share/dotfiles
_rsync_opts+=('--backup'
              "--backup-dir=$HOME/.local/share/dotfiles")

# output numbers in a more human-readable format
_rsync_opts+=('--human-readable')

# print information showing the progress of the transfer
_rsync_opts+=('--progress')

rsync --verbose "${_rsync_opts[@]}" "$DIR/" "$HOME"


# -----------------------------------------------------------------------------
# vim-plug
# -----------------------------------------------------------------------------

if ! [[ -e ~/.vim/autoload/plug.vim ]]; then
  curl \
    -fLo ~/.vim/autoload/plug.vim \
    --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  vim +PlugInstall +qa
fi


# -----------------------------------------------------------------------------
# neovim
# -----------------------------------------------------------------------------

mkdir -p ~/.config
! [[ -d ~/.config/nvim ]] && ln -s ~/.vim ~/.config/nvim
! [[ -e ~/.config/nvim/init.vim ]] && ln -s ~/.vimrc ~/.config/nvim/init.vim


# -----------------------------------------------------------------------------
# makepkg
# -----------------------------------------------------------------------------

sed -i "s#yourname#$name#"         "$HOME/.config/pacman/makepkg.conf"
sed -i "s#youremail#$email#"       "$HOME/.config/pacman/makepkg.conf"


# -----------------------------------------------------------------------------
# github
# -----------------------------------------------------------------------------

sed -i "s#yourname#$name#"         "$HOME/.gitconfig"
sed -i "s#youremail#$email#"       "$HOME/.gitconfig"
sed -i "s#yourgithubacct#$github#" "$HOME/.gitconfig"
sed -i "s#yourname#$name#"         "$HOME/.hgrc"
sed -i "s#youremail#$email#"       "$HOME/.hgrc"


# -----------------------------------------------------------------------------
# redshift
# -----------------------------------------------------------------------------

sed -i \
  -e "s#LATITUDE#$latitude#" \
  -e "s#LONGITUDE#$longitude#" \
  "$HOME/.config/redshift/redshift.conf"


# -----------------------------------------------------------------------------
# permissions
# -----------------------------------------------------------------------------

chmod 700 "$HOME/.gnupg" "$HOME/.ssh"

# vim: set filetype=sh foldmethod=marker foldlevel=0:
