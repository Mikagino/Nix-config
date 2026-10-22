{
	...
}: {
	flake.nixosModules.locale = { pkgs, ... }: {
		time.timeZone = "Europe/Berlin";
		i18n.defaultLocale = "en_US.UTF-8";
		i18n.extraLocaleSettings = {
			LC_ADDRESS = "de_DE.UTF-8";
			LC_IDENTIFICATION = "de_DE.UTF-8";
			LC_MEASUREMENT = "de_DE.UTF-8";
			LC_MONETARY = "de_DE.UTF-8";
			LC_NAME = "de_DE.UTF-8";
			LC_NUMERIC = "de_DE.UTF-8";
			LC_PAPER = "de_DE.UTF-8";
			LC_TELEPHONE = "de_DE.UTF-8";
			LC_TIME = "de_DE.UTF-8";
		};

    # ----- Fonts -----
    # https://nixos.wiki/wiki/Fonts#Installing_all_nerdfonts
    fonts = {
      packages = with pkgs; [
        ubuntu-classic
        liberation_ttf

        nerd-fonts.fira-code
        nerd-fonts.droid-sans-mono
        nerd-fonts.arimo
      ];

      fontconfig = {
        defaultFonts = {
          serif = [  "Liberation Serif" ];
          sansSerif = [ "Ubuntu" ];
          monospace = [ "Ubuntu Mono" ];
        };
      };
    };

		# Configure console keymap
		console.keyMap = "de-latin1-nodeadkeys";
    console.font = "Droid Sans Mono";

		# Configure keymap in X11
		services.xserver.xkb = {
			layout = "de";
			variant = "nodeadkeys";
		};
	};
}
