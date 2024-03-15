{ pkgs, ... }:
{
  wayland.windowManager = {
    hyprland = {
      enable = true;
      systemd = {
          enable = true;
      };
      settings = {
      };
      plugins = [

      ];
      extraConfig = ''
        $terminal = kitty
        $fileManager = pcmanfm
        $menu = fuzzel

        # Swww random wp
        exec-once = swww init && sh $HOME/.config/scripts/swww-randomize.sh $HOME/Wallpapers/gifs
        
        env = XCURSOR_SIZE,24
        env = QT_QPA_PLATFORMTHEME,qt5ct
        env = NIXOS_OZONE_WL,1
        env = WLR_NO_HARDWARE_CURSORS,1

        input {
          kb_layout = us
          kb_variant = colemak_dh

          follow_mouse = 1
          sensitivity = -0.5
          accel_profile = flat
        }

        general {
          gaps_in = 5
          gaps_out = 10
          border_size = 2
          col.active_border = rgba(33ccffee) rgba(00ff99ee) 45deg
          col.inactive_border = rgba(595959aa)

          layout = master

          allow_tearing = false
        }

        decoration {
          rounding = 6

          blur {
            enabled = true
            size = 3
            passes = 1

            vibrancy = 0.1696
          }

          drop_shadow = true
          shadow_range = 4
          shadow_render_power = 3
        }

        animations {
          enabled = true

          # Some default animations, see https://wiki.hyprland.org/Configuring/Animations/ for more

          bezier = myBezier, 0.05, 0.9, 0.1, 1.05

          animation = windows, 1, 7, myBezier
          animation = windowsOut, 1, 7, default, popin 80%
          animation = border, 1, 10, default
          animation = borderangle, 1, 8, default
          animation = fade, 1, 7, default
          animation = workspaces, 1, 6, default
        }

        dwindle {
          # See https://wiki.hyprland.org/Configuring/Dwindle-Layout/ for more
          pseudotile = true # master switch for pseudotiling. Enabling is bound to mainMod + P in the keybinds section below
          preserve_split = true # you probably want this
        }

        master {
          # See https://wiki.hyprland.org/Configuring/Master-Layout/ for more
          new_is_master = false
          mfact = 0.6
          no_gaps_when_only = 1
        }

        gestures {
          # See https://wiki.hyprland.org/Configuring/Variables/ for more
          workspace_swipe = false
        }

        misc {
          # See https://wiki.hyprland.org/Configuring/Variables/ for more
          disable_hyprland_logo = true
          disable_splash_rendering = true
          animate_manual_resizes = true
          new_window_takes_over_fullscreen = 2
        }

        # Example per-device config
        # See https://wiki.hyprland.org/Configuring/Keywords/#per-device-input-configs for more
        # device {
        #   name = epic-mouse-v1
        #   sensitivity = -0.6
        # }

        # Example windowrule v1
        # windowrule = float, ^(kitty)$
        # Example windowrule v2
        # windowrulev2 = float,class:^(kitty)$,title:^(kitty)$
        # See https://wiki.hyprland.org/Configuring/Window-Rules/ for more
        windowrulev2 = suppressevent maximize, class:.* # You'll probably like this.
        windowrulev2 = float,class:^(pcmanfm)$


        # See https://wiki.hyprland.org/Configuring/Keywords/ for more
        $mainMod = ALT
        $secMod = SUPER

        # Example binds, see https://wiki.hyprland.org/Configuring/Binds/ for more
        bind = $mainMod, Return, exec, $terminal
        bind = $mainMod, Q, killactive,
        bind = $mainMod, X, exit,
        bind = $mainMod, F, exec, $fileManager
        bind = $secMod, S, togglefloating,
        bind = $secMod, F, fullscreen, 0
        bind = $mainMod, P, exec, $menu
        bind = $mainMod, R, pseudo, # dwindle
        bind = $mainMod, J, togglesplit, # dwindle
        
        # Move focus with mainMod + arrow keys
        bind = $secMod, M, movefocus, l
        bind = $secMod, I, movefocus, r
        bind = $secMod, E, movefocus, u
        bind = $secMod, N, movefocus, d
        
        # Switch workspaces with mainMod + [0-9]
        bind = $mainMod, 1, workspace, 1
        bind = $mainMod, 2, workspace, 2
        bind = $mainMod, 3, workspace, 3
        bind = $mainMod, 4, workspace, 4
        bind = $mainMod, 5, workspace, 5
        bind = $mainMod, 6, workspace, 6
        bind = $mainMod, 7, workspace, 7
        bind = $mainMod, 8, workspace, 8
        bind = $mainMod, 9, workspace, 9
        bind = $mainMod, 0, workspace, 10
        
        # Move active window to a workspace with mainMod + SHIFT + [0-9]
        bind = $mainMod SHIFT, 1, movetoworkspace, 1
        bind = $mainMod SHIFT, 2, movetoworkspace, 2
        bind = $mainMod SHIFT, 3, movetoworkspace, 3
        bind = $mainMod SHIFT, 4, movetoworkspace, 4
        bind = $mainMod SHIFT, 5, movetoworkspace, 5
        bind = $mainMod SHIFT, 6, movetoworkspace, 6
        bind = $mainMod SHIFT, 7, movetoworkspace, 7
        bind = $mainMod SHIFT, 8, movetoworkspace, 8
        bind = $mainMod SHIFT, 9, movetoworkspace, 9
        bind = $mainMod SHIFT, 0, movetoworkspace, 10
        
        # Example special workspace (scratchpad)
        # bind = $mainMod, S, togglespecialworkspace, magic
        # bind = $mainMod SHIFT, S, movetoworkspace, special:magic
        
        # Scroll through existing workspaces with mainMod + scroll
        bind = $mainMod, mouse_down, workspace, e+1
        bind = $mainMod, mouse_up, workspace, e-1
        
        # Move/resize windows with mainMod + LMB/RMB and dragging
        bindm = $mainMod, mouse:272, movewindow
        bindm = $mainMod, mouse:273, resizewindow
      '';
    };
  };

  # Waybar
  programs.waybar = {
    enable = true;
    systemd = {
      enable = true;
      target = "hyprland-session.target";
    };
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 30;
        
        modules-left = [ "hyprland/workspaces" ];
        modules-center = [ ];
        modules-right = [ ];

        "hyprland/workspaces" = {
          format = "{name}";
        };
      };
    };
    style = ''
      
    '';
  };

  # Wayland Programs
  programs.fuzzel = {
    enable = true;
    settings = {
      main = {
        terminal = "kitty -e";
        font = "JetBrainsMono NFM Medium:size=10";
        prompt = "'✨ '";
        lines = "6";
        width = "40";
        tabs = "4";
        horizontal-pad = "16";
        vertical-pad = "10";
        inner-pad = "10";
        line-height = "28";
      };

      colors = {
        background = "1e1e2eff";
        text = "cdd6f4ff";
        match = "fab387ff";
        selection = "9399b2ff";
        selection-text = "181825ff";
        selection-match = "313244ff";
        border = "b4befeff";
      };

      border = {
        width = "2";
        radius = "10";
      };

      key-bindings = {
        # Unbind keys
        cursor-end = "none";
        next = "none";

        # Bind keys
        prev-with-wrap = "Control+e";
        next-with-wrap = "Control+n";
      };
    };
  };
}

