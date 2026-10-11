{ pkgs, ... }:

{
  programs.bash.enable = true;

  environment.systemPackages = with pkgs; [
    godot-mono
    (blender.override {config.cudaSupport=true; config.rocmSupport=false;})
  ];

#   environment.systemPackages = with self.inputs.blender-bin.packages.${system}; [
#     default
#   ];
}
