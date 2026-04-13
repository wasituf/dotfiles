{ lib, config, ... }:
with lib;
let
  cfg = config.modules.services.nohang;
in
{
  options.modules.services.nohang = {
    enable = mkEnableOption "nohang";
  };

  config = mkIf cfg.enable {
    services.nohang = {
      enable = true;
      configPath = "desktop";
    };
  };
}
