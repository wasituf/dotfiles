{ pkgs, ... }:
{
  programs.tmux = {
    enable = true;
    baseIndex = 1;
    historyLimit = 10000;
    keyMode = "vi";
    mouse = true;
    newSession = false;
    prefix = "C-Space";
    shell = "${pkgs.zsh}/bin/zsh";
    terminal = "screen-256color";
    escapeTime = 10;
    plugins = with pkgs;
      [
        {
          plugin = tmuxPlugins.catppuccin;
          extraConfig = '' 
            set -g @catppuccin_flavour 'mocha'

            set -g @catppuccin_window_right_separator "█ "
            set -g @catppuccin_window_middle_separator " █"

            set -g @catppuccin_status_left_separator "█"

            set -g @catppuccin_window_number_position "right"
            set -g @catppuccin_window_default_fill "number"
            set -g @catppuccin_window_current_fill "number"

            set -g @catppuccin_status_modules_right "application session"
            set -g @catppuccin_status_fill "icon" 
          '';
        }
        {
          plugin = tmuxPlugins.yank;
          extraConfig = ''
            bind-key -T copy-mode-vi v send-keys -X begin-selection
            bind-key -T copy-mode-vi C-v send-keys -X rectangle-toggle
            bind-key -T copy-mode-vi y send-keys -X copy-selection-and-cancel

            bind-key -T copy-mode-vi 'm' send-keys -X cursor-left
            bind-key -T copy-mode-vi 'n' send-keys -X cursor-down
            bind-key -T copy-mode-vi 'e' send-keys -X cursor-up
            bind-key -T copy-mode-vi 'i' send-keys -X cursor-right
          '';
        }
        {
          plugin = tmuxPlugins.tmux-fzf;
          extraConfig = ''
            TMUX_FZF_LAUNCH_KEY="f"
          '';
        }
        {
          plugin = tmuxPlugins.resurrect;
          extraConfig = ''
            set -g @resurrect-save 'S'
            set -g @resurrect-restore 'R
          '';
        }
        {
          plugin = tmuxPlugins.continuum;
          extraConfig = ''
            set -g @continuum-save-interval '5'
            set -g @continuum-boot 'on
          '';
        }
      ];
    extraConfig = ''
      # Smart pane switching with awareness of Vim splits.
      # See: https://github.com/christoomey/vim-tmux-navigator
      is_vim="ps -o state= -o comm= -t '#{pane_tty}' \
        | grep -iqE '^[^TXZ ]+ +(\\S+\\/)?g?(view|n?vim?x?)(diff)?$'"
      bind-key -n M-m if-shell "$is_vim" 'send-keys M-m'  'select-pane -L'
      bind-key -n M-n if-shell "$is_vim" 'send-keys M-n'  'select-pane -D'
      bind-key -n M-e if-shell "$is_vim" 'send-keys M-e'  'select-pane -U'
      bind-key -n M-i if-shell "$is_vim" 'send-keys M-i'  'select-pane -R'

      bind-key -n M-M if-shell "$is_vim" 'send-keys M-M' 'resize-pane -L 2'
      bind-key -n M-N if-shell "$is_vim" 'send-keys M-N' 'resize-pane -D 2'
      bind-key -n M-E if-shell "$is_vim" 'send-keys M-E' 'resize-pane -U 2'
      bind-key -n M-I if-shell "$is_vim" 'send-keys M-I' 'resize-pane -R 2'

      tmux_version='$(tmux -V | sed -En "s/^tmux ([0-9]+(.[0-9]+)?).*/\1/p")'
      if-shell -b '[ "$(echo "$tmux_version < 3.0" | bc)" = 1 ]' \
        "bind-key -n 'C-\\' if-shell \"$is_vim\" 'send-keys C-\\'  'select-pane -l'"
      if-shell -b '[ "$(echo "$tmux_version >= 3.0" | bc)" = 1 ]' \
        "bind-key -n 'C-\\' if-shell \"$is_vim\" 'send-keys C-\\\\'  'select-pane -l'"

      bind-key -T copy-mode-vi 'M-m' select-pane -L
      bind-key -T copy-mode-vi 'M-n' select-pane -D
      bind-key -T copy-mode-vi 'M-e' select-pane -U
      bind-key -T copy-mode-vi 'M-i' select-pane -R
      bind-key -T copy-mode-vi 'M-\' select-pane -l

      # image.nvim
      set -gq allow-passthrough on

      # Switch Windows
      bind -n M-U previous-window
      bind -n M-Y next-window

      set-option -g renumber-windows on

      # Open panes in current directory
      bind 'v' split-window -v -c "#{pane_current_path}"
      bind 'h' split-window -h -c "#{pane_current_path}"

      # Easy find files with fzf and tmuxinator
      bind -r t run-shell "tmux neww ~/.config/scripts/tmux-sessionizer"

      # Disable starting login shell
      set -g default-command "${pkgs.zsh}/bin/zsh"
   '';
    tmuxinator.enable = true;
  };
}

