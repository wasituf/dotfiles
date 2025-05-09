{
  lib,
  config,
  user,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.modules.gaming;
in
{
  imports = [ ./terraria ];

  options.modules.gaming = {
    enable = mkEnableOption "gaming";
  };

  config = mkIf cfg.enable {
    programs.steam = {
      enable = true;
      protontricks.enable = true;
      gamescopeSession.enable = true;
      extraPackages = with pkgs; [
        mangohud
      ];
    };

    programs.gamemode = {
      enable = true;
      settings = {
        custom = {
          start = "${pkgs.libnotify}/bin/notify-send 'GameMode started'";
          end = "${pkgs.libnotify}/bin/notify-send 'GameMode ended'";
        };
      };
    };

    environment.systemPackages = with pkgs; [
      protonup
    ];

    environment.sessionVariables = {
      STEAM_EXTRA_COMPAT_TOOLS_PATHS = "/home/${user}/.steam/root/compatibilitytools.d";
    };
  };
}
