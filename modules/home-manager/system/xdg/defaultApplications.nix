{ lib, config, ... }:
with lib;
let
  cfg = config.modules.system.xdg.defaultApplications;
  defaultFileManagers = [ "org.gnome.Nautilus.desktop" ];
  defaultBrowsers = [
    "zen-beta.desktop"
    "brave-browser.desktop"
  ];
  defaultPdfReaders = [
    "org.pwmt.zathura.desktop"
    "zen-beta.desktop"
  ];
  defaultImageViewers = [
    "org.gnome.Loupe.desktop"
    "feh"
  ];
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
        "inode/directory" = defaultFileManagers;
        "application/pdf" = defaultPdfReaders;

        "text/html" = defaultBrowsers;
        "x-scheme-handler/http" = defaultBrowsers;
        "x-scheme-handler/https" = defaultBrowsers;
        "x-scheme-handler/about" = defaultBrowsers;
        "x-scheme-handler/unknown" = defaultBrowsers;

        "image/svg+xml" = defaultBrowsers;
        "image/png" = defaultImageViewers;
        "image/jpeg" = defaultImageViewers;
        "image/jpg" = defaultImageViewers;
        "image/gif" = defaultImageViewers;
        "image/bmp" = defaultImageViewers;
        "image/tiff" = defaultImageViewers;
        "image/webp" = defaultImageViewers;
        "image/avif" = defaultImageViewers;
      };
    };
  };
}
