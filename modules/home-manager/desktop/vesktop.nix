{
  config,
  lib,
  ...
}:
with lib;
let
  cfg = config.modules.desktop.vesktop;
in
{
  options.modules.desktop.vesktop = {
    enable = mkEnableOption "vesktop";
  };

  config = mkIf cfg.enable {
    programs.vesktop = {
      enable = true;
      settings = {
        appBadge = false;
        arRPC = true;
        checkUpdates = true;
        discordBranch = "stable";
        transparencyOption = "acrylic";
        tray = true;
        minimizeToTray = true;
        hardwareAcceleration = true;
        splashTheming = true;
        splashBackground = "#191724";
        splashColor = "#ebbcba";
      };
      vencord = {
        settings = {
          autoUpdate = true;
          autoUpdateNotification = true;
          enabledThemes = [ "midnight.css" ];
          frameless = true;
          transparent = true;
          winNativeTitleBar = true;
        };
        themes = {
          midnight = ''
            @import "https://raw.githubusercontent.com/refact0r/midnight-discord/refs/heads/master/themes/flavors/midnight-rose-pine.theme.css";
          '';
        };
      };
    };
  };
}
