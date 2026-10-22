{
	inputs,
	...
}: {
  flake.homeModules.office = { pkgs, ... }: {
    programs.anki.enable = true;

    home.packages = with pkgs; [
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
