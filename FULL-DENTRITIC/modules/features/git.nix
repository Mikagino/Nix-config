{
	inputs,
	...
}: {
	flake.nixosModules.desktop-env = {pkgs, ... }: {
    environment.systemPackages = with pkgs; [
			git
		];
  };

	flake.homeModules.git = {pkgs, ... }: {
    programs.git = {
      #enable = true;
      lfs.enable = true;
      settings = {
        user = {
          name = "Mikagino";
          email = "angeli.mika@gmail.com";
        };
        init = {
          defaultBranch = "main";
          safe.directory = "~/.nix-config/";
        };
      };
    };

    programs.lazygit = {
      enable = true;
    };
	};
}