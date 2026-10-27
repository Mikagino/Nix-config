# Docs: https://nixos.org/manual/nixpkgs/stable/#sec-pkgs-appimageTools

{
  ...
}: {
  flake.homeModules.NAME = {  pkgs,
                              lib,
                              ... }:
  let
    owner = "somebody";
    pname = "name";
    version = "1.0.0";
    # appImageName = "asset-name.AppImage";

    # Fetch AppImage (wrapType2 wont accept archives as source)
    src = pkgs.fetchurl {
      url = "https://github.com/${owner}/${pname}/releases/download/${version}-stable/${pname}_v${version}_${pkgs.stdenv.hostPlatform.system}.AppImage";
      # sometimes the path must be manually entered or modified (especially the asset's name):
      #url = "https://github.com/${owner}/${pname}/releases/download/${version}/${appImageName}";
      sha256 = ""; # <-- dummy hash: after first compilation this line will give an error with the correct hash
    };

    # Extract content from AppImage for creating a desktop file later
    appimageContents = pkgs.appimageTools.extract {
      inherit pname version src;
    };

    # # Additional local content needed for desktop file
    # localContents = /etc/nixos/localPackages/${pname};

    APP-NAME = pkgs.appimageTools.wrapType2 {
      inherit pname version src;

      # 1. Find desktop file
      # 2. Find desktop file names
      # 3. Add desktop file
      # 4. Let desktop file start package
      # 5. Add icons for desktop file
      # Paths and files can be found in the extracted folder within /nix/store
      extraInstallCommands = ''
        desktopFile="$(find ${appimageContents} -maxdepth 1 -type f -name '*.desktop' -print -quit)"
        desktopName="$(basename "$desktopFile")"
        install -m 444 -D $desktopFile -t $out/share/applications
        sed -i 's|^Exec=.*$|Exec=${pname}|' \
          "$out/share/applications/$desktopName"
        cp -r ${appimageContents}/usr/share/icons $out/share
      '';

      meta = with lib; {
        homepage = "https://github.com/${powner}/${pname}";
        description = "Short (one-line) description of the package (Displayed on search.nixos.org)";
        license = licenses.mit; # <-- see https://nixos.org/manual/nixpkgs/stable/#sec-meta-license
        # maintainers = with lib.maintainers; [ ];
        platforms = platforms.unix;
      };
    };

  in {
    home.packages = [
      APP-NAME
    ];
  };
}
