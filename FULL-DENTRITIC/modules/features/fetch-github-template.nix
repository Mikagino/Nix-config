{
  ...
}: {
  flake.homeModules.NAME = {  pkgs,
                              lib,
                              ... }:
  let
  # Fetch AppImage (wrapType2 wont accept archives as source)
  src = pkgs.fetchurl {
    url = "https://...";
    sha256 = "sha256:...";
    version = "...";
    executable = true;
    meta = {

    };
  };

  in {

  };
}
