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
      desktopManager.runXdgAutostartIfNone = true;
      xkb = {
        layout = "us";
        variant = "colemak_dh";
      };
    };

    i18n.inputMethod = {
      enable = true;
      type = "fcitx5";
      # NOTE: update system when #455690 is merged
      fcitx5 = {
        waylandFrontend = true;
        addons = with pkgs; [
          fcitx5-mozc
          # fcitx5-openbangla-keyboard
          fcitx5-gtk
          kdePackages.fcitx5-qt
          fcitx5-fluent
          fcitx5-rose-pine
        ];
      };
    };

    environment.systemPackages = with pkgs; [ kdePackages.fcitx5-configtool ];
  };
}
