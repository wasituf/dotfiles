# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).


{ lib, config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Experimental features
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Bootloader.
  boot = {
    loader.systemd-boot.enable = lib.mkForce false;
    lanzaboote = {
      enable = true;
      pkiBundle = "/etc/secureboot";
    };
  };

  # Add a systemd service to mount the exFAT partition
  systemd.services.mount-exfat = {
    description = "Mount exFAT partition after boot";
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      Type = "oneshot";
      ExecStart = "/run/current-system/sw/bin/mount /dev/disk/by-uuid/EDFE-F1E4 /media";
    };
  };

  # boot.loader.efi.canTouchEfiVariables = true;
  boot.bootspec.enable = true;

  # Make time compatible for dualbooting Windows
  time.hardwareClockInLocalTime = true;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Asia/Dhaka";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "bn_BD";
    LC_IDENTIFICATION = "bn_BD";
    LC_MEASUREMENT = "en_GB.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "bn_BD";
    LC_NUMERIC = "bn_BD";
    LC_PAPER = "bn_BD";
    LC_TELEPHONE = "bn_BD";
    LC_TIME = "en_AU.UTF-8";
  };

  # Display the Desktop Environment
  services.xserver = {
    enable = true;

    displayManager.lightdm.greeters.mini = {
      enable = true;
      user = "wasituf";
      extraConfig = ''
      [greeter]
      show-password-label = false
      invalid-password-text =
      show-input-cursor = false
      password-alignment = left
      password-input-width = 20
      show-sys-info = false

      [greeter-hotkeys]
      mod-key = meta
      shutdown-key = s
      restart-key = r
      
      [greeter-theme]
      text-color = "#680A2C"
      error-color = "#FF0000"
      background-image = "/etc/nixos/lock-screen-wp.jpg"
      background-image-size = cover
      window-color = "#499DC9"
      border-color = "#680A2C"
      border-width = 2px
      layout-space = 8
      password-character = 🙈
      password-background-color = "#499DC9"
      password-border-width = 0px
      password-border-radius = 0
      '';
    };

    windowManager.bspwm.enable = true;
    displayManager.defaultSession = "none+bspwm";

    # Disable mouse acceleration
    libinput = {
      enable = true;

      mouse = {
        accelProfile = "flat";
        transformationMatrix = "0.5 0 0 0 0.5 0 0 0 1";
      };
    };
  };

  # Enable dconf
  programs.dconf.enable = true;
 
  # SessionCommands
  services.xserver.displayManager.sessionCommands = ''
  ${pkgs.bspwm}/bin/bspc wm -r
  source $HOME/.config/bspwm/bspwmrc
  '';

  # Video Drivers
  services.xserver.videoDrivers = [ "nvidia" ];

  # Sound Settings
  sound.enable = false;
  # hardware.pulseaudio.enable = false;
  # nixpkgs.config.pulseaudio = true;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  # Jellyfin server
  services.jellyfin.enable = true;

  systemd.services.mpd.environment = {
    XDG_RUNTIME_DIR = "/run/user/1000";
  };

  # Configure keymap in X11
  services.xserver = {
    layout = "us";
    xkbVariant = "colemak_dh";
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.wasituf = {
    isNormalUser = true;
    description = "Wasit Uzayer Faraizi";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
  };

  # Enviroment
  environment.pathsToLink = [
    # Need for GTK Themes "/share"
    "/share/zsh"
    "/share"
  ];

  # Enable zsh as default shell
  users.defaultUserShell = pkgs.zsh;
  programs.zsh = {
    enable = true;
    ohMyZsh.enable = true;
    ohMyZsh.theme = "refined";
    ohMyZsh.plugins = [ 
      "common-aliases" 
      "command-not-found" 
      "sudo" 
      "tmux"
      "tmuxinator"
      "z"
      ];
    syntaxHighlighting.enable = true;
    autosuggestions.enable = true;
  };
  environment.shells = with pkgs; [ zsh ];

  fonts = {
    enableDefaultPackages = true;
    packages = with pkgs; [
      papirus-icon-theme
      noto-fonts
      fantasque-sans-mono
      material-icons
      siji
      noto-fonts-emoji
      dejavu_fonts
      roboto

      weather-icons

      merriweather
      merriweather-sans
      open-sans
      montserrat
      lato
      raleway
      work-sans
      fira
      fira-code
      inconsolata
      libre-baskerville
      oxygenfonts
      source-code-pro
      eb-garamond
      crimson
      comfortaa
      ibm-plex
      jost
      dosis
      liberation_ttf
      (nerdfonts.override { fonts = [ "CascadiaCode" "JetBrainsMono" "Iosevka" ]; })
    ];

    fontconfig = {
      defaultFonts = {
        serif = [ "merriweather" ];
	sansSerif = [ "CascadiaCode" ];
	monospace = [ "Inconsolata" ];
      };
    };
  };

  # Packages
  environment.systemPackages = with pkgs; [
  ];

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Garbage collection / optimisation
  nix.settings.auto-optimise-store = true;
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };

  # Flatpak Support
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  xdg.portal.enable = true;
  services.flatpak.enable = true;

  # Enable qt and theme qt to gtk
  qt.enable = true;
  qt.platformTheme = "gtk2";
  qt.style = "gtk2";


  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?
  

}
