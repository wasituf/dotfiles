{
  description = "My Home Manager Flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
  };

  outputs = {nixpkgs, home-manager, self, ...}@inputs:
    let
      overlays = [
        (final: prev: {
          python3 = prev.python3.override {
            packageOverrides = pfinal: pprev: {
              xlib = pprev.xlib.overridePythonAttrs (oldAttrs: {
                doCheck = false;
              });
            };
          };
        })
      ]; 
    in
    {
    # Standalone home-manager configuration entrypoint
    homeConfigurations = {
      "wasituf@nixos" = inputs.home-manager.lib.homeManagerConfiguration {
        pkgs = import nixpkgs {
          system = "x86_64-linux";
          overlays = overlays;
        };
        modules = [
          ./home.nix
        ];
      };
    };
  };
}
