{
  lib,
  config,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.modules.system.virtualisation;
in
{
  options.modules.system.virtualisation = {
    enable = mkEnableOption "virtualisation settings for docker/podman";
  };

  config = mkIf cfg.enable {
    hardware.nvidia-container-toolkit.enable = true;
    virtualisation = {
      podman = {
        enable = true;
        dockerCompat = true;
        defaultNetwork.settings.dns_enabled = true;
      };
    };

    environment.systemPackages = with pkgs; [
      podman-tui
      podman-compose
    ];
  };
}
