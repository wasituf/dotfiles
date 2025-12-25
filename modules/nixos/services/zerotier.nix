{
  config,
  lib,
  ...
}:
with lib;
let
  cfg = config.modules.services.zerotier;
in
{
  options.modules.services.zerotier = {
    enable = mkEnableOption "zerotier";
  };

  config = mkIf cfg.enable {
    services.zerotierone = {
      enable = true;
      joinNetworks = [ "08752e18b169664d" ];
    };
  };
}
