{
	...
}: {
	flake.homeModules.draw = {pkgs, ... }: {
		home.packages = with pkgs; [
			gaphor
      gimp2-with-plugins
    ];
	};
}
