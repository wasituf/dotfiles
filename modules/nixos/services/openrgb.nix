{
  lib,
  config,
  ...
}:
with lib;
let
  cfg = config.modules.services.openrgb;
in
{
  options.modules.services.openrgb = {
    enable = mkEnableOption "openrgb";
  };

  config = mkIf cfg.enable {
    services.hardware.openrgb = {
      enable = true;
      motherboard = "amd";
    };
  };
}
