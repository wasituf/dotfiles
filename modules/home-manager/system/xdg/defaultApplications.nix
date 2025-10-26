{ lib, config, ... }:
with lib;
let
  cfg = config.modules.system.xdg.defaultApplications;
in
{
  options.modules.system.xdg.defaultApplications = {
    enable = mkEnableOption "defaultApplications";
  };

  config = mkIf cfg.enable {
    xdg.mimeApps = {
      enable = true;
      associations.removed = {
      };
      defaultApplications = {
        "inode/directory" = [ "org.gnome.Nautilus.desktop" ];
        "text/html" = "zen-beta.desktop";
        "x-scheme-handler/http" = "zen-beta.desktop";
        "x-scheme-handler/https" = "zen-beta.desktop";
        "x-scheme-handler/about" = "zen-beta.desktop";
        "x-scheme-handler/unknown" = "zen-beta.desktop";
        "application/pdf" = "org.pwmt.zathura.desktop";
      };
    };
  };
}
