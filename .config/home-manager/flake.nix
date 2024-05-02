{
  description = "My Home Manager Flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
  };

  outputs = {nixpkgs, home-manager, self, ...}@inputs:
    # let
    #   overlays = [
    #     inputs.neovim-nightly-overlay.overlay
    #   ]; 
    # in
    {
    # Standalone home-manager configuration entrypoint
    homeConfigurations = {
      "wasituf@nixos" = inputs.home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
        modules = [
          ./home.nix
          # {
          #   nixpkgs.overlays = overlays;
          # }
        ];
      };
    };
  };
}
