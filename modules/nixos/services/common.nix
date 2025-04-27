{
  lib,
  config,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.modules.services.common;
in
{
  options.modules.services.common = {
    enable = mkEnableOption "common services";
  };

  config = mkIf cfg.enable {
    services = {
      pipewire = {
        enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;
        jack.enable = true;
      };
      printing = {
        enable = true;
        drivers = [ pkgs.hplipWithPlugin ];
      };
      openssh.enable = true;
      libinput = {
        enable = true;
        mouse = {
          accelProfile = "flat";
          transformationMatrix = "0.5 0 0 0 0.5 0 0 0 1";
        };
      };
    };
  };
}
