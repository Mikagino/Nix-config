{
	inputs,
	...
}: {
	flake.nixosModules.NAME = { pkgs, ... }: {
    environment.systemPackages = with pkgs; [
      # Insert package/s
		];
  };

	flake.homeModules.NAME = {pkgs, ... }: {
		home.packages = [
      # Insert package/s
    ];
	};
}