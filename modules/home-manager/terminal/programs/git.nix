{
  config,
  lib,
  ...
}:
with lib;
let
  cfg = config.modules.terminal.programs.git;
in
{
  options.modules.terminal.programs.git = {
    enable = mkEnableOption "git";
  };

  config = mkIf cfg.enable {
    programs.git = {
      enable = true;
      settings = {
        user = {
          email = "wasit.allin1@proton.me";
          name = "wasituf";
        };
        core = {
          editor = "nvim";
          pager = "delta";
          init.defaultBranch = "main";
        };
        delta = {
          features = "side-by-side line-numbers decorations";
        };
      };
    };
  };
}
