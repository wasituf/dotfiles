{
  config,
  lib,
  pkgs,
  ...
}:

with lib;

let
  cfg = config.modules.desktop.mangohud;
in
{
  options.modules.desktop.mangohud = {
    enable = mkEnableOption "mangohud";
  };

  config = mkIf cfg.enable {
    programs.mangohud = {
      enable = true;
      settings = {
        font_file_text = "Jost*";
        font_size = 18;
        preset = 1;
      };
    };
  };
}
