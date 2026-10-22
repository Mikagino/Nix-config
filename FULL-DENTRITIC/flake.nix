{
  description = "Mikagino's Dentritic NixOS";

  inputs = {
    # NixOS packages
		nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";
		nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    # Necessary for Dendritic
    flake-parts.url = "github:hercules-ci/flake-parts";
    import-tree.url = "github:vic/import-tree";

    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # blender binary, including cuda
    blender-cuda.url = "github:edolstra/nix-warez?dir=blender";
  };

  outputs = inputs:
    inputs.flake-parts.lib.mkFlake { inherit inputs ; }
      (inputs.import-tree ./modules);
}
