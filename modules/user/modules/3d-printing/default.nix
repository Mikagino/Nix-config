# Source: https://gist.github.com/Force67/d9bb6acb37d9febf8554fa87dc916afe

{
  inputs,
  pkgs,
  lib,
  ...
}:

# Based off the excellent post on reddit here: https://www.reddit.com/r/NixOS/comments/19b7k5e/how_to_properly_install_pkgs_to_the_latest_version/
# This is updated to work with nix 24.05, and also installs a desktop entry so cura can be found in kde start menu.
let
  cura5 = pkgs.appimageTools.wrapType2 rec {
    name = "cura5";
    version = "5.13.0";
    src = builtins.fetchurl {
      url = "https://github.com/Ultimaker/Cura/releases/download/${version}/UltiMaker-Cura-${version}-linux-X64.AppImage";
      sha256 = {
        "5.13.0" = "1fb8a7610460e03ec62da950d1c173a249b23b59";
      }."${version}";
    };
    extraPkgs = pkgs: with pkgs; [ ];
  };

  curaLauncher = pkgs.writeShellScriptBin "cura" ''
    # AppImage version of Cura loses current working directory and treats all paths relative to $HOME.
    # So we convert each of the files passed as argument to an absolute path.
    # This fixes use cases like `cd /path/to/my/files; cura mymodel.stl anothermodel.stl`.
    args=()
    for a in "$@"; do
      if [ -e "$a" ]; then
        a="$(realpath "$a")"
      fi
      args+=("$a")
    done
    exec "${cura5}/bin/cura5" "''${args[@]}"
  '';

  curaDesktopEntry = ''
    [Desktop Entry]
    Version=1.0
    Name=Cura
    Comment=Cura 3D Printing Software
    Exec=${curaLauncher}/bin/cura %f
    Icon=cura
    Terminal=false
    Type=Application
    Categories=Graphics;3DGraphics;
  '';
in
{
  home.packages = with pkgs.unstable; [
    curaLauncher
  ];

  home.file = {
    ".local/share/applications/cura.desktop".text = curaDesktopEntry;
  };
}
