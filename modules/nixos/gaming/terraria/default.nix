{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  dataDir = "/var/lib/terraria";
  worldDir = "${dataDir}/worlds";

  # Simple config file serializer. Not very robust.
  mkConfig =
    options:
    builtins.toFile "terraria.cfg" (
      lib.concatStrings (lib.mapAttrsToList (name: value: "${name}=${toString value}\n") options)
    );

  # Config Generator
  mkWorld =
    name:
    {
      worldSize ? "medium",
      pass ? "",
      difficulty ? "normal",
    }:
    {
      config = mkConfig {
        world = "${worldDir}/${name}.wld";
        password = pass;
        difficulty =
          {
            normal = 0;
            expert = 1;
            master = 2;
            journey = 3;
          }
          .${difficulty};
        seed = "wasituf-${name}";
        autocreate =
          {
            small = 1;
            medium = 2;
            large = 3;
          }
          .${worldSize};
        upnp = 0;
      };
    };

  # High-level Config
  worlds = lib.mapAttrs mkWorld {
    jerrysalem = {
      worldSize = "medium";
      pass = "madeinbd";
    };
    lebupani = {
      worldSize = "large";
      pass = "qwerty";
      difficulty = "master";
    };
    # alupuri = {
    #   worldSize = "large";
    #   pass = "dalpuri";
    #   difficulty = "normal";
    # };
  };

  world = worlds.alupuri;

  cfg = config.modules.gaming.terraria;
in
{
  options.modules.gaming.terraria.enable = mkEnableOption "terraria server";

  config = mkIf cfg.enable {
    users.users.terraria = {
      group = "terraria";
      home = dataDir;
      uid = config.ids.uids.terraria; # NixOS has a Terraria user, so use those IDs.
    };

    users.groups.terraria = {
      gid = config.ids.gids.terraria;
    };

    systemd.sockets.terraria = {
      socketConfig = {
        ListenFIFO = [ "/run/terraria.sock" ];
        SocketUser = "terraria";
        SocketMode = "0660";
        RemoveOnStop = true;
      };
    };

    systemd.services.terraria = {
      wantedBy = mkForce [ ];
      after = [ "network.target" ];
      bindsTo = [ "terraria.socket" ];

      preStop = ''
        			printf '\nexit\n' >/run/terraria.sock
        		'';

      serviceConfig = {
        User = "terraria";
        ExecStart = lib.escapeShellArgs [
          "${pkgs.terraria-server}/bin/TerrariaServer"
          "-config"
          # world.config
          "/var/lib/terraria/config/alupuri.txt"
        ];

        StateDirectory = "terraria";
        StateDirectoryMode = "0750";

        StandardInput = "socket";
        StandardOutput = "journal";
        StandardError = "journal";

        KillSignal = "SIGCONT"; # Wait for exit after `ExecStop` (https://github.com/systemd/systemd/issues/13284)
        TimeoutStopSec = "1h";
      };
    };

    networking.firewall = {
      allowedTCPPorts = [ 7777 ];
      allowedUDPPorts = [ 7777 ];
    };
  };
}
