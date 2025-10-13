{ pkgs, ... }:
{
  home.packages = with pkgs; [
    playerctl
    hyprshot
    satty
    wl-clipboard
  ];
  wayland.windowManager.hyprland.settings = {
    "$mod" = "SUPER";
    "$alt" = "ALT";
    "$terminal" = "ghostty";
    "$fileManager" = "org.gnome.Nautilus";
    # "$menu" = "tofi-run | xargs hyprctl dispatch exec --";
    "$menu" = "nc -U /run/user/1000/walker/walker.sock";

    bindm = [
      # Mouse bindings
      "$mod, mouse:272, movewindow"
      "$mod, mouse:273, resizewindow"
      "$mod ALT, mouse:272, resizewindow"

    ];

    bind = [
      # fcitx
      ", code:172, exec, playerctl play-pause"
      ", code:171, exec, playerctl next"
      ", code:173, exec, playerctl previous"
      "SUPER_CTRL, space, exec, playerctl play-pause"
      "SUPER_CTRL, Right, exec, playerctl next"
      "SUPER_CTRL, Left, exec, playerctl previous"

      # Screenshot
      ", PRINT, exec, hyprshot --clipboard-only --raw -m region | satty --copy-command 'wl-copy' --filename - --fullscreen --output-filename ~/screenshots/satty-$(date '+%Y%m%d-%H:%M:%S').png"
      "$mod, PRINT, exec, hyprshot --clipboard-only --raw -m output -m active | satty --copy-command 'wl-copy' --filename - --fullscreen --output-filename ~/screenshots/satty-$(date '+%Y%m%d-%H:%M:%S').png"
      "SHIFT, PRINT, exec, hyprshot --clipboard-only --raw -m window | satty --copy-command 'wl-copy' --filename - --fullscreen --output-filename ~/screenshots/satty-$(date '+%Y%m%d-%H:%M:%S').png"

      # Scroll through existing workspaces with mainMod + scroll
      "$mod, mouse_down, workspace, e+1"
      "$mod, mouse_up, workspace, e-1"

      # Keyboard bindings
      "$mod, Return, exec, $terminal"
      "$alt, Return, exec, $terminal"
      "$alt, Q, killactive"
      "$mod, X, exit"
      "$alt, F, exec, $fileManage"
      "$mod, S, togglefloating"
      "$mod, F, fullscreen, "
      "$mod, SPACE, exec, $menu"
      "$alt, R, pseudo" # dwindle
      "$alt, J, togglesplit" # dwindle

      # Move focus with mainMod + arrow keys
      "$mod, M, movefocus, l"
      "$mod, I, movefocus, r"
      "$mod, E, movefocus, u"
      "$mod, N, movefocus, d"

      # Switch workspaces with mainMod + [0-9]
      "$alt, 1, workspace, 1"
      "$alt, 2, workspace, 2"
      "$alt, 3, workspace, 3"
      "$alt, 4, workspace, 4"
      "$alt, 5, workspace, 5"
      "$alt, 6, workspace, 6"
      "$alt, 7, workspace, 7"
      "$alt, 8, workspace, 8"
      "$alt, 9, workspace, 9"
      "$alt, 0, workspace, 10"

      # Move active window to a workspace with mainMod + SHIFT + [0-9]
      "$alt SHIFT, 1, movetoworkspace, 1"
      "$alt SHIFT, 2, movetoworkspace, 2"
      "$alt SHIFT, 3, movetoworkspace, 3"
      "$alt SHIFT, 4, movetoworkspace, 4"
      "$alt SHIFT, 5, movetoworkspace, 5"
      "$alt SHIFT, 6, movetoworkspace, 6"
      "$alt SHIFT, 7, movetoworkspace, 7"
      "$alt SHIFT, 8, movetoworkspace, 8"
      "$alt SHIFT, 9, movetoworkspace, 9"
      "$alt SHIFT, 0, movetoworkspace, 10"
    ];
  };
}
