{ lib, config, ... }:
with lib;
let
  cfg = config.modules.graphics.qt;
in
{
  options.modules.graphics.qt = {
    enable = mkEnableOption "qt";
  };

  config = mkIf cfg.enable {
    qt = {
      enable = true;
      platformTheme = "gtk2";
      style = "gtk2";
    };
  };
}
