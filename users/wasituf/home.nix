{
  pkgs,
  inputs,
  ...
}:
{
  imports = [
    ../../modules/home-manager
  ];

  home.username = "wasituf";
  home.homeDirectory = "/home/wasituf";

  home.stateVersion = "24.11";

  home.packages = with pkgs; [
    # desktop
    gimp-with-plugins
    inkscape-with-extensions
    inputs.zen-browser.packages.${pkgs.system}.default
    telegram-desktop
    loupe
    vlc

    # file managers
    nautilus
    xfce.thunar
    xfce.thunar-archive-plugin
    xfce.thunar-volman
    xfce.thunar-vcs-plugin

    # misc
    gum
    waytrogen
    mpvpaper
    zip
    rar
    p7zip

    # tooling
    libgcc
    gnumake
  ];

  # Modules
  modules = {
    # Hyprland
    hyprland.enable = true;

    # services
    services = {
      hyprpaper.enable = true;
    };

    # scripts
    scripts.enable = true;

    # desktop
    desktop = {
      spicetify.enable = true;
      tofi.enable = true;
    };
    emacs = {
      enable = true;
      enableDaemon = true;
    };
    fuzzel.enable = false;
    zathura.enable = true;

    # terminal
    eza.enable = true;
    ghostty.enable = true;
    gitui.enable = true;
    nixvim.enable = true;
    tmux = {
      enable = true;
      theme = "kanagawa";
    };

    # system
    system = {
      direnv.enable = true;
      fonts.enable = true;
      gtk.enable = true;
      nh.enable = true;
      pointer.enable = true;
      shell = {
        enable = true;
        shell = "fish";
      };
    };
  };

  home.sessionVariables = {
    TERMINAL = "ghostty";
    BROWSER = "zen-browser";
    FLAKE = "$HOME/dotfiles";
  };

  programs.home-manager.enable = true;
}
