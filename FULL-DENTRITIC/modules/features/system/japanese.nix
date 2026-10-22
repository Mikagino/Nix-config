{
	inputs,
	...
}: {
	flake.nixosModules.japanese = { pkgs, ... }: {
    fonts.packages = with pkgs; [
      ipafont
      kochi-substitute
    ];

    i18n.inputMethod = {
      enable = true;
      type = "ibus";
      ibus.engines = with pkgs.ibus-engines; [
        mozc-ut
      ];
    };
  };
}
