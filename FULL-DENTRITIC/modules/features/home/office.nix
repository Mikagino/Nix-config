{
	inputs,
	...
}: {
	flake.homeModules.office = { pkgs, ... }: {
    programs.anki.enable = true;

    environment.systemPackages = with pkgs; [
			# ----- Libre Office -----
			libreoffice-qt
			hunspell
			hunspellDicts.uk_UA
			hunspellDicts.en_US
			hunspellDicts.de_DE

			# ----- Others -----
			obsidian
			xournalpp
		];
  };
}