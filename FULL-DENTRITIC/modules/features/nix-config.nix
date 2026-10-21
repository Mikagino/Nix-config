{
	inputs,
	...
}: {
  imports = with inputs; [
    flake-parts.flakeModules.modules
		home-manager.flakeModules.home-manager
  ];

	flake.nixosModules.nix-config = {pkgs, ... }: {
		nixpkgs.config = {
      allowUnfree = true;
      allowUnfreePredicate = (_: true);
    };

    nix = {
      package = pkgs.nix;
      settings.experimental-features = [
        "nix-command"
        "flakes"
      ];
      nixPath = [
        "nixos-config=~/.nix-config/configuration.nix"
        "nixpkgs=/nix/var/nix/profiles/per-user/root/channels/nixos"
        "/nix/var/nix/profiles/per-user/root/channels"
      ];
    };

    # nix helper which cleans up automatically every week
    programs.nh = {
      enable = true;
      clean.enable = true;
      clean.extraArgs = "--keep-since 7d --keep 3";
      flake = "/home/mika/.nix-config";
    };
	};
}