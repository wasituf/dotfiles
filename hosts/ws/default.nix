{
  pkgs,
  ...
}:
{
  imports = [
    ./hc.nix
    ../../modules/nixos
  ];

  modules = {
    system = {
      i18n.enable = true;
      keyboard.enable = true;
      shell = {
        enable = true;
        shell = "fish";
      };
      virtualisation.enable = true;
    };
    services = {
      common.enable = true;
      keyd.enable = true;
      minidlna.enable = true;
      openrgb.enable = true;
      tailscale.enable = false;
      transmission.enable = true;
    };
    development = {
      android.enable = true;
    };
    gaming = {
      enable = true;
      terraria.enable = false;
      osu.enable = true;
    };
    graphics = {
      nvidia.enable = true;
      qt.enable = true;
      xserver.enable = true;
    };
    displayManager = {
      enable = true;
      defaultSession = "hyprland";
      hyprland.enable = true;
      river.enable = true;
    };
  };

  # Nix settings
  nix.settings = {
    auto-optimise-store = true;
    experimental-features = [
      "nix-command"
      "flakes"
    ];
  };

  # Garbage collection
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Boot
  boot = {
    bootspec.enable = true;
    loader.systemd-boot.enable = true;
    initrd.kernelModules = [ "nvidia" ];
    kernelPackages = pkgs.linuxPackages_latest;
  };

  # Mount HDD
  systemd.services.mount-exfat = {
    description = "Mount exFAT partition after boot";
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      Type = "oneshot";
      ExecStart = "/run/current-system/sw/bin/mount -o uid=1000,gid=100 /dev/disk/by-uuid/EDFE-F1E4 /media";
      User = "root";
    };
  };

  # Networking
  networking = {
    hostName = "ws";
    networkmanager.enable = true;
  };

  # Time
  time.timeZone = "Asia/Dhaka";

  # Use xserver layout in console
  console.useXkbConfig = true;

  # Enable dconf
  programs.dconf.enable = true;

  # Security
  security = {
    polkit.enable = true;
    rtkit.enable = true;
  };

  users.users.wasituf = {
    isNormalUser = true;
    extraGroups = [
      "docker"
      "networkmanager"
      "wheel"
      "adbusers" # udev rules for android with adb
      "kvm" # might improve android emulator performance
    ];
  };

  system.stateVersion = "24.11"; # DO NOT CHANGE
}
