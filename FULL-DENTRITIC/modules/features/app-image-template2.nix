# let
# cura5 = pkgs.appimageTools.wrapType2 rec {
#     name = "cura5";
#     version = "5.7.1";
#     src = builtins.fetchurl {
#       url = "https://github.com/Ultimaker/Cura/releases/download/${version}/UltiMaker-Cura-${version}-linux-X64.AppImage";
#       sha256 = {
#         "5.7.1" = "2d9303d1fa3c4d2943109b29bd391aef6e2562ae4482b3a50e4c0c92d5ea013c";
#       }."${version}";
#     };
#     extraPkgs = pkgs: with pkgs; [ ];
# };
# in
# {
# 	flake.homeModules.NAME = {pkgs, ... }: {
# 		home.packages = with pkgs.unstable; [
#       curaLauncher
#     ];
# 	};
# }
{ }
