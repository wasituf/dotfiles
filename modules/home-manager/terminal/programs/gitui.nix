{ lib, config, ... }:
with lib;
let
  cfg = config.modules.terminal.programs.gitui;
in
{
  options.modules.terminal.programs.gitui = {
    enable = mkEnableOption "gitui";
  };

  config = mkIf cfg.enable {
    programs.gitui = {
      enable = true;
      keyConfig = ''
        move_left: Some(( code: Char('m'), modifiers: "")),
        move_right: Some(( code: Char('i'), modifiers: "")),
        move_up: Some(( code: Char('e'), modifiers: "")),
        move_down: Some(( code: Char('n'), modifiers: "")),
      '';
    };
  };
}
