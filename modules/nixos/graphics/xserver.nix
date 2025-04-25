{ lib, config, ... }:
with lib;
let
  cfg = config.modules.graphics.xserver;
in
{
  options.modules.graphics.xserver = {
    enable = mkEnableOption "xserver settings";
  };

  config = mkIf cfg.enable {
    services.xserver = {
      enable = true;
      videoDrivers = [ "nvidia" ];
      xkb = {
        layout = "us";
        variant = "colemak_dh";
      };
    };

  };
}
