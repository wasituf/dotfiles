{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:
with lib;
let
  cfg = config.modules.system.shell;
in
{
  imports = [ inputs.nix-index-database.homeModules.nix-index ];

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
    theme = mkOption {
      type = types.enum [
        "kanagawa"
        "rose-pine"
      ];
      default = "kanagawa";
    };
  };

  config = mkMerge [
    (mkIf (cfg.enable && cfg.shell == "fish") {
      home.file = {
        ".config/fish/themes/kanagawa.theme".source = ./fishThemes/kanagawa.theme;
        ".config/fish/themes/rose-pine.theme".source = ./fishThemes/rose-pine.theme;
      };
      home.packages = with pkgs; [ any-nix-shell ];
      home.shell.enableFishIntegration = true;
      programs.nix-index = {
        enable = true;
        enableFishIntegration = true;
      };
      programs.fish = {
        enable = true;
        interactiveShellInit = mkMerge [
          (mkIf (cfg.theme == "rose-pine") ''
            set fish_greeting # Disable greeting
            set fish_escape_delay_ms 100

            set --universal pure_show_system_time false
            set --universal pure_truncate_prompt_current_directory_keeps 2
            set --universal pure_show_jobs true
            set --universal pure_enable_nixdevshell true
            set --universal pure_enable_single_line_prompt true
            set --universal pure_show_prefix_root_prompt true

            # Rosé Pine Fish shell theme
            fish_config theme choose "rose-pine"
          '')
          (mkIf (cfg.theme == "kanagawa") ''
            set fish_greeting # Disable greeting
            set fish_escape_delay_ms 100

            set --universal pure_show_system_time false
            set --universal pure_truncate_prompt_current_directory_keeps 2
            set --universal pure_show_jobs true
            set --universal pure_enable_nixdevshell true
            set --universal pure_enable_single_line_prompt true
            set --universal pure_show_prefix_root_prompt true

            # Kanagawa Fish shell theme
            set -l foreground DCD7BA normal
            set -l selection 2D4F67 brcyan
            set -l comment 727169 brblack
            set -l red C34043 red
            set -l orange FF9E64 brred
            set -l yellow C0A36E yellow
            set -l green 76946A green
            set -l purple 957FB8 magenta
            set -l cyan 7AA89F cyan
            set -l pink D27E99 brmagenta

            fish_config theme choose "kanagawa"
          '')
        ];
        shellInitLast = ''
          any-nix-shell fish --info-right | source
        '';
        generateCompletions = true;
        plugins = [
          {
            name = "bang-bang";
            src = pkgs.fishPlugins.bang-bang.src;
          }
          {
            name = "colored-man-pages";
            src = pkgs.fishPlugins.colored-man-pages.src;
          }
          {
            name = "done";
            src = pkgs.fishPlugins.done.src;
          }
          {
            name = "fish-you-should-use";
            src = pkgs.fishPlugins.fish-you-should-use.src;
          }
          {
            name = "forgit";
            src = pkgs.fishPlugins.forgit.src;
          }
          {
            name = "plugin-sudope";
            src = pkgs.fishPlugins.plugin-sudope.src;
          }
          {
            name = "pure";
            src = pkgs.fishPlugins.pure.src;
          }
          {
            name = "z";
            src = pkgs.fishPlugins.z.src;
          }
        ];
        shellAliases = {
          tl = "tmux list-sessions";
          ts = "tmux new-session -s";
          ta = "tmux attach -d";
          tas = "tmux attach -d -t";
          tkss = "tmux kill-session -t";
          tksv = "tmux kill-server";
          sesh = "tmux-sessionizer";
          ft = "flake-init";
          nhrb = "nh os switch -H ws";
          nhrbu = "nh os switch -H ws -u";
        };
      };
    })
  ];
}
