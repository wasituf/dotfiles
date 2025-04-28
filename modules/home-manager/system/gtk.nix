{
  lib,
  config,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.modules.system.gtk;
in
{
  options.modules.system.gtk = {
    enable = mkEnableOption "gtk settings";
  };

  config = mkIf cfg.enable {
    dconf = {
      enable = true;
      settings = {
        "org/gnome/desktop/interface" = {
          color-scheme = "prefer-dark";
        };
      };
    };

    gtk = {
      enable = true;
      theme = {
        name = "orchis-dark";
        package = pkgs.orchis-theme;
      };
      iconTheme = {
        name = "Tela-black-dark";
        package = pkgs.tela-icon-theme;
      };
      font = {
        name = "Satoshi Variable";
        package = null;
        size = 10;
      };
    };
  };
}
