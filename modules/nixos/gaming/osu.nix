{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
{
  options.modules.gaming.osu = {
    enable = mkEnableOption "osu";
  };

  config = mkIf config.modules.gaming.osu.enable {
    environment.systemPackages = with pkgs; [
      osu-lazer-bin
    ];
  };
}
