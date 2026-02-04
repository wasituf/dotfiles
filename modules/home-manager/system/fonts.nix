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
        sansSerif = [
          "LINE Seed Sans"
          "LINE Seed JP_TTF"
          "M+1 Nerd Font"
        ];
        serif = [
          "Merriweather"
          "IPAexMincho"
          "Noto Serif CJK JP"
        ];
        monospace = [
          "JetBrainsMono NF"
          "LINE Seed JP_TTF"
          "M+1Code Nerd Font"
        ];
        emoji = [ "Noto Color Emoji" ];
      };
    };

    home.packages = with pkgs; [
      # Japanese
      nerd-fonts."m+"
      noto-fonts-cjk-sans
      noto-fonts-cjk-serif

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
      # manrope

      # Monospace
      nerd-fonts.caskaydia-cove
      nerd-fonts.geist-mono
      nerd-fonts.iosevka
      nerd-fonts.jetbrains-mono
      nerd-fonts.monaspace
      nerd-fonts.roboto-mono
      nerd-fonts.zed-mono
    ];
  };
}
