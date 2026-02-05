{
  lib,
  config,
  ...
}:
with lib;
let
  cfg = config.modules.terminal.emulators.ghostty;
in
{
  options.modules.terminal.emulators.ghostty = {
    enable = mkEnableOption "ghostty";
    theme = mkOption {
      type = types.enum [
        "Kanagawa Dragon"
        "Kanagawa Wave"
        "catppuccin-mocha"
        "Rose Pine"
      ];
      default = "Kanagawa Wave";
      example = "Kanagawa Wave";
      description = "Theme for ghostty. Kanagawa Wave | catppuccin | Rose Pine";
    };
  };

  # Hello
  config = mkIf cfg.enable {
    programs.ghostty = {
      enable = true;
      settings = {
        font-family = [
          "MonaspiceNe Nerd Font"
          "JetBrainsMono NF"
          "LINE Seed JP_TTF"
        ];
        font-size = 12;
        font-style = "Regular";
        font-style-bold = "Bold";
        font-style-italic = "Light Italic";
        font-style-bold-italic = "Bold Italic";
        font-feature = "calt,ss01,ss02,ss03,ss04,ss05,ss06,ss07,ss08,ss09,ss10,liga";
        window-decoration = false;
        window-padding-x = 0;
        window-padding-y = "0,0";
        window-padding-balance = true;
        theme = cfg.theme;
        background-opacity = 0.97;
        background-blur-radius = 24;

        keybind = [
          "ctrl+backspace=text:\\x1b\\x7f"
          "ctrl+alt+y=jump_to_prompt:-1"
          "ctrl+alt+u=jump_to_prompt:1"
        ];
      };
    };
  };
}
