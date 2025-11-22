{ ... }:
{
  wayland.windowManager.hyprland.settings = {
    windowrule = [
      "match:class .*, suppress_event maximize"
      "match:class ^(org.gnome.Nautilus)$, float yes"
      "match:class ^(org.gnome.Loupe)$, float yes"
      "match:initial_title Zen Browser, float yes"
      "match:class .*zen-beta.*, float yes"
      "match:class .*xdg-desktop-portal.*, float yes"
      "match:class ^(fcitx)$, pseudo yes"
    ];
  };
}
