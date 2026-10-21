{
	inputs,
	...
}: {
	flake.nixosModules.gaming = { pkgs, ... }: {
		# ----- Wine -----
		environment.systemPackages = with pkgs; [
			wineWow64Packages.stable
			winetricks
		];

		# optimize system performance for gaming
		programs.gamemode.enable = true;
		
		# ----- Steam -----
		programs.steam = {
			enable = true;

			# Settings for multiplayer (remote play, hosting, local hosting)
			remotePlay.openFirewall = true;
			dedicatedServer.openFirewall = true;
			localNetworkGameTransfers.openFirewall = true;

			extraCompatPackages = with pkgs; [
				proton-ge-bin
			];

			# Overrides for the default game options
			package =
				pkgs.unstable.steam.override {
					extraEnv = {
						MANGOHUD = "0"; # disable mangohud by default
						STEAMDECK = "1"; # skips launchers for some games
						GAMEMODERUN = "1"; # launch with gamemode
						PROTON_ENABLE_WAYLAND = "1"; # run the game using wayland
					};
				};
		};

		# ----- Lutris -----
		programs.lutris = {
			enable = false;
			defaultWinePackage = pkgs.proton-ge-bin;
		};
	};
}