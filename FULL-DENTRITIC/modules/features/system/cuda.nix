{
	pkgs,
	...
}: {
	flake.nixosModules.cuda = { pkgs, ... }: {
    # allowUnfreePredicate = pkgs._cuda.lib.allowUnfreeCudaPredicate;
    allowUnfreePredicate = true;
		#cudaCapabilities = [ <target-architectures> ];
		#cudaForwardCompat = true;
		cudaSupport = true;
  };
}