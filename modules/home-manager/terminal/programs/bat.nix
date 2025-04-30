{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.modules.terminal.programs.bat;
in
{
  options.modules.terminal.programs.bat = {
    enable = mkEnableOption "bat";
  };

  config = mkIf cfg.enable {
    programs.bat = {
      enable = true;
      config = {
        theme = "kanagawa";
        pager = "less -R";
        style = "full";
        color = "always";
        decorations = "always";
      };
      themes = {
        kanagawa = {
          src = pkgs.fetchFromGitHub {
            owner = "rebelot";
            repo = "kanagawa.nvim";
            rev = "cc3b68b08e6a0cb6e6bf9944932940091e49bb83";
            sha256 = "PwvDbYSq5sa6LCMjEGovjSqUFdOH0J4W/zivzogqIVY=";
          };
          file = "extras/tmTheme/kanagawa.tmTheme";
        };
      };
    };
  };
}
