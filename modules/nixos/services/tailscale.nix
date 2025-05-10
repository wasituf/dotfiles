{
  config,
  lib,
  ...
}:
with lib;
let
  cfg = config.modules.services.tailscale;
in
{
  options.modules.services.tailscale = {
    enable = mkEnableOption "tailscale";
  };

  config = mkIf cfg.enable {
    services.tailscale = {
      enable = true;
      # authKeyFile = config.age.secrets.tailscale_authkey.path;
    };
  };
}
