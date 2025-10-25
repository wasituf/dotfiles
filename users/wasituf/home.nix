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
    anki-bin
    brave
    bruno
    calibre
    gimp3-with-plugins
    hakuneko
    inkscape-with-extensions
    inputs.zen-browser.packages.${pkgs.system}.default
    loupe
    telegram-desktop
    vlc
    yacreader

    # file managers
    nautilus

    # misc
    duf
    fd
    jq
    nitch
    p7zip
    rar
    waytrogen
    zip

    # tooling
    gcc
    libgcc
    gnumake
  ];

  # Modules
  modules = {
    # Hyprland
    hyprland = {
      enable = true;
      theme = "rose-pine";
    };
    # River
    river.enable = true;
    # scripts
    scripts.enable = true;

    # services
    services = {
      swww.enable = true;
      syncthing.enable = true;
      windowizer.enable = true;
    };

    # desktop
    desktop = {
      mangohud.enable = true;
      mpv.enable = true;
      spicetify.enable = true;
      tofi.enable = true;
      vesktop.enable = true;
      walker.enable = false;
      zathura.enable = true;
    };

    # terminal
    terminal = {
      emulators = {
        ghostty = {
          enable = true;
          theme = "Rose Pine";
        };
      };
      programs = {
        bat.enable = true;
        btop.enable = true;
        eza.enable = true;
        fzf.enable = true;
        git.enable = true;
        tealdeer.enable = true;
        tmux = {
          enable = true;
          theme = "rose-pine";
        };
      };
      nixvim = {
        enable = true;
        colorscheme = "rose-pine";
      };
    };

    # system
    system = {
      direnv.enable = true;
      fonts.enable = true;
      gtk.enable = true;
      nh.enable = true;
      notifications = {
        enable = true;
        theme = "rose-pine";
      };
      pointer.enable = true;
      shell = {
        enable = true;
        shell = "fish";
        theme = "rose-pine";
      };
      xdg = {
        defaultApplications.enable = true;
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
