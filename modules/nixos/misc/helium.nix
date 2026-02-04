{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.modules.misc.helium;
in
{
  options.modules.misc.helium = {
    enable = lib.mkEnableOption "helium";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      nur.repos.Ev357.helium
    ];
  };
}
