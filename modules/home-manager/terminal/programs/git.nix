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
      userEmail = "wasit.allin1@proton.me";
      userName = "wasituf";
      # signing = {
      #   key = "0xF7A4C4E3E8C0D1D2";
      #   signByDefault = true;
      # };
      extraConfig = {
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
