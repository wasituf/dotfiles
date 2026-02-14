{
  lib,
  config,
  user,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.modules.gaming;
in
{
  imports = [
    ./terraria
    ./osu.nix
  ];

  options.modules.gaming = {
    enable = mkEnableOption "gaming";
  };

  config = mkIf cfg.enable {
    programs.steam = {
      enable = true;
      protontricks.enable = true;
      gamescopeSession.enable = true;
      extraPackages = with pkgs; [
        mangohud
      ];
    };

    programs.gamemode = {
      enable = true;
      settings = {
        custom = {
          start = "${pkgs.libnotify}/bin/notify-send 'GameMode started'";
          end = "${pkgs.libnotify}/bin/notify-send 'GameMode ended'";
        };
      };
    };

    environment.systemPackages = with pkgs; [
      protonup-ng
      (lutris.override {
        extraLibraries = pkgs: [
          gamemode
          mangohud
        ];
      })
    ];

    environment.sessionVariables = {
      STEAM_EXTRA_COMPAT_TOOLS_PATHS = "/home/${user}/.steam/root/compatibilitytools.d";
    };

    programs.nix-ld = {
      enable = true;
      libraries = with pkgs; [
        stdenv.cc.cc
        openssl
        curl
        glib
        font-misc-misc
        icu

        glew
        libGL
        libGLU
        libappindicator
        libvdpau
        libx11
        libxext
        libxfixes
        libxi
        libxinerama
        libxrandr
        libxrender
        libxscrnsaver
        libxxf86vm
        libsm
        libice
        libxtst

        libpulseaudio
        alsa-lib
        pipewire

        SDL2
        SDL2_image
        SDL2_mixer
        SDL2_ttf
        vulkan-loader
      ];
    };
  };
}
