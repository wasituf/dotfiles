{
  config,
  lib,
  ...
}:
with lib;
let
  cfg = config.modules.zathura;
in
{
  options.modules.zathura = {
    enable = mkEnableOption "zathura";
  };

  config = mkIf cfg.enable {
    programs.zathura = {
      enable = true;
      mappings = {
        n = "scroll down";
        e = "scroll up";
        m = "scroll left";
        i = "scroll right";
        "N" = "navigate next";
        "E" = "navigate previous";
        "M" = "goto page_top";
        "I" = "goto page_bottom";

        "<C-n>" = "scroll half-down";
        "<C-e>" = "scroll half-up";

        "[index] n" = "navigate_index down";
        "[index] e" = "navigate_index up";
      };
      options = {
        adjust-open = "width";
        continuous-hist-save = "true";
        database = "sqlite";

        default-bg = "#16161D";
        default-fg = "#DCD7BA";
        inputbar-bg = "#2A2A37";
        inputbar-fg = "#C8C093";
        statusbar-bg = "#1F1F28";
        statusbar-fg = "#DCD7BA";
        highlight-active-color = "#2D4F67";
        highlight-color = "#223249";
        highlight-fg = "#D27E99";
        recolor-keephue = true;
        recolor-lightcolor = "#1F1F28";
        recolor-darkcolor = "#DCD7BA";
      };
      extraConfig = ''
        include catppuccin-mocha
      '';
    };
  };
}
