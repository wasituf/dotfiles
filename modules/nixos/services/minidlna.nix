{
  config,
  lib,
  ...
}:
with lib;
let
  cfg = config.modules.services.minidlna;
in
{
  options.modules.services.minidlna = {
    enable = mkEnableOption "minidlna";
  };

  config = mkIf cfg.enable {
    services.minidlna = {
      enable = true;
      openFirewall = true;
      settings = {
        media_dir = [
          "V,/media/Netflix/Anime"
          "V,/media/Netflix/Movies"
          "V,/media/Netflix/Series"
        ];
        inotify = "yes";
        friendly_name = "nixos_ws";
      };
    };
  };
}
