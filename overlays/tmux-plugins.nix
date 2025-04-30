final: prev:

let
  # Get the mkTmuxPlugin function from the previous tmuxPlugins set
  mkTmuxPlugin = prev.tmuxPlugins.mkTmuxPlugin;
in
{
  tmuxPlugins = prev.tmuxPlugins // {
    # Override the existing tmux-fzf definition
    tmux-fzf = mkTmuxPlugin {
      pluginName = "tmux-fzf";
      rtpFilePath = "main.tmux";
      version = "unstable-2025-03-15";
      src = prev.fetchFromGitHub {
        owner = "sainnhe";
        repo = "tmux-fzf";
        rev = "e91c1ae";
        hash = "sha256-JItut2Iiuw8EEFCz6u7R1eLMxCvvPpSrQLkMbY+XXE8=";
      };
      postInstall = ''
        find $target -type f -print0 | xargs -0 sed -i -e 's|fzf |${prev.pkgs.fzf}/bin/fzf |g'
        find $target -type f -print0 | xargs -0 sed -i -e 's|sed |${prev.pkgs.gnused}/bin/sed |g'
        find $target -type f -print0 | xargs -0 sed -i -e 's|tput |${prev.pkgs.ncurses}/bin/tput |g'
      '';
      meta = with prev.lib; {
        homepage = "https://github.com/sainnhe/tmux-fzf";
        description = "Use fzf to manage your tmux work environment! ";
        longDescription = ''
          Features:
          * Manage sessions (attach, detach*, rename, kill*).
          * Manage windows (switch, link, move, swap, rename, kill*).
          * Manage panes (switch, break, join*, swap, layout, kill*, resize).
          * Multiple selection (support for actions marked by *).
          * Search commands and append to command prompt.
          * Search key bindings and execute.
          * User menu.
          * Popup window support.
        '';
        license = licenses.mit;
        platforms = platforms.unix;
        maintainers = with maintainers; [ kyleondy ];
      };
    };
  };
}
