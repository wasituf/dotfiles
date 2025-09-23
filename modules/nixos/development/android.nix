{
  lib,
  config,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.modules.development.android;
in
{
  options.modules.development.android = {
    enable = mkEnableOption "android development tools";
  };

  config = mkIf cfg.enable {
    programs.adb.enable = true;
  };
}
