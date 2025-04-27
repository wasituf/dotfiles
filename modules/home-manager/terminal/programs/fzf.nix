{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.modules.terminal.programs.fzf;
in
{
  options.modules.terminal.programs.fzf = {
    enable = lib.mkEnableOption "fzf";
  };

  config = lib.mkIf cfg.enable {
    home.packages = [ pkgs.fd ];
    programs.fzf = {
      enable = true;
      defaultCommand = "fd --type f";
      changeDirWidgetCommand = "fd --type d";
      fileWidgetCommand = "fd --type f";
      defaultOptions = [
        "--border='rounded'"
        "--preview-window='border-rounded'"
        "--info='right'"
        "--marker='›'"
        "--prompt='› '"
        "--pointer='•'"
      ];
      enableFishIntegration = true;
      enableZshIntegration = true;
      tmux.enableShellIntegration = true;
      colors = {
        fg = "#C8C093";
        "fg+" = "#DCD7BA";
        bg = "-1";
        "bg+" = "-1";
        hl = "#7FB4CA";
        "hl+" = "#957FB8";
        info = "#C8C093";
        marker = "#727169";
        prompt = "#98BB6C";
        spinner = "#E46876";
        pointer = "#E46876";
        header = "#658594";
        border = "#54546D";
        label = "#aeaeae";
        query = "#DCD7BA";
      };
    };
  };
}
