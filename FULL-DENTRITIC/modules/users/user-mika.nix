{
	inputs,
	...
}: {
	flake.nixosModules.user-mika = { pkgs, ... }: {
		# Define a user account. Don't forget to set a password with ‘passwd’.
		users.users."mika" = {
			isNormalUser = true;
			description = "Mika";
			extraGroups = [
				"networkmanager"
				"wheel"
			];
		};

	};

	# Setup home manager
	flake.homeModules.user-mika = { pkgs, ... }: {
		programs.home-manager.enable = true;

		home = {
			username = "mika";
  		homeDirectory = "/home/mika";
			home.stateVersion = "26.05";

			packages = with pkgs; [
				lazygit
			];
		};

		xdg = {
			enable = true;
			mime.enable = true;
		};
	};
}