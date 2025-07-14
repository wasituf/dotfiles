{ pkgs, ... }:
{
  home.packages = with pkgs; [
    playerctl
    wttrbar
  ];
  programs.waybar = {
    enable = true;
    systemd.enable = true;
    style = ./style.css;
    settings = {
      mainBar = {
        layer = "top";
        margin = "10px 10px 0 10px";
        spacing = 6;
        modules-left = [
          "hyprland/workspaces"
          "group/system-info"
          "privacy"
        ];
        modules-center = [ "mpris" ];
        modules-right = [
          "group/stats"
          "tray"
        ];
        "group/system-info" = {
          orientation = "horizontal";
          modules = [
            "cpu"
            "memory"
          ];
        };
        cpu = {
          interval = 2;
          format = "  {usage}%";
        };
        memory = {
          inverval = 2;
          format = "  {used:0.1f}G";
        };
        privacy = {
          icon-spacing = 6;
          icon-size = 16;
          modules = [
            {
              type = "screenshare";
            }
            {
              type = "audio-in";
            }
          ];
        };
        mpris = {
          format = "{player_icon} {artist} - {title}";
          interval = 1;
          player-icons = {
            spotify = " ";
          };
          title-len = 50;
          artist-len = 30;
        };
        "group/stats" = {
          orientation = "horizontal";
          modules = [
            "custom/weather"
            "clock"
          ];
        };
        "custom/weather" = {
          format = "{}°";
          tooltip = true;
          interval = 1800;
          exec = "wttrbar --ampm --location Dhaka";
          return-type = "json";
        };
        clock = {
          format = "{:%a %d, %I:%M}";
          format-alt = "{:%a, %d %b %Y, %I:%M %p}";
        };
        tray = {
          icon-size = 16;
          spacing = 8;
        };
      };
    };
  };
}
