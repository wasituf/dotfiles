{ lib, config, ... }:
with lib;
let
  cfg = config.modules.services.keyd;
in
{
  options.modules.services.keyd = {
    enable = mkEnableOption "keyd";
  };

  config = mkIf cfg.enable {
    services.keyd = {
      enable = true;
      keyboards = {
        default = {
          ids = [ "*" ];
          settings = {
            main = {
              capslock = "overload(control, esc)";
              esc = "capslock";
              rightalt = "leftalt";
              volumeup = "f7";
            };
          };
        };
      };
    };
  };
}
