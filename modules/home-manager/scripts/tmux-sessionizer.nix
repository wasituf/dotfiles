{
  lib,
  pkgs,
  ...
}:
with lib;
{
  options.custom-pkgs.tmux-sessionizer = {
    package = mkOption {
      type = types.package;
      default = pkgs.writeTextFile {
        name = "tmux-sessionizer";
        destination = "/bin/tmux-sessionizer";
        executable = true;
        text = ''
          #!/usr/bin/env bash
          switch_to() {
            if [[ -z $TMUX ]]; then
              tmux attach-session -t $1
            else
              tmux switch-client -t $1
            fi
          }

          has_session() {
              tmux list-sessions | grep -q "^$1:"
          }

          hydrate() {
              if [ -f $2/.tmux-sessionizer ]; then
                  tmux send-keys -t $1 "source $2/.tmux-sessionizer" c-M
              elif [ -f $HOME/.tmux-sessionizer ]; then
                  tmux send-keys -t $1 "source $HOME/.tmux-sessionizer" c-M
              fi
          }

          if [[ $# -eq 1 ]]; then
              selected=$1
          else
              selected=$(find $HOME/dev -mindepth 1 -maxdepth 1 -type d | fzf)
          fi

          if [[ -z $selected ]]; then
              exit 0
          fi

          selected_name=$(basename "$selected" | tr . _)
          tmux_running=$(pgrep tmux)

          if [[ -z $TMUX ]] && [[ -z $tmux_running ]]; then
              cd $selected && tmuxp load dev -s $selected_name
              hydrate $selected_name $selected
              exit 0
          fi

          if ! has_session $selected_name; then
              cd $selected && tmuxp load dev -s $selected_name
              hydrate $selected_name $selected
          fi

          switch_to $selected_name
        '';
      };
      description = "Script to bootstrap tmuxp sessions for projects";
    };
  };
}
