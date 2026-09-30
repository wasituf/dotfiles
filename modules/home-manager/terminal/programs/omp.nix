{
  lib,
  config,
  inputs,
  ...
}:
with lib;
let
  cfg = config.modules.terminal.programs.omp;
in
{
  imports = [ inputs.omp.homeManagerModules.default ];

  options.modules.terminal.programs.omp = {
    enable = mkEnableOption "oh my pi";
  };

  config = mkIf cfg.enable {

    programs.omp = {
      enable = true;
      settings = {
        theme.dark = "titanium";
        startup.quiet = true;
      };
    };
  };
}
