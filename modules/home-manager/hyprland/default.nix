{ lib, config, ... }:
with lib;
let
  cfg = config.modules.hyprland;
in
{
  imports = [
    ./binds.nix
    ./plugins.nix
    ./settings.nix
    ./windowrules.nix
  ];

  options.modules.hyprland = {
    enable = mkEnableOption "hyprland";
  };

  config = mkIf cfg.enable {
    home.sessionVariables.NIXOS_OZONE_WL = "1";
    wayland.windowManager.hyprland = {
      enable = true;
      package = null;
      portalPackage = null;
      systemd.variables = [ "--all" ];
    };
  };
}
