# Docs: https://nixos.org/manual/nixpkgs/stable/#sec-pkgs-appimageTools

{
  ...
}: {
  flake.homeModules.print3d = { pkgs,
                                lib,
                                ... }:
  let
    owner = "Ultimaker";
    pname = "Cura";
    version = "5.13.0";
    appImageName = "UltiMaker-Cura-5.13.0-linux-X64.AppImage";

    # Fetch AppImage (wrapType2 wont accept archives as source)
    src = pkgs.fetchurl {
      url = "https://github.com/${owner}/${pname}/releases/download/${version}/${owner}-${pname}-${version}-linux-X64.AppImage";
      # sometimes the path must be manually entered or modified (especially the asset's name):
      #     "https://github.com/Ultimaker/Cura/releases/download/5.13.0/UltiMaker-Cura-5.13.0-linux-X64.AppImage"
      sha256 = "sha256:100f068127b2598167f00ba4db0e0699ded45adf97bbab2d22ff171a1e1ecc40"; # <-- dummy hash: after first compilation this line will give an error with the correct hash
    };

    # Extract content from AppImage for creating a desktop file later
    appimageContents = pkgs.appimageTools.extract {
      inherit pname version src;
    };

    # # Additional local content needed for desktop file
    # localContents = /etc/nixos/localPackages/${pname};

    cura-appimage = pkgs.appimageTools.wrapType2 {
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
      cura-appimage
    ];
  };
}
