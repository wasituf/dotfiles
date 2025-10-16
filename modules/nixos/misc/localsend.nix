{ config, lib, ... }:
with lib;
let
  cfg = config.modules.misc.localsend;
in
{
  options.modules.misc.localsend = {
    enable = lib.mkEnableOption "localsend";
  };

  config = mkIf cfg.enable {
    programs.localsend = {
      enable = true;
      openFirewall = true;
    };
  };
}
