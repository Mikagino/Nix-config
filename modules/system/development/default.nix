{ pkgs, inputs, ... }:

{
  programs.bash.enable = true;

  environment.systemPackages = [
    pkgs.godot-mono
    inputs.blender-bin.packages.${system};
    #(blender.override {config.cudaSupport=true; config.rocmSupport=false;})
  ];
}
