{
  description = "NixOS config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # optional stuff from the source config
    #niri.url = "github:sodiboo/niri-flake";
    #vicinae.url = "github:vicinaehq/vicinae";
    #noctalia.url = "github:noctalia-dev/noctalia-shell";
    #nix-colors.url = "github:misterio77/nix-colors";
  };

  outputs = { self, nixpkgs, home-manager, ... } @ inputs:
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
              users.mika = import ./modules/user;
              extraSpecialArgs = { inherit inputs; };
              #sharedModules = [
                #inputs.niri.homeModules.niri
                #inputs.vicinae.homeManagerModules.default
                #inputs.noctalia.homeModules.default
                #inputs.nix-colors.homeManagerModules.default
              #];
            };
          }
        ];
      };
    in {
      nixosConfigurations = {
        hauptquartier = mkHost "Hauptquartier";
        # Adding new hosts is trivial:
        # laptop = mkHost "laptop";
        # server = mkHost "server";
    };
  };
}
