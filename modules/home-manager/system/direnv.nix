{ lib, config, ... }:
with lib;
let
  cfg = config.modules.system.direnv;
in
{
  options.modules.system.direnv = {
    enable = mkEnableOption "direnv";
  };

  config = mkIf cfg.enable {
    programs.direnv = {
      enable = true;
      nix-direnv.enable = true;
      silent = true;
    };
  };
}
