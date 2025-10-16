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
        default-layout = "rivertile";
        border-width = 1;
        border-color-focused = "0xff403d52";
        border-color-unfocused = "0xff26233a";
        declare-mode = [
          "locked"
          "normal"
          "passthrough"
        ];
        keyboard-layout = "-variant colemak_dh us";
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
            "Super+Shift Q" = "exit";
            "Super F" = "toggle-fullscreen";
            "Super Space" = "spawn 'nc -U /run/user/1000/walker/walker.sock'";
            "Alt Return" = "spawn ghostty";
            "Super Return" = "spawn ghostty";
            "Super N" = "focus-view next";
            "Super E" = "focus-view previous";
            "Super+Shift N" = "swap next";
            "Super+Shift E" = "swap previous";
            "Super Period" = "focus-output next";
            "Super Comma" = "focus-output previous";
            "Super+Shift Period" = "send-to-output next";
            "Super+Shift Comma" = "send-to-output previous";
          };
        };
        map-pointer = {
          normal = {
            "Super BTN_LEFT" = "move-view";
            "Super BTN_RIGHT" = "resize-view";
          };
        };
      };
      extraConfig = ''
        rivertile -view-padding 0 -outer-padding 0 &
        fcitx5 -d -r &
        fcitx5-remote -r &
      '';
    };
  };
}
