{
  lib,
  config,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.modules.system.keyboard;
in
{
  options.modules.system.keyboard = {
    enable = mkEnableOption "system keyboard/layout settings";
  };

  config = mkIf cfg.enable {
    services.xserver = {
      xkb = {
        layout = "us";
        variant = "colemak_dh";
      };
    };

    i18n.inputMethod = {
      enable = true;
      type = "fcitx5";
      fcitx5 = {
        waylandFrontend = true;
        addons = with pkgs; [
          fcitx5-mozc
          fcitx5-gtk
          fcitx5-mellow-themes
          fcitx5-fluent
          fcitx5-material-color
          kdePackages.fcitx5-configtool
        ];
      };
    };
  };
}
