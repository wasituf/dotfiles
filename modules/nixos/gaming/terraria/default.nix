{
  config,
  lib,
  user,
  ...
}:
with lib;
let
  cfg = config.modules.gaming.terraria;
in
{
  options.modules.gaming.terraria = {
    enable = mkEnableOption "terraria server";
    port = mkOption {
      type = types.int;
      default = 7777;
    };
  };

  config = mkIf cfg.enable {
    services.terraria = {
      enable = true;
      # worldPath = /home/wasituf/.local/share/Terraria/Worlds/Jerrysalem.wld;
      # dataDir = "/home/${user}/games/Terraria/server";
      password = "somepass";
      port = cfg.port;
      openFirewall = true;
      autoCreatedWorldSize = "medium";
    };

    networking.firewall.allowedTCPPorts = [ cfg.port ];
  };
}
