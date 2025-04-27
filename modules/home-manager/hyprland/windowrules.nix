{ ... }:
{
  wayland.windowManager.hyprland.settings = {
    windowrulev2 = [
      "suppressevent maximize, class:.*"
      "float,class:^(org.gnome.Nautilus)$"
      "float,class:^(org.gnome.Loupe)$"
      "pseudo,class:^(fcitx)$"
    ];
  };
}
