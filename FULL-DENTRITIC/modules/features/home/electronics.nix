{
	inputs,
	...
}: {
	flake.homeModules.electronics = {pkgs, ... }: {
		home.packages = with pkgs; [
      rpi-imager
      kdePackages.kirigami
      qt6.qt3d

      #caligula # alternative image burner
    ];
	};
}
