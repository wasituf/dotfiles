{ pkgs, user, ... }:
{
  home.packages = with pkgs; [
    playerctl
    wttrbar
    hyprshot
    satty
    wl-clipboard
    waybar-lyric
    jq
    bc
  ];
  home.file.".config/waybar/nix-logo.png".source = ./nix-logo.png;
  home.file.".config/waybar/icon-conv.json".source = ./icon-conv.json;
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
          "group/tools"
          "hyprland/workspaces"
          "group/system-info"
        ];
        modules-center = [ "custom/lyrics" ];
        modules-right = [
          "privacy"
          "tray"
          "group/stats"
        ];
        "group/tools" = {
          orientation = "horizontal";
          modules = [
            "image#os-logo"
            "group/screenshot"
          ];
          drawer = {
            transition-duration = 200;
            children-class = "tool-item";
            click-to-reveal = true;
          };
        };
        "image#os-logo" = {
          path = "/home/${user}/.config/waybar/nix-logo.png";
          size = 16;
          tooltip = false;
        };
        "group/screenshot" = {
          orientation = "horizontal";
          modules = [
            "custom/screenshot-output"
            "custom/screenshot-window"
            "custom/screenshot-region"
          ];
          drawer = {
            transition-duration = 200;
          };
        };
        "custom/screenshot-output" = {
          format = "󰹑 ";
          on-click = ''hyprshot --clipboard-only --raw -m output -m active | satty --copy-command 'wl-copy' --filename - --fullscreen --output-filename ~/screenshots/satty-$(date '+%Y%m%d-%H:%M:%S').png'';
        };
        "custom/screenshot-window" = {
          format = " ";
          on-click = ''hyprshot --clipboard-only --raw -m window | satty --copy-command 'wl-copy' --filename - --fullscreen --output-filename ~/screenshots/satty-$(date '+%Y%m%d-%H:%M:%S').png'';
        };
        "custom/screenshot-region" = {
          format = " ";
          on-click = ''hyprshot --clipboard-only --raw -m region | satty --copy-command 'wl-copy' --filename - --fullscreen --output-filename ~/screenshots/satty-$(date '+%Y%m%d-%H:%M:%S').png'';
        };
        "group/system-info" = {
          orientation = "horizontal";
          modules = [
            "cpu"
            "memory"
            # "gamemode"
          ];
        };
        cpu = {
          interval = 1;
          format = "  {usage}%";
        };
        memory = {
          interval = 1;
          format = "  {used:0.1f}G";
        };
        gamemode = {
          format = "{glyph}";
          format-alt = "{glyph}";
          use-icon = false;
          hide-not-running = false;
          glyph = "󰓅 ";
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
            "custom/owm"
            "clock"
          ];
        };
        "custom/lyrics" = {
          return-type = "json";
          format = "{icon} {0}";
          hide-empty-text = true;
          format-icons = {
            playing = " ";
            paused = "";
            lyric = "󰦨 ";
            music = "󰝚 ";
            no_lyric = " ";
            getting = " ";
          };
          exec-if = "which waybar-lyric";
          exec = "waybar-lyric --quiet";
          on-click = "waybar-lyric play-pause";
        };
        "custom/weather" = {
          format = "{}°";
          tooltip = true;
          interval = 1800;
          exec = "wttrbar --ampm --location Dhaka";
          return-type = "json";
        };
        "custom/owm" = {
          return-type = "json";
          format = "{}°";
          exec = "owm-waybar ~/.config/waybar/icon-conv.json";
          interval = 1800;
          tooltip = true;
        };
        clock = {
          format = "{:%a %d, %I:%M}";
          format-alt = "{:%a, %d %b %Y - %I:%M %p}";
          tooltip = false;
        };
        tray = {
          icon-size = 16;
          spacing = 8;
        };
      };
    };
  };
}
