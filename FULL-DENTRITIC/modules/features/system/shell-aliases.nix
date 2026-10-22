{
	...
}: {
	flake.nixosModules.shell-aliases = { pkgs, ... }: {
    environment.shellAliases = {
      nrebuild = "sudo nixos-rebuild --flake ./.nix-config/FULL-DENTRITIC#hauptquartier";
      hrebuild = "home-manager --flake ./.nix-config/FULL-DENTRITIC/#mika";
      laz = "lazygit";
    };
  };
}
