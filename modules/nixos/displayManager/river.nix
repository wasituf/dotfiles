{
  lib,
  config,
  ...
}:
with lib;
let
  cfg = config.modules.displayManager.river;
in
{
  options.modules.displayManager.river = {
    enable = mkEnableOption "river";
  };

  config = mkIf cfg.enable {
    environment.sessionVariables.NIXOS_OZONE_WL = "1";
    programs.river-classic = {
      enable = true;
    };
  };
}
