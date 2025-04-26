{ lib, config, ... }:
with lib;
let
  cfg = config.modules.desktop.fuzzel;
in
{
  options.modules.desktop.fuzzel = {
    enable = mkEnableOption "fuzzel";
  };

  config = mkIf cfg.enable {
    programs.fuzzel = {
      enable = true;
      settings = {
        main = {
          terminal = "ghostty";
          font = "JetBrainsMono NFM Medium:size=10";
          prompt = "'✨ '";
          lines = "6";
          width = "40";
          tabs = "4";
          horizontal-pad = "16";
          vertical-pad = "10";
          inner-pad = "10";
          line-height = "28";
        };

        colors = {
          background = "1e1e2eff";
          text = "cdd6f4ff";
          match = "fab387ff";
          selection = "9399b2ff";
          selection-text = "181825ff";
          selection-match = "313244ff";
          border = "b4befeff";
        };

        border = {
          width = "2";
          radius = "10";
        };

        key-bindings = {
          # Unbind keys
          cursor-end = "none";
          next = "none";

          # Bind keys
          prev-with-wrap = "Control+e";
          next-with-wrap = "Control+n";
        };
      };
    };
  };
}
