{
	inputs,
	...
}: {
	flake.homeModules.audio-editing = {pkgs, ... }: {
		home.packages = [
      audacity
    ];
	};
}