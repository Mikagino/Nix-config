{
  pkgs,
  pkgs-unstable,
  ...
}:

{
  programs.bash.enable = true;

  environment.systemPackages =
    (with pkgs; [
      vscode
      #inputs.blender-bin.packages.${system}.default
      #(blender.override {config.cudaSupport=true; config.rocmSupport=false;})
    ])
    ++
    (with pkgs-unstable; [
      godot-mono
    ]);

  #pkgs.vscode-utils.extensionsFromVscodeMarketplace
}
