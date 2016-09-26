# ==============================================================================
# base {{{

# if not running interactively, don't do anything
[[ $- != *i* ]] && return

# end base }}}
# ==============================================================================
# bash settings {{{

# --- editor {{{

set -o vi
export EDITOR=vim
export FCEDIT=vim
export VISUAL=vim
export SUDO_EDITOR=rvim

# --- end editor }}}
# --- history {{{

# don't put duplicate lines in the history. See bash(1) for more
# options
# don't overwrite GNU Midnight Commander's setting of `ignorespace'.
HISTCONTROL=$HISTCONTROL${HISTCONTROL+:}ignoredups
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoreboth
# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
export HISTIGNORE="l:ls:cd:exit"
export HISTSIZE=
export HISTFILESIZE=
export HISTTIMEFORMAT="%Y/%m/%d %H:%M:%S:   "

# --- end history }}}
# --- locale {{{

export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# --- end locale }}}
# --- man pages {{{

export MANPAGER="less -X"

# --- end man pages }}}
# --- safety {{{

# do not overwrite existing file by redirect `>`
# use `>|` to override this setting
set -o noclobber

# --- end safety }}}
# --- shopt {{{

# check the window size after each command and, if necessary, update
# the values of LINES and COLUMNS
shopt -s checkwinsize

# save multi-line commands in history as single line
shopt -s cmdhist

# append to the history file, don't overwrite it
shopt -s histappend

# add failed commands to the bash history
shopt -s histreedit

# edit a recalled history line before executing
shopt -s histverify

# --- end shopt }}}
# --- tmpdir {{{

[[ -z "$TMPDIR" ]] && export TMPDIR=/tmp

# --- end tmpdir }}}

# end bash settings }}}
# ==============================================================================
# terminal settings {{{

# --- display {{{

if [[ "x$DISPLAY" != "x" ]]; then
  export HAS_256_COLORS=yes
  alias tmux="tmux -2"
  [[ "$TERM" == "xterm" ]] && export TERM=xterm-256color-it
else
  if [[ "$TERM" == "xterm" || "$TERM" =~ "256color" ]]; then
    export HAS_256_COLORS=yes
    alias tmux="tmux -2"
  fi
fi
if [[ "$TERM" == "screen" && "$HAS_256_COLORS" == "yes" ]]; then
  export TERM=screen-256color-it
elif [[ "$TERM" == "tmux" && "$HAS_256_COLORS" == "yes" ]]; then
  export TERM=tmux-256color
fi

# miro8 console colors by jwr
if [[ "$TERM" == "linux" || "$TERM" == "vt100" || "$TERM" == "vt220" ]]; then
   echo -en "\e]P0000000" #black
   echo -en "\e]P83d3d3d" #darkgrey
   echo -en "\e]P18c4665" #darkred
   echo -en "\e]P9bf4d80" #red
   echo -en "\e]P2287373" #darkgreen
   echo -en "\e]PA53a6a6" #green
   echo -en "\e]P37c7c99" #brown
   echo -en "\e]PB9e9ecb" #yellow
   echo -en "\e]P4395573" #darkblue
   echo -en "\e]PC477ab3" #blue
   echo -en "\e]P55e468c" #darkmagenta
   echo -en "\e]PD7e62b3" #magenta
   echo -en "\e]P631658c" #darkcyan
   echo -en "\e]PE6096bf" #cyan
   echo -en "\e]P7899ca1" #lightgrey
   echo -en "\e]PFc0c0c0" #white
   clear # bring us back to default input colours
fi

# --- end display }}}
# --- remove ctrl-s ctrl-q {{{

# remove the ^S ^Q mappings. See all mappings: stty -a
[[ $- =~ i ]] && stty -ixoff -ixon
stty stop undef
stty start undef

# --- end remove ctrl-s ctrl-q }}}

# end terminal settings }}}
# ==============================================================================
# path {{{

unset PATH MANPATH

# --- defaults {{{

PATH="/bin:/usr/bin:/usr/local/bin:/sbin:/usr/sbin:/usr/local/sbin"

