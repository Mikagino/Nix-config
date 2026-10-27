{
	inputs,
	...
}: {
	flake.nixosModules.app-image = { pkgs, ... }: {
    # Enable the direct execution of AppImages
    programs.appimage = {
      enable = true;
      binfmt = true;
      # package = pkgs.appimage-run.override { extraPkgs = pkgs: [ pkgs.libthai ]; }; # thai language lib, sometimes necessary
    };
	};
}
