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
    ./flake-init.nix
    ./theme-switch.nix
    ./tmux-sessionizer.nix
  ];

  options.modules.scripts = {
    enable = mkEnableOption "scripts";
  };

  config = mkIf cfg.enable {
    home.packages = [
      # scripts
      config.custom-pkgs.flake-init.package
      config.custom-pkgs.theme-switch.package
      config.custom-pkgs.tmux-sessionizer.package
    ];
  };
}
