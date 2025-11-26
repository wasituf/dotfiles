{
  lib,
  config,
  ...
}:
with lib;
let
  cfg = config.modules.scripts;
in
{
  imports = [
    ./album-art.nix
    ./flake-init.nix
    ./owm-waybar.nix
    ./spotify-lookup.nix
    ./theme-switch.nix
    ./tmux-sessionizer.nix
  ];

  options.modules.scripts = {
    enable = mkEnableOption "scripts";
  };

  config = mkIf cfg.enable {
    home.packages = [
      # scripts
      config.custom-pkgs.album-art.package
      config.custom-pkgs.flake-init.package
      config.custom-pkgs.owm-waybar.package
      config.custom-pkgs.spotify-lookup.package
      config.custom-pkgs.theme-switch.package
      config.custom-pkgs.tmux-sessionizer.package
    ];
  };
}
