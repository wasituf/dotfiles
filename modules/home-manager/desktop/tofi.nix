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
        font = "${pkgs.jetbrains-mono}/share/fonts/opentype/JetBrainsMono-Regular.otf";
        font-size = 11;
        font-variations = "wght 400";
        hint-font = false;

        text-color = "#e0def4";
        prompt-color = "#191724";
        input-color = "#908caa";
        input-background-padding = "24,-1,24,-1";
        default-result-background = "#191724";
        default-result-background-padding = "8,-1,8,-1";
        selection-color = "#eb6f92";
        selection-background = "#26233a";
        selection-background-padding = "8,-1,8,-1";
        selection-background-corner-radius = 6;

        text-cursor-style = "bar";

        prompt-text = "/";
        prompt-padding = 3;
        num-results = 8;
        result-spacing = 16;

        width = 260;
        height = 321;
        background-color = "#191724";
        outline-width = 0;
        outline-color = "#403d52";
        border-width = 1;
        border-color = "#403d52";
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
