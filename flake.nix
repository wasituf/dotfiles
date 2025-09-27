{
  description = "Wasit's NixOS Configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland.url = "github:hyprwm/Hyprland";

    agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    banana-cursor-catppuccin = {
      url = "github:wasituf/banana-cursor-catppuccin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };
    minimal-tmux = {
      url = "github:niksingh710/minimal-tmux-status";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    wired.url = "github:Toqozz/wired-notify";
    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      ...
    }@inputs:
    let
      user = "wasituf";
      system-ws = "x86_64-linux";
      tmuxPluginsOverlay = import ./overlays/tmux-plugins.nix;
      binaryChaches = [ "https://aseipp-nix-cache.global.ssl.fastly.net" ];
    in
    {
      nixosConfigurations = {
        # 'ws' -> workstation
        ws = nixpkgs.lib.nixosSystem {
          system = system-ws;
          specialArgs = {
            inherit inputs;
            inherit user;
          };
          modules = [
            ./hosts/ws
            inputs.agenix.nixosModules.default
            {
              nixpkgs.overlays = [
                tmuxPluginsOverlay
                inputs.wired.overlays.default
              ];
              nix.settings.substituters = binaryChaches;
            }

            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;

              home-manager.users.wasituf = import ./users/wasituf/home.nix;

              home-manager.sharedModules = [
                inputs.wired.homeManagerModules.default
                inputs.agenix.homeManagerModules.default
              ];

              home-manager.extraSpecialArgs = {
                inherit inputs;
                inherit user;
              };
            }
          ];
        };
      };
    };
}
