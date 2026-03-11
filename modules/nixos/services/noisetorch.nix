{ config, lib, ... }:
with lib;
let
  cfg = config.modules.services.noisetorch;
in
{
  options.modules.services.noisetorch = {
    enable = mkEnableOption "noisetorch";
  };

  config = mkIf cfg.enable {
    programs.noisetorch.enable = true;
  };
}
