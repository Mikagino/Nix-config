{
  pkgs,
  ...
}:

{
  programs.bash.enable = true;

  environment.systemPackages = with pkgs; [
      vscode
      unstable.godot-mono
      #inputs.blender-bin.packages.${system}.default
      #(blender.override {config.cudaSupport=true; config.rocmSupport=false;})
    ];

  #pkgs.vscode-utils.extensionsFromVscodeMarketplace
}
