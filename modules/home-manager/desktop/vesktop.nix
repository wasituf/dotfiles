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
        checkUpdates = false;
        discordBranch = "stable";
        transparencyOption = "acrylic";
        tray = false;
        minimizeToTray = false;
        hardwareAcceleration = true;
        splashTheming = true;
        splashBackground = "#1F1F28";
        splashColor = "#DCD7BA";
      };
      vencord = {
        settings = {
          autoUpdate = false;
          autoUpdateNotification = false;
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
