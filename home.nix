{ config, pkgs, ... }:

{
  home.username = "mika";
  home.homeDirectory = "/home/mika";

  home.packages = [
    pkgs.lazygit
    pkgs.neovim
    pkgs.zoxide
    pkgs.tldr

    pkgs.vscode
    pkgs.anki
    
    pkgs.dotnetCorePackages.sdk_10_0-bin
    pkgs.javaPackages.compiler.openjdk17
    
    pkgs.signal-desktop
    pkgs.blender
    
    pkgs.whatsapp-electron
    pkgs.thunderbird
    pkgs.obsidian
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

