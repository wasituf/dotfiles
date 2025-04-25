{
  lib,
  config,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.modules.system.shell;
in
{
  options.modules.system.shell = {
    enable = mkEnableOption "shell";
    shell = mkOption {
      type = types.enum [
        "fish"
        "zsh"
        "nushell"
      ];
      default = "fish";
    };
  };

  config = mkMerge [
    (mkIf (cfg.enable && cfg.shell == "fish")
    {
      programs.fish.enable = true;
      programs.bash = {
        interactiveShellInit = ''
          if [[ $(${pkgs.procps}/bin/ps --no-header --pid=$PPID --format=comm) != "fish" && -z ''${BASH_EXECUTION_STRING} ]]
          then
            shopt -q login_shell && LOGIN_OPTION='--login' || LOGIN_OPTION=""
            exec ${pkgs.fish}/bin/fish $LOGIN_OPTION
          fi
        '';
      };
    })
  ];
}
