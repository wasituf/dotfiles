{ ... }:
{
  programs.waybar = {
    enable = true;
    systemd.enable = true;
    style = ./style.css;
    settings = {
      mainBar = {
        layer = "top";
        modules-left = [
          "hyprland/workspaces"
          "hyprland/language"
        ];
        modules-center = [ "hyprland/window" ];
        modules-right = [
          "clock"
          "tray"
        ];
        "sway/window" = {
          max-length = 50;
        };
        clock = {
          format-alt = "{:%a, %d. %b  %H:%M}";
        };
      };
    };
  };
}
