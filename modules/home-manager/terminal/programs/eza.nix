{ lib, config, ... }:
with lib;
let
  cfg = config.modules.terminal.programs.eza;
in
{
  options.modules.terminal.programs.eza = {
    enable = mkEnableOption "eza";
  };

  config = mkIf cfg.enable {
    programs.eza = {
      enable = true;
      enableFishIntegration = true;
      enableZshIntegration = true;
      enableNushellIntegration = true;
      extraOptions = [
        "--group-directories-first"
        "--header"
        "--long"
        "--time-style=relative"
      ];
    };
  };
}
