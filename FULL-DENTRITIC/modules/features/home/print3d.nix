# Docs: https://nixos.org/manual/nixpkgs/stable/#sec-pkgs-appimageTools

{ lib, appimageTools, fetchurl }:

let
  owner = "Ultimaker";
  pname = "Cura";
  version = "5.13.0";
  appImageName = "UltiMaker-Cura-5.13.0-linux-X64.AppImage";

  # Fetch AppImage (wrapType2 wont accept archives as source)
  src = fetchurl {
    url = "https://github.com/${owner}/${pname}/releases/download/${version}/${owner}-${pname}-${version}-linux-X64.AppImage";
    #     "https://github.com/Ultimaker/Cura/releases/download/5.13.0/UltiMaker-Cura-5.13.0-linux-X64.AppImage"
    sha256 = ""; # <-- dummy hash: after first compilation this line will give an error with the correct hash
  };

  # Extract content from AppImage for creating a desktop file later
  appimageContents = appimageTools.extract {
    inherit pname version src;
  };

  # # Additional local content needed for desktop file
  # localContents = /etc/nixos/localPackages/${pname};

in {
  flake.homeModules.print3d = {pkgs, ... }: {
    appimageTools.wrapType2 {
      inherit pname version src;

      # 1. Add desktop file
      # 2. Let desktop file start package
      # 3. Add icons for desktop file
      # Paths and files can be found in the extracted folder within /nix/store
      extraInstallCommands = ''
        install -m 444 -D ${appimageContents}/${pname}.desktop -t $out/share/applications
        substituteInPlace $out/share/applications/${pname}.desktop \
          --replace 'Exec=AppRun' 'Exec=${pname}'
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
  };
}
