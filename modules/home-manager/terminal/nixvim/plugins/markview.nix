{ ... }:
{
  programs.nixvim.plugins.markview = {
    enable = true;
    settings = {
      markdown = {
        headings = {
          __raw = ''require("markview.presets").headings.glow'';
        };
        horizontal_rules = {
          __raw = ''require("markview.presets").horizontal_rules.thick'';
        };
      };
      preview = {
        hybrid_modes = [
          "n"
          "no"
        ];
      };
      checkboxes = {
        __raw = ''require("markview.presets").checkboxes.nerd'';
      };
    };
  };
}