# --- end defaults }}}
# --- dotfiles {{{

PATH="$HOME/.bin:$PATH"

# --- end dotfiles }}}
# --- erlang {{{

MANPATH="/usr/lib/erlang/man:$MANPATH"

# --- end erlang }}}
# --- ocaml {{{

# (opam config env) https://github.com/ocaml/opam-repository/issues/584
PATH="$HOME/.opam/4.02.3/bin:$PATH"
MANPATH="$HOME/.opam/4.02.3/man:$MANPATH"
export CAML_LD_LIBRARY_PATH="$HOME/.opam/4.02.3/lib/stublibs:/usr/lib/ocaml/stublibs"
export PERL5LIB="$HOME/.opam/4.02.3/lib/perl5:$PERL5LIB"
export OCAML_TOPLEVEL_PATH="$HOME/.opam/4.02.3/lib/toplevel:$OCAML_TOPLEVEL_PATH"

# --- end ocaml }}}
# --- perl {{{

PATH="/usr/bin/vendor_perl:/usr/bin/core_perl:/usr/bin/site_perl:$PATH"

# --- end perl }}}
# --- perl6 {{{

# from output of `~/.rakudobrew/bin/rakudobrew init -`
PATH="$HOME/.rakudobrew/bin:$PATH"
rakudobrew() {
  local command="$1"
  [[ "$#" -gt 0 ]] && shift
  case "$command" in
    shell)
      eval "$(rakudobrew "sh" "$@")";;
    *)
      command rakudobrew "$command" "$@";;
  esac
}

# for panda-installed perl6 executables
[[ $(command -v perl6) ]] \
  && PATH="$(perl6 -e 'say ~CompUnit::RepositoryRegistry.repository-for-name(q<site>)')/bin:$PATH"

# --- end perl6 }}}

export PATH MANPATH

# end path }}}
# ==============================================================================
# presence {{{

_has_ack=$(command -v ack)
_has_ag=$(command -v ag)
_has_archversion=$(command -v archversion)
_has_colordiff=$(command -v colordiff)
_has_electrum=$(command -v electrum)
_has_erl=$(command -v erl)
_has_gvim=$(command -v gvim)
_has_icdiff=$(command -v icdiff)
_has_iex=$(command -v iex)
_has_mosh=$(command -v mosh)
_has_nvim=$(command -v nvim)
_has_perl6=$(command -v perl6)
_has_pt=$(command -v pt)
_has_rlwrap=$(command -v rlwrap)
_has_subgit=$(command -v subgit)
_has_subhg=$(command -v subhg)
_has_tree=$(command -v tree)
_has_vim=$(command -v vim)
_has_zbarcam=$(command -v zbarcam)

# end presence }}}
# ==============================================================================
# prompt {{{

# --- history {{{

export PROMPT_COMMAND="history -a; history -c; history -r"

# --- end history }}}
# --- ps1 {{{

PS1="\[\e[01;31m\]┌─[\[\e[01;35m\u\e[01;31m\]]──[\[\e[00;37m\]${HOSTNAME%%.*}\[\e[01;32m\]]:\w$\[\e[01;31m\]\n\[\e[01;31m\]└──\[\e[01;36m\]>>\[\e[0m\]"

# --- end ps1 }}}

# end prompt }}}
# ==============================================================================
# aliases {{{

# --- archversion {{{

[[ -n "$_has_archversion" ]] && alias avs='archversion sync && archversion report --new'
[[ -n "$_has_archversion" ]] && alias avr='archversion report --new'

# --- end archversion }}}
# --- diff {{{

if [[ -n "$_has_icdiff" ]]; then
  alias diff='icdiff'
elif [[ -n "$_has_colordiff" ]]; then
  alias diff='colordiff'
fi

# --- end diff }}}
# --- directory navigation {{{

