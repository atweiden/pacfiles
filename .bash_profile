[[ -f ~/.bashrc ]] && source ~/.bashrc

# quixand
[[ -x /usr/bin/quixand ]] \
  && quixand ~/.bash_history \
             ~/.gmrun_history \
             ~/.lesshst \
             ~/.local/share/recently-used.xbel \
             ~/.sdcv_history \
             ~/.viminfo \
             ~/.vim_mru_files \
             -d ~/Sandbox \
                ~/.cache \
                ~/.thumbnails \
                ~/.vim/.backups \
                ~/.vim/.swaps \
                ~/.vim/.tmp \
                ~/.vim/.undo \
                ~/.vim/view
