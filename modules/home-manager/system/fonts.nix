{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.modules.system.fonts;
in
{
  options.modules.system.fonts = {
    enable = mkEnableOption "fonts";
  };

  config = mkIf cfg.enable {
    fonts.fontconfig = {
      enable = true;
      defaultFonts = {
        sansSerif = [ "Satoshi" ];
        serif = [ "Merriweather" ];
        monospace = [ "JetBrainsMono NF" ];
        emoji = [ "Noto Color Emoji" ];
      };
    };

    home.packages = with pkgs; [
      # Icon Fonts
      noto-fonts-color-emoji
      weather-icons

      # Sans Serif
      comfortaa
      dm-sans
      dosis
      inter
      jost
      lato
      libre-franklin
      merriweather-sans
      montserrat
      noto-fonts
      poppins
      raleway
      roboto
      rubik

      # Serif
      alegreya
      crimson-pro
      eb-garamond
      libre-baskerville
      libre-bodoni
      libre-caslon
      merriweather
      roboto-serif

      # Slab
      karla
      mona-sans
      roboto-slab
      work-sans
      zilla-slab

      # Grotesk
      barlow
      manrope

      # Monospace
      nerd-fonts.caskaydia-cove
      nerd-fonts.geist-mono
      nerd-fonts.iosevka
      nerd-fonts.jetbrains-mono
      nerd-fonts.roboto-mono
      nerd-fonts.zed-mono
    ];
  };
}
