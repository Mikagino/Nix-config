{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    blender
    javaPackages.compiler.openjdk17
    zlib
    dotnetCorePackages.sdk_8_0-bin
    python313Packages.python
  ];

  # Install Godot export templates
#   home.file.".local/share/godot/export_templates/${builtins.replaceStrings [ "-" ] [ "." ] pkgs.godot-mono_4-export-templates.version}".source = pkgs.godot-mono_4-export-templates;
}
