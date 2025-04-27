{
  lib,
  pkgs,
  ...
}:
with lib;
{
  options.custom-pkgs.flake-init = {
    package = mkOption {
      type = types.package;
      default = pkgs.writeTextFile {
        name = "flake-init";
        destination = "/bin/flake-init";
        executable = true;
        text = ''
          #!/usr/bin/env bash

          if [[ $# -eq 1 ]]; then
          	selected=$1
          else
          	selected=$(nix flake show --json github:wasituf/ft | jq -r '.templates | to_entries[] | "\(.key): \(.value.description)"' | fzf)
          fi

          if [[ -z $selected ]]; then
          	exit 0
          fi

          template_name=$(basename "$selected" | cut -d':' -f1)
          nix flake init -t github:wasituf/ft#$template_name
          touch .envrc
          echo "use flake" > .envrc
        '';
      };
      description = "Script to initialize flakes from templates";
    };
  };
}
