{
  lib,
  config,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.modules.terminal.programs.omp;
in
{
  options.modules.terminal.programs.omp = {
    enable = mkEnableOption "oh my pi";
  };

  config = mkIf cfg.enable {
    home.packages = [
      (pkgs.callPackage ../../../../pkgs/omp { })
    ];
  };
}
