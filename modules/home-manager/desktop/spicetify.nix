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
        spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.system};
      in
      {
        enable = true;
        theme = spicePkgs.themes.bloom;
        colorScheme = "violet";
        enabledCustomApps = with spicePkgs.apps; [
          lyricsPlus
          marketplace
        ];
        enabledExtensions = with spicePkgs.extensions; [
          adblock
          copyLyrics
          loopyLoop
          shuffle
          seekSong
          showQueueDuration
          betterGenres
          beautifulLyrics
          volumePercentage
        ];
        enabledSnippets = [
          # Modern Scrollbar
          ".os-scrollbar-handle { width:0.25rem!important;border-radius:10rem !important; transition: width 300ms ease-in-out; } .os-scrollbar-handle:focus,.os-scrollbar-handle:focus-within,.os-scrollbar-handle:hover { width:0.35rem!important }"
          # Spinning CD Cover Art
          "@keyframes rotating {from {transform: rotate(0deg);}to {transform: rotate(360deg);}}.cover-art {animation: rotating 360s linear infinite;clip-path: circle(50% at 50% 50%);position: relative;}.cover-art::after {content: '';position: absolute;top: 50%;left: 50%;transform: translate(-50%, -50%);width: 22%;height: 22%;background: radial-gradient( circle at center, rgba(24, 22, 35, 0.9) 0%, rgba(24, 22, 35, 0.9) 38%, rgba(255, 255, 255, 0.1) 38%, rgba(255, 255, 255, 0.1) 40%, rgba(24, 22, 35, 0.9) 40%, rgba(24, 22, 35, 0.9) 100% ), repeating-radial-gradient( circle at center, rgba(255, 255, 255, 0.1) 0, rgba(255, 255, 255, 0.1) 1px, transparent 1px, transparent 4px );border-radius: 50%;pointer-events: none;box-shadow: 0 0 10px rgba(0, 0, 0, 0.3) inset, 0 0 20px rgba(255, 255, 255, 0.1);}.cover-art::before {content: '';position: absolute;top: 50%;left: 50%;transform: translate(-50%, -50%);width: 6%;height: 6%;background: rgba(24, 22, 35, 1);border-radius: 50%;box-shadow: 0 0 5px rgba(255, 255, 255, 0.2);z-index: 1;} .main-nowPlayingBar-left button {background: transparent;}"

        ];
      };
  };
}
