{
  lib,
  pkgs,
  ...
}:
with lib;
{
  options.custom-pkgs.waybar-lyric-custom = {
    package = mkOption {
      type = types.package;
      default = pkgs.writeTextFile {
        name = "waybar-lyric-custom";
        destination = "/bin/waybar-lyric-custom";
        executable = true;
        text = ''
          #!/usr/bin/env bash

          waybar-lyric --quiet | jq -c '(.tooltip? // empty) |= sub("\n</span>$"; "</span>")'
        '';
      };
      description = "Script to display lyrics from waybar-lyric with better formatting";
    };
  };
}
