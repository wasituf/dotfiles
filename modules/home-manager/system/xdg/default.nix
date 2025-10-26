{ lib, config, ... }:
with lib;
let
  cfg = config.modules.system.xdg;
in
{
  imports = [ ./defaultApplications.nix ];

  options.modules.system.xdg = {
    enable = mkEnableOption "xdg";
  };

  config = mkIf cfg.enable {
    xdg = {
      enable = true;
      configFile."mimeapps.list".force = true;
    };
  };
}
