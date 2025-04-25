{
  lib,
  config,
  pkgs,
  inputs,
  ...
}:
with lib;
let
  cfg = config.modules.system.pointer;
in
{
  options.modules.system.pointer = {
    enable = mkEnableOption "pointer settings";
  };

  config = mkIf cfg.enable {
    home.pointerCursor = {
      enable = true;
      package = inputs.banana-cursor-catppuccin.packages.${pkgs.system}.banana-cursor-catppuccin;
      name = "Banana-Catppuccin-Mocha";
      size = 32;
      dotIcons.enable = true;
      gtk.enable = true;
      hyprcursor = {
        enable = true;
        size = 32;
      };
      x11 = {
        enable = true;
        defaultCursor = "left_ptr";
      };
    };
  };
}
