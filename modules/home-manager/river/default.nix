{ lib, config, ... }:
with lib;
let
  cfg = config.modules.river;
in
{
  imports = [
  ];

  options.modules.river = {
    enable = mkEnableOption "river";
  };

  config = mkIf cfg.enable {
    home.sessionVariables.NIXOS_OZONE_WL = "1";
    wayland.windowManager.river = {
      enable = true;
      package = null;
      systemd.variables = [ "--all" ];
      settings = {
        border-width = 1;
        declare-mode = [
          "locked"
          "normal"
          "passthrough"
        ];
        input = {
          pointer = {
            accel-profile = "flat";
            events = true;
            pointer-accel = -0.25;
            tap = false;
          };
        };
        map = {
          normal = {
            "Alt Q" = "close";
            "Alt Return" = "spawn ghostty";
          };
        };
        # xcursor-theme = "Banana-Catppuccin-Mocha 24";
      };
    };
  };
}
