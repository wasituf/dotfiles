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
        hide-cursor = {
          timeout = 5000;
          when-typing = true;
        };
        map = {
          normal = {
            "Alt Q" = "close";
            "Super+Shift Q" = "exit";
            "Super F" = "toggle-fullscreen";
            "Super S" = "toggle-float";
            "Super Space" = "spawn \"pkill tofi ; tofi-drun | xargs -I {} riverctl spawn \"{}\"\"";
            "Alt Return" = "spawn ghostty";
            "Super Return" = "spawn ghostty";
            "Super Period" = "focus-output next";
            "Super Comma" = "focus-output previous";
            "Super+Shift Period" = "send-to-output next";
            "Super+Shift Comma" = "send-to-output previous";

            "Super ]" = "focus-view next";
            "Super [" = "focus-view previous";
            "Super M" = "focus-view left";
            "Super N" = "focus-view down";
            "Super E" = "focus-view up";
            "Super I" = "focus-view right";

            "Super+Shift [" = "swap next";
            "Super+Shift ]" = "swap previous";
            "Super+Shift M" = "swap left";
            "Super+Shift N" = "swap down";
            "Super+Shift E" = "swap up";
            "Super+Shift I" = "swap right";

            "Alt 1" = "set-focused-tags 1";
            "Alt 2" = "set-focused-tags 2";
            "Alt 3" = "set-focused-tags 4";
            "Alt 4" = "set-focused-tags 8";
            "Alt 5" = "set-focused-tags 16";
            "Alt 6" = "set-focused-tags 32";
            "Alt 7" = "set-focused-tags 64";
            "Alt 8" = "set-focused-tags 128";
            "Alt 9" = "set-focused-tags 256";
            "Alt 0" = "set-focused-tags 512";

            "Alt+Shift 1" = "set-view-tags 1";
            "Alt+Shift 2" = "set-view-tags 2";
            "Alt+Shift 3" = "set-view-tags 4";
            "Alt+Shift 4" = "set-view-tags 8";
            "Alt+Shift 5" = "set-view-tags 16";
            "Alt+Shift 6" = "set-view-tags 32";
            "Alt+Shift 7" = "set-view-tags 64";
            "Alt+Shift 8" = "set-view-tags 128";
            "Alt+Shift 9" = "set-view-tags 256";
            "Alt+Shift 0" = "set-view-tags 512";
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
