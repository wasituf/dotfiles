{ lib, config, ... }:
with lib;
let
  cfg = config.modules.services.hyprpaper;
in
{
  options.modules.services.hyprpaper = {
    enable = mkEnableOption "hyprpaper";
  };

  config = mkIf cfg.enable {
    services.hyprpaper = {
      enable = true;
      settings = {
        ipc = "on";
        preload = [ "$HOME/wallpapers/wallhaven-y8267k.png" ];
        wallpaper = [ "HDMI-A-1,$HOME/wallpapers/wallhaven-y8267k.png" ];
      };
    };
  };
}
