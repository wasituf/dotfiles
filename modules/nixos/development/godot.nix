{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.modules.development.godot;
in
{
  options.modules.development.godot = {
    enable = mkEnableOption "godot development tools";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ godot ];
  };
}
