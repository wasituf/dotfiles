{
  config,
  lib,
  inputs,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.modules.desktop.spicetify;
in
{
  imports = [ inputs.spicetify-nix.homeManagerModules.spicetify ];

  options.modules.desktop.spicetify = {
    enable = mkEnableOption "spicetify";
  };

  config = mkIf cfg.enable {
    programs.spicetify =
      let
        spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.system};
      in
      {
        enable = true;
        wayland = true;
        theme = spicePkgs.themes.text;
        colorScheme = "RosePine";
        enabledCustomApps = with spicePkgs.apps; [
          lyricsPlus
          marketplace
          historyInSidebar
          {
            name = "spicetify-playlist-maker";
            src = pkgs.fetchzip {
              url = "https://github.com/Pithaya/spicetify-apps-dist/archive/refs/heads/dist/playlist-maker.zip";
              hash = "sha256-EKG0UHoocvDzVaTMkmSI1ZJ295VwFAP8fLp6AHaC0NY=";
            };
          }
        ];
        enabledExtensions = with spicePkgs.extensions; [
          adblock
          betterGenres
          copyToClipboard
          history
          keyboardShortcut
          loopyLoop
          playNext
          queueTime
          seekSong
          shuffle
          sleepTimer
          songStats
          trashbin
          volumePercentage
          wikify
        ];
        enabledSnippets = [
          # Modern Scrollbar
          ".os-scrollbar-handle { width:0.25rem!important;border-radius:10rem !important; transition: width 300ms ease-in-out; } .os-scrollbar-handle:focus,.os-scrollbar-handle:focus-within,.os-scrollbar-handle:hover { width:0.35rem!important }"
        ];
      };
  };
}
