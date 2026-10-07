#
{
  description = "NixOS config with host discovery, based on: https://blog.ricardof.dev/modularizing-your-nixos-config/";

  inputs = {
    nixpkgs.url = "https://channels.nixos.org/nixpkgs-unstable/nixexprs.tar.zst";
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nixpkgs, home-manager, ... }:
    let
      # Helper for automatic host discovery
      mkHost = hostname: nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [
          ./hosts/${hostname}
          ./modules/system
          home-manager.nixosModules.home-manager
          {
            networking.hostName = hostname;
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users.fuhrmann = import ./modules/user;
              extraSpecialArgs = { inherit inputs; };
              sharedModules = [
                inputs.niri.homeModules.niri
                inputs.vicinae.homeManagerModules.default
                inputs.noctalia.homeModules.default
                inputs.nix-colors.homeManagerModules.default
              ];
            };
          }
        ];
      };
    in {
      nixosConfigurations = {
        fritz = mkHost "hauptquartier";
        # Adding new hosts is trivial:
        # laptop = mkHost "laptop";
        # server = mkHost "server";
      };
    };
}
