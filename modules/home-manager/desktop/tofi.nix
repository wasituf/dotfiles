{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.modules.desktop.tofi;
in
{
  options.modules.desktop.tofi = {
    enable = mkEnableOption "tofi";
  };

  config = mkIf cfg.enable {
    programs.tofi = {
      enable = true;
      settings = {
        font = "${pkgs.jost}/share/fonts/opentype/Jost-400-Book.otf";
        font-size = 11;
        font-variations = "wght 400";
        hint-font = false;

        text-color = "#DCD7BA";
        prompt-color = "#1F1F28";
        input-color = "#727169";
        input-background-padding = "24,-1,24,-1";
        default-result-background = "#1F1F28";
        default-result-background-padding = "8,-1,8,-1";
        selection-color = "#FFA066";
        selection-background = "#363646";
        selection-background-padding = "8,-1,8,-1";
        selection-background-corner-radius = 6;

        text-cursor-style = "bar";

        prompt-text = "/";
        prompt-padding = 3;
        num-results = 7;
        result-spacing = 16;

        width = 260;
        height = 301;
        background-color = "#1F1F28";
        outline-width = 0;
        outline-color = "#54546D";
        border-width = 1;
        border-color = "#54546D";
        corner-radius = 8;
        padding-top = 8;
        padding-bottom = 3;
        padding-left = 3;
        padding-right = 3;

        anchor = "center";

        # matching-algorithm = "fuzzy";
        drun-launch = false;
        ascii-input = false;
      };
    };
  };
}
