{
  config,
  lib,
  ...
}:
with lib;
let
  cfg = config.modules.terminal.programs.tealdeer;
in
{
  options.modules.terminal.programs.tealdeer = {
    enable = mkEnableOption "tealdeer";
  };

  config = mkIf cfg.enable {
    programs.tealdeer = {
      enable = true;
      enableAutoUpdates = true;
      settings.updates = {
        auto_update = true;
        auto_update_interval_hours = 24;
      };
    };
  };
}
