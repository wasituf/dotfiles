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
    xdg.mimeApps.defaultApplications = {
      "inode/directory" = [ "org.gnome.Nautilus.desktop" ];
      "text/html" = [
        "zen-beta.desktop"
        "brave-browser.desktop"
      ];
      "x-scheme-handler/http" = [
        "zen-beta.desktop"
        "brave-browser.desktop"
      ];
      "x-scheme-handler/https" = [
        "zen-beta.desktop"
        "brave-browser.desktop"
      ];
      "x-scheme-handler/about" = [
        "zen-beta.desktop"
        "brave-browser.desktop"
      ];
      "x-scheme-handler/unknown" = [
        "zen-beta.desktop"
        "brave-browser.desktop"
      ];
    };
  };
}
