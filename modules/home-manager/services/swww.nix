{ config, lib, ... }:
with lib;
let
  cfg = config.modules.services.swww;
in
{
  options.modules.services.swww = {
    enable = mkEnableOption "swww";
  };

  config = mkIf cfg.enable {
    services.swww = {
      enable = true;
    };
  };
}
