{ config, lib, ... }:
with lib;
let
  cfg = config.modules.services.easyeffects;
in
{
  options.modules.services.easyeffects = {
    enable = mkEnableOption "easyeffects";
  };

  config = mkIf cfg.enable {
    services.easyeffects = {
      enable = true;
    };
  };
}
