{ lib, config, ... }:
with lib;
let
  cfg = config.modules.eza;
in
{
  options.modules.eza = {
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
