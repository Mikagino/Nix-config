{
	...
}: {
	flake.homeModules.audio-editing = {pkgs, ... }: {
		home.packages = with pkgs; [
      audacity
    ];
	};
}
