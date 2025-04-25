{ lib, config, ... }:
with lib;
let
  cfg = config.modules.graphics.nvidia;
in
{
  options.modules.graphics.nvidia = {
    enable = mkEnableOption "nvidia settings";
  };

  config = mkIf cfg.enable {
    hardware.nvidia = {
      modesetting.enable = true;
      open = false;
      nvidiaSettings = true;
      package = config.boot.kernelPackages.nvidiaPackages.latest;
    };
  };
}
