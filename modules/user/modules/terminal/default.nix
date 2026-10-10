{ config, pkgs, ... }:

{
  programs.git = [
    enable = true;
    userName = "Mikagino";
    userEmail = "angeli.mika@gmail.com";
    extraConfig = {
      init.defaultBranch = "main";
      safe.directory = "~/.nix-config/";
    };
  ]

  programs.bash.enable = true;

  home.packages = with pkgs; [
    lazygit
    neovim
    zoxide
    tldr
  ];
}
