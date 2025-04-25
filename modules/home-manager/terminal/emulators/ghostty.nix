{
  lib,
  config,
  ...
}:
with lib;
let
  cfg = config.modules.ghostty;
in
{
  options.modules.ghostty = {
    enable = mkEnableOption "ghostty";
    theme = mkOption {
      type = types.enum [
        "Kanagawa Wave"
        "catppuccin-mocha"
        "rose-pine"
      ];
      default = "Kanagawa Wave";
      example = "Kanagawa Wave";
      description = "Theme for ghostty. Kanagawa Wave | catppuccin | rose-pine";
    };
  };

  config = mkIf cfg.enable {
    programs.ghostty = {
      enable = true;
      settings = {
        font-family = "JetBrainsMono NF";
        font-size = 12;
        font-style = "Medium";
        font-style-bold = "Bold";
        font-style-italic = "Medium Italic";
        font-style-bold-italic = "Bold Italic";
        window-decoration = false;
        window-padding-x = 4;
        window-padding-y = 4;
        window-padding-balance = true;
        theme = cfg.theme;
        background-opacity = 1;
        background-blur-radius = 20;

        keybind = [
          "ctrl+backspace=text:\x1b\x7f"
          "ctrl+alt+y=jump_to_prompt:-1"
          "ctrl+alt+u=jump_to_prompt:1"
        ];
      };
    };
  };
}
