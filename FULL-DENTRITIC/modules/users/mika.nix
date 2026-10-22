{
	inputs,
	self,
	...
}: {
	flake.nixosModules.mika = { pkgs, ... }: {
		users.users.mika = {
			isNormalUser = true;
			description = "Mika";
			extraGroups = [
				"networkmanager"
				"wheel"
			];
		};

	};

	# Select home features for user
	flake.homeConfigurations.mika =
		inputs.home-manager.lib.homeManagerConfiguration {
			pkgs = import inputs.nixpkgs {system = "x86_64-linux";};

      xdg = {
        enable = true;
        mime.enable = true;
      };

			modules = with self.homeModules; [
      	audio-editing
				draw
				gaming
				git
				kitty
				messengers
				office
				terminal
				nix-config

				mika
			];
		};

	# Setup home manager
	flake.homeModules.mika = { pkgs, ... }: {
		programs.home-manager.enable = true;

		home = {
			username = "mika";
  			homeDirectory = "/home/mika";
			stateVersion = "26.05";

			packages = with pkgs; [
				kitty
				lazygit
				spotify
			];
		};
	};
}
