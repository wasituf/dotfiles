{
  lib,
  config,
  ...
}:
with lib;
let
  cfg = config.modules.system.nh;
in
{
  options.modules.system.nh = {
    enable = mkEnableOption "nh";
  };

  config = mkIf cfg.enable {
    programs.nh = {
      enable = true;
      clean = {
        extraArgs = "--keep 3 --keep-since 3d";
        dates = "weekly";
      };
    };
  };

}
