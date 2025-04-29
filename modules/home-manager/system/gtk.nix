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
        name = "Orchis-Grey-Dark";
        package = pkgs.orchis-theme;
      };
      iconTheme = {
        name = "Tela-black-dark";
        package = pkgs.tela-icon-theme;
      };
      font = {
        name = "Jost*";
        package = null;
        size = 11;
      };
    };
  };
}
