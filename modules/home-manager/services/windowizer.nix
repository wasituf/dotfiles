{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.modules.services.windowizer;
in
{
  options.modules.services.windowizer = {
    enable = mkEnableOption "windowizer";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      jq
      socat
    ];
    systemd.user.services.windowizer = {
      Unit = {
        Description = "Manage window states in hyprland.";
      };
      Install = {
        WantedBy = [ "default.target" ];
      };
      Service = {
        ExecStart = "${pkgs.writeShellScript "windowizer" ''
          handle() {
            case $1 in
            openwindow*)
              title=$(echo "$1" | cut -d ',' -f 4)
              address=$(echo "$1" | cut -d '>' -f 3 | cut -d ',' -f 1)

              if [[ "$title" =~ ^Zen ]]; then
                sleep 0.5
                hyprctl clients -j |
                  jq --arg addr "0x$address" '.[] | select(.address == $addr) | .title' |
                  while IFS= read -r window_title; do
                    if [[ "$window_title" =~ .*Extension:.* ]]; then
                      return
                    else
                      hyprctl dispatch settiled address:"0x$address"
                    fi
                  done
              fi
              ;;
            esac
          }

          socat -U - UNIX-CONNECT:"$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock" | while read -r line; do handle "$line"; done
        ''}";
      };
    };
  };
}
