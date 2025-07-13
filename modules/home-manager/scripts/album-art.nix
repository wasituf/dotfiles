{
  lib,
  pkgs,
  ...
}:
with lib;
{
  options.custom-pkgs.album-art = {
    package = mkOption {
      type = types.package;
      default = pkgs.writeTextFile {
        name = "album-art";
        destination = "/bin/album-art";
        executable = true;
        text = ''
          #!/usr/bin/env bash

          album_art=$(playerctl -p spotify metadata mpris:artUrl)
          if [[ -z $album_art ]]
          then
             # spotify is dead, we should die too.
             exit
          fi
          curl -s  "$album_art" --output "/tmp/cover.jpeg"
          echo "/tmp/cover.jpeg"
        '';
      };
      description = "Script to fetch album art from spotify using playerctl";
    };
  };
}
