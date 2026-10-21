# ------------------------------------------------------------------------------------------
# Setup for a single machine, importing only the necessary modules.
# ------------------------------------------------------------------------------------------

{ 
  inputs,
  self,
  lib,
  config,
  ...
}: {
  # ----- Modules -----
  flake.nixosConfigurations.hauptquartier = inputs.nixpkgs.lib.nixosSystem {
    modules = with self.nixosModules; [
      common
      audio
      desktop-env
      #git
      locale
      networking
      nix-config
      nvidia
      mika
    ]
    ++ [
      self.nixosModules.hauptquartier
    ];
  };

  # ----- Host Setup -----
  flake.nixosModules.hauptquartier = {
    networking.hostName = "hauptquartier";
    system.stateVersion = "26.05";

    # ----- Hardware Config -----
    boot = {
      initrd.availableKernelModules = [
        "nvme"
        "xhci_pci"
        "ahci"
        "usbhid"
        "usb_storage"
        "uas"
        "sd_mod"
      ];
      initrd.kernelModules = [ ];
      kernelModules = [ "kvm-amd" ];
      extraModulePackages = [ ];
    };
    nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
    hardware.cpu.amd.updateMicrocode = true;

    # ----- Disks -----
    fileSystems."/" =
    { device = "/dev/disk/by-uuid/3ecbe42b-4860-46ca-8494-9fbc1143e129";
      fsType = "btrfs";
    };

    fileSystems."/home" =
      { device = "/dev/disk/by-uuid/3ecbe42b-4860-46ca-8494-9fbc1143e129";
        fsType = "btrfs";
        options = [ "subvol=home" ];
      };

    fileSystems."/nix" =
      { device = "/dev/disk/by-uuid/3ecbe42b-4860-46ca-8494-9fbc1143e129";
        fsType = "btrfs";
        options = [ "subvol=nix" ];
      };

    fileSystems."/boot" =
      { device = "/dev/disk/by-uuid/F77E-6B32";
        fsType = "vfat";
        options = [ "fmask=0077" "dmask=0077" ];
      };

    # ----- Swap (optional) -----
    # Add swap device for allowing to store "cold" pages of virtual RAM memory in a swap file
    #swapDevices = [{
    #  device = "/var/lib/swapfile";
    #  size = 16 * 1024; # 16 GiB
    #}];
  };
}