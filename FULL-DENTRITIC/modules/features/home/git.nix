{
	inputs,
	...
}: {
	flake.homeModules.git = {pkgs, ... }: {
    programs.git = {
      enable = true;
      lfs.enable = true;
      settings = {
        user = {
          name = "Mikagino";
          email = "angeli.mika@gmail.com";
        };
        init = {
          defaultBranch = "main";
          safe.directory = "~/.nix-config/";
        };
      };
    };

    programs.lazygit = {
      enable = true;
    };
	};
}