alias ls='ls --classify --color=auto --group-directories-first'
alias l='ls -1'
alias l1='ls -1A'
alias la='ls -a'
alias ll='ls -laih'
[[ -n "$_has_tree" ]] && alias tree='tree -C --charset utf-8 --dirsfirst'
alias ..='cd ..'
alias ..2='cd ../..'
alias ..3='cd ../../..'
alias ..4='cd ../../../..'
alias ..5='cd ../../../../..'
alias cdd='cd $HOME/Downloads'
alias cdg='cd $(git rev-parse --show-cdup)'
alias cdp='cd $HOME/Projects'
alias cds='cd $HOME/.src'
[[ -x /usr/bin/pcmanfm ]] && alias :o='pcmanfm "$PWD" &'
alias :q='exit'

# --- end directory navigation }}}
# --- disk space {{{

alias df='df -h'
alias du='du -h --max-depth=1'
alias dusort='du -x --block-size=1048576 | sort -nr'

# --- end disk space }}}
# --- file compression {{{

alias zip='zip -9'
alias gzip='gzip -9'
alias bzip2='bzip2 -9'

# --- end file compression }}}
# --- grepping {{{

alias grep='grep --ignore-case --color=auto'
alias fgrep='fgrep --ignore-case --color=auto'
alias egrep='egrep --ignore-case --color=auto'
alias h\?='history | grep -v -E "grep|h\?" | grep "$@" -i --color=auto'
alias l\?='ls -1F | grep "$@" -i --color=auto'
alias p\?='ps -a -x -f | grep -v grep | grep "$@" -i --color=auto'
alias pkg\?='pacman -Q | grep -v grep | grep "$@" -i --color=auto'
[[ -n "$_has_ag" ]] && alias ag='ag --hidden --smart-case --skip-vcs-ignores --path-to-ignore=$HOME/.agignore'
alias locate='locate --ignore-case'

# --- end grepping }}}
# --- languages {{{

# --- --- beam {{{

[[ -n "$_has_iex" && -n "$_has_rlwrap" ]] && alias iex='rlwrap --always-readline --ansi-colour-aware iex'
[[ -n "$_has_erl" && -n "$_has_rlwrap" ]] && alias erl='rlwrap --always-readline --ansi-colour-aware erl'

# --- --- end beam }}}
# --- --- perl6 {{{

[[ -n "$_has_perl6" ]] && alias p6='perl6'
[[ -n "$_has_perl6" ]] && alias prove6='prove -r -e perl6'
[[ -n "$_has_perl6" && -n "$_has_rlwrap" ]] && alias rp='rlwrap perl6'

# --- --- end perl6 }}}

# --- end languages }}}
# --- processes {{{

alias ps='ps --forest'

# --- end processes }}}
# --- subrepo {{{

[[ -n "$_has_subgit" ]] && alias sg='subgit'
[[ -n "$_has_subhg" ]] && alias shg='subhg'

# --- end subrepo }}}
# --- safety {{{

alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'

# --- end safety }}}
# --- ssh {{{

[[ -n "$_has_mosh" ]] && alias mosh='mosh -a'

# --- end ssh }}}
# --- tmux {{{

[[ -n $TMUX ]] && alias clear='clear; tmux clear-history'
[[ -n $TMUX ]] && alias reset='reset; tmux clear-history'

# --- end tmux }}}
# --- vim {{{

alias :e='"$EDITOR"'
# if not in X, tell vim not to attempt connection w/ X server
[[ "$DISPLAY" == "" ]] && alias vim='vim -X'
[[ -n "$_has_vim" ]] && alias view='vim -R'
[[ -n "$_has_vim" ]] && alias vime='vim -u $HOME/.vimencrypt -x'
[[ -n "$_has_vim" ]] && alias viml='vim -u $HOME/.vimrc.lite'
[[ -n "$_has_vim" ]] && alias vimmin='vim -u NONE -U NONE --cmd "set nocompatible | syntax on | filetype plugin indent on"'
[[ -n "$_has_gvim" ]] && alias gview='gvim -R'
[[ -n "$_has_gvim" ]] && alias gvime='gvim -u $HOME/.vimencrypt -x'
[[ -n "$_has_gvim" ]] && alias gviml='gvim -u $HOME/.vimrc.lite'
[[ -n "$_has_gvim" ]] && alias gvimmin='gvim -u NONE -U NONE --cmd "set nocompatible | syntax on | filetype plugin indent on"'
[[ -n "$_has_nvim" ]] && alias nv='nvim'
[[ -n "$_has_nvim" ]] && alias nview='nvim -R'

