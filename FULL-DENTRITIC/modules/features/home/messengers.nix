{
	inputs,
	...
}: {
	flake.homeModules.messengers = {pkgs, ... }: {
		home.packages = with pkgs; [
			signal-desktop
			whatsapp-electron
			thunderbird
			discord
			telegram-desktop

			spotify # TODO: move somehwere else

			audacity # TODO: move somehwere else
		];
	};
}