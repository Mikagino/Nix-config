{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    libreoffice-qt
    hunspell
    hunspellDicts.uk_UA
    hunspellDicts.en_US
    hunspellDicts.de_DE
  ];
}
