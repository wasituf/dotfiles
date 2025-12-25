{ config, lib, ... }:
with lib;
let
  cfg = config.modules.misc.ydotool;
in
{
  options.modules.misc.ydotool = {
    enable = lib.mkEnableOption "ydotool";
  };

  config = mkIf cfg.enable {
    programs.ydotool = {
      enable = true;
    };
  };
}
