{ config, pkgs, ... }:

{
  home.username = "mika";
  home.homeDirectory = "/home/mika";

  home.packages = with pkgs; [
    lazygit
    neovim
    zoxide
    tldr

    anki
    
    javaPackages.compiler.openjdk17
    zlib
    dotnetCorePackages.sdk_8_0-bin
    python313Packages.python

    gtk4

    gimp2-with-plugins
    blender
    
    signal-desktop
    whatsapp-electron
    thunderbird
    discord
    telegram-desktop

    obsidian
    xournalpp
    gaphor

    spotify-qt
  ];

  home.shellAliases = {
    blender = "nixGLNvidia blender";
  };

  xdg.enable = true;
  xdg.mime.enable = true;
  xdg.systemDirs.data = [ "$HOME/.local/state/nix/profiles/home-manager/home-path/share/applications" ];
  targets.genericLinux.enable = true;
  xdg.desktopEntries = {
    neovim = {
      name = "Neovim";
      genericName = "Text Editor";
      exec = "nvim %F";
      icon = "nvim";
      terminal = true;
      categories = [ "Utility" "TextEditor" "Development" ];
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

