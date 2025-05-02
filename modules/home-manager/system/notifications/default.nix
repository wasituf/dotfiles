{
  config,
  lib,
  ...
}:
with lib;
let
  cfg = config.modules.system.notifications;
in
{
  options.modules.system.notifications = {
    enable = mkEnableOption "notifications";
  };

  config = mkIf cfg.enable {
    services.wired = {
      enable = true;
      config = ./wired.ron;
    };
  };
}
