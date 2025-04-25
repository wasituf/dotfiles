{ pkgs, inputs, ... }:
let
  pkgs-unstable = inputs.hyprland.inputs.nixpkgs.legacyPackages.${pkgs.stdenv.hostPlatform.system};
in
{
  imports = [
    ./nvidia.nix
    ./qt.nix
    ./xserver.nix
  ];

  hardware = {
    graphics = {
      enable = true;
      enable32Bit = true;
      package = pkgs-unstable.mesa;
      package32 = pkgs-unstable.pkgsi686Linux.mesa;
    };
  };
}