# --- end vim }}}
# --- zbar {{{

[[ -n "$_has_electrum" ]] && alias electrum='LD_PRELOAD=/usr/lib/libv4l/v4l1compat.so electrum'
[[ -n "$_has_zbarcam" ]] && alias zbarcam='LD_PRELOAD=/usr/lib/libv4l/v4l1compat.so zbarcam'

# --- end zbar }}}

# end aliases }}}
# ==============================================================================
# functions {{{

for _fn in $(find "$HOME/.functions.d" -type f -name "*.sh"); do source "$_fn"; done

# end functions }}}
# ==============================================================================
# completions {{{

[[ -r /usr/share/bash-completion/bash_completion ]] \
  && source /usr/share/bash-completion/bash_completion

# end completions }}}
# ==============================================================================
# archinfo {{{

if [[ -x "$HOME/.bin/archinfo" && -x /usr/bin/python2 ]]; then
  if ! [[ "$UID" == '0' ]]; then archinfo; else archinfo -c red; fi
fi

# end archinfo }}}
# ==============================================================================
# fzf {{{

# use ag/pt/ack as the default source for fzf
if [[ -n "$_has_ag" ]]; then
  export FZF_DEFAULT_COMMAND='ag --hidden --smart-case --nocolor --skip-vcs-ignores --path-to-ignore=$HOME/.agignore -g ""'
elif [[ -n "$_has_pt" ]]; then
  export FZF_DEFAULT_COMMAND='pt --hidden --nocolor -e -g=""'
elif [[ -n "$_has_ack" ]]; then
  export FZF_DEFAULT_COMMAND='ack --nocolor --nopager -g ""'
fi

# use ag/pt/ack for ctrl-t completion
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# use ag/pt/ack for ** completion
_fzf_compgen_path() {
  if [[ -n "$_has_ag" ]]; then
    ag \
      --hidden \
      --smart-case \
      --nocolor \
      --skip-vcs-ignores \
      --path-to-ignore="$HOME/.agignore" \
      -g "" \
      "$1"
  elif [[ -n "$_has_pt" ]]; then
    pt --hidden --nocolor -e -g="" "$1"
  elif [[ -n "$_has_ack" ]]; then
    ack --nocolor --nopager -g "" "$1"
  fi
}

# use multi-select and seoul256 colors
export FZF_DEFAULT_OPTS='
  --multi
  --color fg:242,bg:233,hl:65,fg+:15,bg+:234,hl+:108
  --color info:108,prompt:109,spinner:108,pointer:168,marker:168
'

# improved preview
[[ -n "$_has_tree" ]] \
  && export FZF_ALT_C_OPTS="--preview 'tree -C {} | head -$LINES'"
export FZF_CTRL_R_OPTS="--preview 'echo {}' --preview-window down:3:hidden --bind ?:toggle-preview"
export FZF_CTRL_T_OPTS="--preview '(cat {} || tree -C {}) 2> /dev/null | head -$LINES'"

# create fzf key bindings
[[ -e "/etc/profile.d/fzf.bash" ]] && source /etc/profile.d/fzf.bash
[[ -e "/etc/profile.d/fzf-extras.bash" ]] && source /etc/profile.d/fzf-extras.bash

# end fzf }}}
# ==============================================================================
# cryfs {{{

export CRYFS_NO_UPDATE_CHECK=true

# end cryfs }}}
# ==============================================================================
# gpg {{{

GPG_TTY=$(tty)
export GPG_TTY

# end gpg }}}
# ==============================================================================

# vim: set filetype=sh foldmethod=marker foldlevel=0 nowrap:
