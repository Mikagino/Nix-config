{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    neovim
    tldr
    screenfetch
    nix-output-monitor
  ];

  programs.zoxide = {
    enable = true;
  };

  programs.git = {
    enable = true;
    settings.user = {
      name = "Mikagino";
      email = "angeli.mika@gmail.com";
    };

    settings = {
      init = {
        defaultBranch = "main";
        safe.directory = "~/.nix-config/";
      };
    };
    lfs.enable = true;
  };

  programs.lazygit = {
    enable = true;
  };

  programs.nix-your-shell.nix-output-monitor.enable = true;
}
