{
  lib,
  pkgs,
  ...
}:
with lib;
{
  options.custom-pkgs.theme-switch = {
    package = mkOption {
      type = types.package;
      default = pkgs.writeTextFile {
        name = "theme-switch";
        destination = "/bin/theme-switch";
        executable = true;
        text = ''
          #!/usr/bin/env fish

          for path in (home-manager generations | awk '{print $NF}')
              if test -d "$path/specialisation"
                  set -g hm_path $path
                  break
              end
          end

          set selection (ls "$hm_path/specialisation" | fzf | string replace -r '.*-> (.*)' '$1')
          eval "$selection/activate"
        '';
      };
      description = "Script to switch between specialisations";
    };
  };
}
