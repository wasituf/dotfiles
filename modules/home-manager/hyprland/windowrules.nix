{ ... }:
{
  wayland.windowManager.hyprland.settings = {
    windowrulev2 = [
      "suppressevent maximize, class:.*"
      "float,class:^(org.gnome.Nautilus)$"
      "float,class:^(org.gnome.Loupe)$"
      "float,initialTitle:Zen Browser"
      "float,class:.*zen-beta.*,title:"
      "float,class:.*xdg-desktop-portal.*"
      "pseudo,class:^(fcitx)$"
    ];
  };
}
