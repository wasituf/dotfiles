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
    calibre
    gimp-with-plugins
    inkscape-with-extensions
    inputs.zen-browser.packages.${pkgs.system}.default
    loupe
    telegram-desktop
    vlc

    # file managers
    nautilus

    # misc
    duf
    fd
    jq
    mpvpaper
    nitch
    p7zip
    rar
    waytrogen
    zip

    # tooling
    libgcc
    gnumake
  ];

  # Modules
  modules = {
    # Hyprland
    hyprland.enable = true;
    # scripts
    scripts.enable = true;

    # services
    services = {
      swww.enable = true;
    };

    # desktop
    desktop = {
      emacs = {
        enable = true;
        enableDaemon = true;
      };
      spicetify.enable = true;
      tofi.enable = true;
      zathura.enable = true;
    };

    # terminal
    terminal = {
      emulators = {
        ghostty.enable = true;
      };
      programs = {
        bat.enable = true;
        btop.enable = true;
        eza.enable = true;
        fzf.enable = true;
        tmux = {
          enable = true;
          theme = "kanagawa";
        };
      };
      nixvim.enable = true;
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
    NH_FLAKE = "$HOME/dotfiles";
  };

  programs.home-manager.enable = true;
}
