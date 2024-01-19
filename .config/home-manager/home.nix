{ config, pkgs, ... }:

{
  imports = 
    [
      ./tmux.nix
    ];
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "wasituf";
  home.homeDirectory = "/home/wasituf";

  home.stateVersion = "23.05"; 

  # Packages
  home.packages = with pkgs; [
    # ==================================
    # GUI Packages and Utilities
    # ==================================
    audacity                # Audio Editing
    blender                 # 3D Modelling
    brave                   # Brave Browser
    chromium                # Chromium Browser
    galculator              # Calculator Program
    gimp                    # Image Manupulation Tool
    godot_4                 # FOSS Game Engine
    inkscape                # Vector Graphics Creation
    nitrogen                # Desktop Wallpaper
    obsidian                # Markdown Editor / Knowledge Base
    pcmanfm                 # GUI File Mananger
    # polybar                 # Desktop Statusbar
    retroarch               # Emulator for retro games
    rofi                    # Applets & Menus
    spotify                 # Music Streaming


    # ==================================
    # CLI Packages and Utilities
    # ==================================
    bat                     # Print files | cat clone
    bc                      # Software Calculator
    bsp-layout              # BSPWM Layout Management
    cli-visualizer          # CLI Audio Visualizer
    curl                    # HTTP Client
    exercism                # Exercism cli tool
    ffmpeg_6-full           # Minimal ffmpeg Utilities
    gcc                     # C Compiler
    git                     # Version Management
    htop                    # Task Manager Equivalent
    httpie                  # HTTP Client
    jq                      # CLI JSON Processor
    libnotify               # Notification library
    maim                    # CLI Screenshot utility
    neofetch                # System Information
    p7zip                   # File Archiving/Extracting
    psmisc                  # Useful Utilities (like - killall)
    ripgrep                 # Live Grep
    sxhkd                   # Desktop Hotkeys / Behaviors
    tldr                    # Help pages
    tokei                   # Utility for counting code
    tree                    # Recursive Directory Listing
    unzip                   # Zip File Archiving/Extracting
    unrar                   # Rar File Archiving/Extracting
    wpm                     # CLI Typing Test
    xarchiver               # File Archiving/Extracting
    xcape                   # Key Remapping
    xclip                   # X11 Clipboard
    xdotool                 # Utility for Xorg


    # ==================================
    # Runtimes Packages & Toolkits
    # ==================================
    bun                             # JavaScript Runtime & Toolkit
    corepack                        # Utilities for yarn
    go                              # GoLang Toolkit

    # Node utilities
    nodePackages.nodejs             # JavaScript Runtime
    nodePackages.browser-sync       # HTML Live Server
    nodePackages.webtorrent-cli     # CLI Torrent Client
    eslint_d                        # ESlint something


    # ==================================
    # XORG Packages
    # ==================================
    xorg.xkbcomp            # Keyboard Layout Mapping
    xorg.xmodmap            # Keyboard Remapping Utility
  ];

  nixpkgs.config = {
    allowUnfree = true;
    permittedInsecurePackages = pkgs.lib.optional (pkgs.obsidian.version == "1.5.3") "electron-25.9.0";
  };

  # Disable spotify desktop entry (for adblock)
  xdg.desktopEntries.spotify.name = "Spotify";
  xdg.desktopEntries.spotify.exec = "spotify";
  xdg.desktopEntries.spotify.noDisplay = true;

  # Gtk theme
  gtk = {
    enable = true;
    font.name = "Jost Medium 10";
    theme = {
      name = "Catppuccin-Mocha-Standard-Lavender-Dark";
    };
    iconTheme = {
      package = pkgs.tau-hydrogen;
      name = "Hydrogen";
    };
  };

  dconf.settings = {
  };

  # Cursor theme
  home.pointerCursor = {
    package = pkgs.nordzy-cursor-theme;
    name = "Nordzy-cursors-white";
    size = 16;
    x11.enable = true;
    gtk.enable = true;
  };

  home.keyboard = null;

  # Bspwm
  xsession.windowManager.bspwm = {
    enable = true;

    monitors = {
      HDMI-0 = [
        "Dev"
        "Web"
        "III"
        "IV"
        "V"
        "VI"
        "VII"
        "VIII"
        "IX"
        "Music"
      ];
    };

    rules = {
      "Galculator".state = "floating";
      # "com.github.rafostar.Clapper".state = "floating";
      "Kitty" = {
          desktop = "^1";
          state = "fullscreen";
        };
      "Brave-browser".desktop = "^2";
      "Spotify".desktop = "^10";
      "obsidian" = {
        desktop = "^3";
      };
      # "Pcmanfm".state = "floating";
      "loupe".state = "floating";
      "Xarchiver".state = "floating";
    };

    settings = {
      border_width = 2;
      focused_border_color = "#b4befe";
      normal_border_color = "#18222A";
      window_gap = 11;
      right_padding = 1;
      left_padding = 1;
      top_padding = 1;
      bottom_padding = 1;
      split_ratio = 0.52;
      borderless_monocle = true;
      gapless_monocle = true;
    };

    extraConfigEarly = ''
      nitrogen --restore &
      xsetroot -cursor_name left_ptr &
      bsp-layout set tall Web -- --master-size 0.65 &
      bsp-layout set tall III -- --master-size 0.65 &
      bsp-layout set tall IV -- --master-size 0.65 &
      bash $HOME/.config/scripts/esc-mod &
      bash $HOME/.config/polybar/forest/launch.sh &
      '';
  };

  #===Environment===
  home.sessionVariables = {
    EDITOR = "nvim";
    BROWSER = "brave";
    TERMINAL = "kitty";
  };

  #===Services===
  services.picom = {
    enable = true;
    package = pkgs.picom-next;
    backend = "glx";
    shadow = false;
    shadowOpacity = 0.0;
    shadowOffsets = [
      0
      0
    ];
    fade = true;
    opacityRules = [
      "95:class_g = 'obsidian'"
    ];
    vSync = true;
    settings = {
      blur = {
        method = "dual_kawase";
        strength = 4;
      };
      blur-background-exclude = [
        "class_g = 'slop'"
      ];
      corner-radius = 4.0;
      rounded-corners-exclude = [
        "class_g = 'Polybar'"
      ];
    };
  };

  # Syncthing
  services.syncthing = {
    enable = true;
  };

  # Screen Locking
  services.screen-locker = {
    enable = true;
    inactiveInterval = 5;
    lockCmd = "dm-tool switch-to-greeter";
  };

  # Polybar
  services.polybar = {
    enable = true;
    package = pkgs.polybar.override {
      pulseSupport = true;
      mpdSupport = true;
    };
    script = "polybar main &";
  };

  services.xidlehook = {
    not-when-audio = true;
    not-when-fullscreen = true;
  };

  # Dunst
  services.dunst = {
    enable = true;
    iconTheme.package = pkgs.qogir-icon-theme;
    iconTheme.name = "Qogir";
    settings = {
      global = {
        monitor = 0;
        width = 340;
        height = 120;
        origin = "top-right";
        offset = "20x50";
        scale = 0;
        notification_limit = 20;
        progress_bar = true;
        progress_bar_height = 10;
        progress_bar_frame_width = 1;
        progress_bar_min_width = 300;
        progress_bar_max_width = 300;
        progress_bar_corner_radius = 5;
        icon_corner_radius = 0;
        indicate_hidden = "yes";
        transparency = 0;
        padding = 10;
        horizontal_padding = 10;
        text_icon_padding = 12;
        frame_width = 1;
        frame_color = "#dddddd";
        gap_size = 8;
        sort = "yes";
        font = "Comfortaa 9";
        line_height = 0;
        markup = "full";
        format = "<b>%a • </b><i>%s</i>\n%b";
        alignment = "left";
        vertical_alignment = "center";
        show_age_threshold = 60;
        ellipsize = "middle";
        ignore_newline = "no";
        stack_duplicates = "true";
        hide_duplicate_count = "false";
        show_indicators = "yes";
        icon_position = "left";
        min_icon_size = 32;
        max_icon_size = 96;
        sticky_history = "yes";
        history_length = 20;
        browser = "brave";
        title = "Dunst";
        class = "Dunst";
        corner_radius = 8;
        mouse_left_click = "do_action, close_current";
        mouse_middle_click = "close_all";
        mouse_right_click = "context";
      };

      urgency_low = {
        background = "#222222";
        foreground = "#888888";
        timeout = 5;
      };

      urgency_normal = {
        background = "#8C181818";
        foreground = "#ebebeb";
        timeout = 5;
      };

      urgency_critical = {
        background = "#dddddd";
        foreground = "#111111";
        frame_color = "#a79e89";
        timeout = 0;
      };
    };
  };

  #===Programs===
  programs.zsh = {
    enable = true;
    autocd = true;
    shellAliases = {
      gdvim = "nvim --listen /tmp/godot.pipe";
      pfetch = "echo '\n\n\n\n\n\n\n\n\n\n\n\n' && pfetch && echo '\n\n\n\n\n\n\n\n\n\n\n\n'";
      tmux = "sh $HOME/.config/scripts/tmux-padding";
      # tmuxinator = "sh $HOME/.config/scripts/tmuxinator-padding";
      dotfiles = "git --git-dir=$HOME/dotfiles.git/ --work-tree=$HOME";

      snix = "sudo nix-channel --update && sudo nix-collect-garbage -d && sudo nixos-rebuild switch && sudo cp /etc/nixos/configuration.nix $HOME/symlinks/etc/nixos && reboot";
      shome = "nix-channel --update && nix-collect-garbage -d && home-manager switch";
      tdot = "kitten @ set-spacing padding=0\ntmuxinator start dotfiles\nkitten @ set-spacing padding=default";
    };
    initExtra = ''
      export PATH=$HOME/.config/scripts:$PATH
      export FZF_CTRL_T_OPTS="--bind='ctrl-n:down' --bind='ctrl-e:up'"

      bindkey -s ^t "tmux-sessionizer\n"
      
      # Pfetch
      export PF_INFO="ascii title os shell editor de palette"
      export PF_COLOR=1
      export PF_COL1=4
      export PF_COL2=9
      export PF_COL3=1
      export PF_ALIGN=8
      export PF_ASCII="Catppuccin"

      # Fzf catppuccin theme
      export FZF_DEFAULT_OPTS=" \
      --color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \
      --color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
      --color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8 \
      --bind='ctrl-n:down,ctrl-e:up'"
    '';
    profileExtra = ''
      source ~/catppuccin-mocha-zsh-syntax-highlighting.zsh
    '';
    initExtraFirst = ''
      echo '\n\n /\_/\ \n( ^_^ )\n > ^ <'
    '';
  };

  # Neovim
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    # extraLuaConfig = builtins.readFile "$HOME/.config/neovim/init.lua";
    extraLuaConfig = ''
      require("wasituf")
    '';
  };

  # Fzf
  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };

  # Kitty
  programs.kitty = {
    enable = true;
    settings = {
      # background_opacity = "0.55";
      background_opacity = "0.9";
      foreground = "#CAD3F5";
      background = "#1E1E2E";
      selection_foreground = "#1E1E2E";
      selection_background = "#F4DBD6";
      cursor = "#F4DBD6";
      url_color = "#F4DBD6";
      active_tab_foreground = "#181926";
      active_tab_background = "#b4befe";
      inactive_tab_foreground = "#CAD3F5";
      inactive_tab_background = "#313244";
      tab_bar_background = "#1e1e2e";

      # black
      color0 = "#494D64";
      color8 = "#5B6078";

      # red
      color1 = "#ED8796";
      color9 = "#ED8796";

      # green
      color2 = "#A6DA95";
      color10 = "#A6DA95";

      # yellow
      color3 = "#EED49F";
      color11 = "#EED49F";

      # blue
      color4 = "#8AADF4";
      color12 = "#8AADF4";

      # magenta
      color5 = "#F5BDE6";
      color13 = "#F5BDE6";

      # cyan
      color6 = "#8BD5CA";
      color14 = "#8BD5CA";

      # white
      color7 = "#B8C0E0";
      color15 = "#A5ADCB";

      font_family = "JetBrainsMono NFM Regular";
      bold_font = " JetBrainsMono NFM Bold";
      italic_font = "JetBrainsMono NFM Italic";
      bold_italic_font = "JetBrainsMono NFM Bold Italic";

      font_size = "11";
      adjust_line_height = "100%";

      cursor_beam_thickness = "1.0";
      cursor_blink_interval = "0.6";
      cursor_shape = "beam";

      scrollback_lines = "1000";
      copy_on_select = "clipboard";
      mouse_hide_wait = "-1.0";	
      strip_trailing_spaces = "smart";
      url_style = "none";

      initial_window_width = "768";
      initial_window_height = "480";
      remember_window_size = "no";
      window_padding_width = "6 8";

      tab_bar_min_tabs = "2";
      tab_bar_edge = "bottom";
      tab_bar_style = "powerline";
      tab_powerline_style = "round";
      tab_title_template = " {title}{' :{}:'.format(num_windows) if num_windows > 1 else ''}";

      close_on_child_death = "yes";
      update_check_interval = "0";
      allow_remote_control = "yes";
      dynamic_background_opacity = "yes";
    };
    extraConfig = ''
      modify_font underline_position +2
      modify_font underline_thickness 150%
    '';
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
