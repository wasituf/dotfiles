{
  lib,
  config,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.modules.displayManager;
in
{
  imports = [ ./hyprland.nix ];

  options.modules.displayManager = {
    enable = mkEnableOption "display manager";
    defaultSession = mkOption {
      type = types.enum [
        "hyprland"
      ];
      default = "hyprland";
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      where-is-my-sddm-theme
    ];
    services.displayManager = {
      enable = true;
      defaultSession = cfg.defaultSession;
      sddm = {
        enable = true;
        package = pkgs.kdePackages.sddm;
        theme = "where_is_my_sddm_theme";
        wayland.enable = true;
      };
    };
  };
}
