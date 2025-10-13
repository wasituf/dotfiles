{
  lib,
  config,
  inputs,
  user,
  ...
}:
with lib;
let
  cfg = config.modules.desktop.walker;
in
{
  imports = [
    inputs.walker.homeManagerModules.default
  ];

  options.modules.desktop.walker = {
    enable = mkEnableOption "walker";
  };

  config = mkIf cfg.enable {
    programs.walker = {
      enable = true;
      runAsService = true;
      config = {
        theme = "rosepine";
        force_keyboard_focus = true;
        keybinds = {
          next = [
            "Down"
            "ctrl n"
          ];
          previous = [
            "Up"
            "ctrl e"
          ];
          toggle_exact = [ ];
          quick_activate = [
            "ctrl 1"
            "ctrl 2"
            "ctrl 3"
            "ctrl 4"
          ];
        };
      };
    };

    home.file = {
      "/home/${user}/.config/walker/themes/rosepine/style.css".source = ./walker-themes/rosepine.css;
      "/home/${user}/.config/walker/themes/rosepine/layout.xml".source =
        ./walker-themes/rosepine-layout.xml;
    };
  };
}
