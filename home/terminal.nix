# Terminal emulators (wezterm, kitty) and tmux
{ pkgs, ... }:

{
  home.packages = with pkgs; [
    kitty
    wezterm
  ];

  # Terminal dotfiles
  home.file.".wezterm.lua".source = ./dotfiles/_wezterm.lua;

  # Tmux configuration
  programs.tmux = {
    enable = true;

    keyMode = "vi";

    baseIndex = 1;
    newSession = true;
    # Stop tmux+escape craziness.
    escapeTime = 0;
    # Force tmux to use /tmp for sockets (WSL2 compat)
    secureSocket = false;
    mouse = true;
    clock24 = true;
    historyLimit = 50000;
    focusEvents = true;

    plugins = with pkgs; [
      tmuxPlugins.better-mouse-mode # Improved mouse support
      tmuxPlugins.gruvbox # Gruvbox color scheme
    ];

    extraConfig = ''
      # remap prefix from C-b to C-space
      unbind C-b
      set-option -g prefix C-Space
      bind C-Space send-prefix

      # Allow OSC52 clipboard sequences and OSC8 hyperlinks to reach the terminal
      set -g set-clipboard on
      set -g allow-passthrough on
      set -as terminal-features 'xterm*:clipboard:hyperlinks'
      set -as terminal-features 'kitty*:clipboard:hyperlinks'
      set -as terminal-features 'wezterm*:clipboard:hyperlinks'

      # Pane base index (base-index is set via the HM option above)
      set -g pane-base-index 1
      set-window-option -g pane-base-index 1
      set-option -g renumber-windows on

      # tmux-sessionizer (tms) keybindings
      bind C-o display-popup -E "tms"
      bind C-j display-popup -E "tms switch"
      bind C-w display-popup -E "tms windows"
      bind C-r run-shell 'tms refresh'

      # Status bar with tms sessions (gruvbox-ish colors)
      set -g status-position top
      # Softer contrast for the whole bar; right side matches by default
      set -g status-style "fg=colour229,bg=colour237"
      set -g status-left-length 40
      set -g status-right-length 120
      set -g status-left "#[fg=colour229,bold] #S #[fg=colour108]#I:#W #[default]"
      set -g status-right "#[fg=colour229]#H #[fg=colour239]| #[fg=colour108]#{b:pane_current_path}"

      # Make the active pane border more prominent.
      set -g pane-border-style "fg=colour239"
      set -g pane-active-border-style "fg=colour229,bold"
      # Add a top bar to simulate a thicker border.
      set -g pane-border-status top
      set -g pane-border-format " #{pane_index} "

      # Enhanced session switching
      bind -r '(' switch-client -p\; refresh-client -S
      bind -r ')' switch-client -n\; refresh-client -S

      # Additional settings taken from sensible defaults
      set -g default-terminal "screen-256color"
      set -g display-time 4000
      set -g status-interval 5

      # Smart pane switching with awareness of Vim splits.
      # See: https://github.com/christoomey/vim-tmux-navigator
      vim_pattern='(\S+/)?g?\.?(view|l?n?vim?x?|fzf)(diff)?(-wrapped)?'
      is_vim="ps -o state= -o comm= -t '#{pane_tty}' \
          | grep -iqE '^[^TXZ ]+ +$vim_pattern$'"

      unbind -n C-h
      unbind -n C-j
      unbind -n C-k
      unbind -n C-l

      bind-key -n 'M-h' if-shell "$is_vim" "send-keys M-h"  "select-pane -L"
      bind-key -n 'M-j' if-shell "$is_vim" "send-keys M-j"  "select-pane -D"
      bind-key -n 'M-k' if-shell "$is_vim" "send-keys M-k"  "select-pane -U"
      bind-key -n 'M-l' if-shell "$is_vim" "send-keys M-l"  "select-pane -R"
      bind-key -n 'M-\' if-shell "$is_vim" "send-keys M-\\\\" "select-pane -l"

      tmux_version='$(tmux -V | sed -En "s/^tmux ([0-9]+(.[0-9]+)?).*/\1/p")'
      if-shell -b '[ "$(echo "$tmux_version < 3.0" | bc)" = 1 ]' \
          "bind-key -n 'C-\\' if-shell \"$is_vim\" 'send-keys C-\\'  'select-pane -l'"
      if-shell -b '[ "$(echo "$tmux_version >= 3.0" | bc)" = 1 ]' \
          "bind-key -n 'C-\\' if-shell \"$is_vim\" 'send-keys C-\\\\'  'select-pane -l'"

      bind-key -T copy-mode-vi 'M-h' select-pane -L
      bind-key -T copy-mode-vi 'M-j' select-pane -D
      bind-key -T copy-mode-vi 'M-k' select-pane -U
      bind-key -T copy-mode-vi 'M-l' select-pane -R
      bind-key -T copy-mode-vi 'M-\' select-pane -l

      unbind-key -T copy-mode-vi 'v'
      bind-key -T copy-mode-vi v send-keys -X begin-selection
      bind-key -T copy-mode-vi y send-keys -X copy-pipe-and-cancel

    '';
  };
}
