{
	inputs,
	...
}: {
	flake.homeModules.draw = {pkgs, ... }: {
		home.packages = [
			gaphor
      gimp2-with-plugins
    ];
	};
}