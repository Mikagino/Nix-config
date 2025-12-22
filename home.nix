{ config, pkgs, ... }:

{
  home.username = "mika";
  home.homeDirectory = "/home/mika";

  home.packages = [
    pkgs.lazygit
    pkgs.neovim
    pkgs.vscode
    pkgs.anki
  ];

  xdg.enable = true;
  xdg.mime.enable = true;
  programs.neovim.enable = true;
  programs.anki.enable = true;
  xdg.systemDirs.data = [ "$HOME/.local/share" ];
  xdg.desktopEntries = {
    neovim = {
      name = "Neovim";
      genericName = "Text Editor";
      exec = "nvim %F";
      icon = "nvim";
      terminal = true;
      categories = [ "Utility" "TextEditor" "Development" ];
    };

    vscode = {
      name = "Visual Studio Code";
      genericName = "Code Editor";
      exec = "code %F";
      icon = "vscode";
      terminal = false;
      categories = [ "Development" "IDE" ];
    };

    anki = {
      name = "Anki";
      genericName = "Spaced Repetition Flashcards";
      exec = "anki";
      icon = "anki";
      terminal = false;
      categories = [ "Education" "Utility" ];
    };
  };


  home.stateVersion = "24.05";

  programs.home-manager.enable = true;
}

