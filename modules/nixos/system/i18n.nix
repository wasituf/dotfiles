{ lib, config, ... }:
with lib;
let
  cfg = config.modules.system.i18n;
in
{
  options.modules.system.i18n = {
    enable = mkEnableOption "i18n settings";
  };

  config = mkIf cfg.enable {
    i18n = {
      defaultLocale = "en_US.UTF-8";
      extraLocaleSettings = {
        LC_ADDRESS = "bn_BD";
        LC_IDENTIFICATION = "bn_BD";
        LC_MEASUREMENT = "en_GB.UTF-8";
        LC_MONETARY = "en_US.UTF-8";
        LC_NAME = "bn_BD";
        LC_NUMERIC = "bn_BD";
        LC_PAPER = "bn_BD";
        LC_TELEPHONE = "bn_BD";
        LC_TIME = "en_AU.UTF-8";
      };
    };
  };
}
