# border colours
set -g pane-border-style fg=blue
set -g pane-active-border-style fg=magenta,bg=default

# statusbar --------------------------------------------------------------
set -g status "on"
set -g status-style none
set -g status-justify "left"
set -g status-left-length "100"
set -g status-left "#[none,fg=blue,nobright] #S |"
set -g status-right-length "100"
set -g status-right "#[none,fg=blue,nobright] %Y-%m-%d | %H:%M | #(battery) "
set -g status-interval 1

# default statusbar colors
set -g status-fg white
set -g status-bg default

# bell colours
set -g window-status-bell-style bg=default,fg=red,bright

# default window title colors
set -w -g window-status-style fg=blue,bg=default,none
set -w -g window-status-activity-style none
set -w -g window-status-separator ""
set -w -g window-status-format "#[fg=blue]#I:#W "

# active window title colours
set -w -g window-status-current-format "#[fg=red]#I#[fg=blue]:#W "

# message colours
set -g message-style fg=magenta,bg=default,bright

# vim: set filetype=tmux foldmethod=marker foldlevel=0 nowrap:
