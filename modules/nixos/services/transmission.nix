{
  config,
  lib,
  pkgs,
  user,
  ...
}:
with lib;
let
  cfg = config.modules.services.transmission;
in
{
  options.modules.services.transmission = {
    enable = mkEnableOption "transmission";
  };

  config = mkIf cfg.enable {
    services.transmission = {
      enable = true;
      package = pkgs.transmission_4;
      home = "/media/Netflix";
      group = "users";
      user = user;
      webHome = pkgs.flood-for-transmission;
      settings = {
        incomplete-dir-enabled = false;
        download-dir = "/media/Netflix";
      };
    };
  };
}
