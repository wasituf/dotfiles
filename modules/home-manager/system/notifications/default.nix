{
  config,
  lib,
  ...
}:
with lib;
let
  cfg = config.modules.system.notifications;
in
{
  options.modules.system.notifications = {
    enable = mkEnableOption "notifications";
    theme = mkOption {
      type = types.enum [
        "kanagawa"
        "rose-pine"
      ];
      default = "kanagawa";
      description = "The theme applied to notifications.";
      example = "rose-pine";
    };
  };

  config = mkIf cfg.enable {
    services.wired = {
      enable = true;
      config = mkMerge [
        (mkIf (cfg.theme == "rose-pine") ./wired-rose-pine.ron)
        (mkIf (cfg.theme == "kanagawa") ./wired-kanagawa.ron)
      ];
    };
  };
}
