{
	...
}: {
	flake.homeModules.messengers = {pkgs, ... }: {
		home.packages = with pkgs; [
			signal-desktop
			whatsapp-electron
			thunderbird
			discord
			telegram-desktop
			zoom-us
		];
	};
}
