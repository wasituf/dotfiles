{ lib, config, ... }:
with lib;
let
  cfg = config.modules.hyprland;
in
{
  imports = [
    ./waybar
  ];

  options.modules.hyprland = {
    enable = mkEnableOption "hyprland";
    theme = mkOption {
      type = types.enum [
        "kanagawa"
        "rose-pine"
      ];
      default = "kanagawa";
      description = "The theme applied to hyprland.";
      example = "rose-pine";
    };
  };

  config = mkIf cfg.enable {
    home.sessionVariables.NIXOS_OZONE_WL = "1";
    # wayland.windowManager.hyprland = {
    #   enable = true;
    #   package = null;
    #   configType = "lua";
    #   portalPackage = null;
    #   systemd.variables = [ "--all" ];
    #   settings.config.general = mkMerge [
    #     (mkIf (cfg.theme == "rose-pine") {
    #       "col.active_border" = "0xff403d52";
    #       "col.inactive_border" = "0xff26233a";
    #     })
    #     (mkIf (cfg.theme == "kanagawa") {
    #       "col.active_border" = "0xff54546D";
    #       "col.inactive_border" = "0xff363646";
    #     })
    #   ];

    home.file = {
      ".config/hypr/hyprland.lua".source = ./hyprland.lua;
    };
  };
}
