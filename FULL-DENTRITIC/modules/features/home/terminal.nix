{
	inputs,
	...
}: {
	flake.homeModules.terminal = { pkgs, ... }: {
    home.packages = with pkgs; [
      neovim
			tldr
			screenfetch
			#nix-output-monitor
		];

		# ----- zoxide ----- 
		programs.zoxide = {
			enable = true;
		};

		# TODO: Can this be automated for each user?
		home-manager.users.mika = {
			programs.zoxide.enable = true;
		};

		# ----- btop (hardware monitor) ----- 
		programs.btop = {
			enable = true;
		};
  };
}