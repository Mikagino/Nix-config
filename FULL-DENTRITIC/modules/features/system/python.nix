{
	inputs,
	...
}: {
	flake.nixosModules.python = { pkgs, ... }: {
    environment.systemPackages = with pkgs; [
      (python314.withPackages (python-pkgs: with python-pkgs;[
        requests
        inquirer
        tqdm
      ]))
		];
  };
}
