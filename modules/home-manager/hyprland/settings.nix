{ ... }:
{
  wayland.windowManager.hyprland.settings = {
    exec-once = [
      "fcitx5 -d -r"
      "fcitx5-remote -r"
      "systemctl --user restart windowizer.service"
    ];

    env = [
      # "XCURSOR_SIZE,32"
      "QT_QPA_PLATFORMTHEME,qt5ct"
      "NIXOS_OZONE_WL,1"
      "WLR_NO_HARDWARE_CURSORS,1"
    ];

    input = {
      kb_layout = "us";
      kb_variant = "colemak_dh";

      follow_mouse = 0;
      sensitivity = -0.25;
      accel_profile = "flat";
    };

    general = {
      gaps_in = 4;
      gaps_out = 8;
      border_size = 1;
      "col.active_border" = "0xff54546D";
      "col.inactive_border" = "0xff363646";
      layout = "master";
      allow_tearing = false;
    };

    decoration = {
      rounding = 10;
      shadow = {
        enabled = false;
      };
      blur = {
        enabled = true;
        size = 4;
        passes = 1;
        vibrancy = 0.1696;
      };
    };

    animations = {
      enabled = true;
      bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";
      animation = [
        "windows, 1, 7, myBezier"
        "windowsOut, 1, 7, default, popin 80%"
        "border, 1, 10, default"
        "borderangle, 1, 8, default"
        "fade, 1, 7, default"
        "workspaces, 1, 6, default"
      ];
    };

    dwindle = {
      pseudotile = true;
      preserve_split = true;
    };

    master = {
      mfact = 0.6;
    };

    misc = {
      disable_hyprland_logo = true;
      disable_splash_rendering = true;
      animate_manual_resizes = true;
      new_window_takes_over_fullscreen = 2;
    };
  };
}
