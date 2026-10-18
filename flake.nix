{
  description = "NixOS config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/release-26.05";

    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    blender-bin.url = "https://flakehub.com/f/edolstra/blender-bin/*";

    # optional stuff from the source config
    #niri.url = "github:sodiboo/niri-flake";
    #vicinae.url = "github:vicinaehq/vicinae";
    #noctalia.url = "github:noctalia-dev/noctalia-shell";
    #nix-colors.url = "github:misterio77/nix-colors";
  };

  outputs = { self,
              nixpkgs,
              home-manager,
              blender-bin,
              ...
              } @ inputs:
    let
      # Helper for automatic host discovery
      mkHost = hostname: nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };

        # allow uploading scripts to arduino by giving serial port permission
        #users.users.mika.extraGroups = [ "dialout" ];

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
              extraSpecialArgs = { inherit inputs home-manager; };
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
        hauptquartier = mkHost "hauptquartier";
        # Adding new hosts is trivial:
        # laptop = mkHost "laptop";
        # server = mkHost "server";
    };
  };
}
