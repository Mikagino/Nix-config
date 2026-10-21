{
  inputs,
  ...
}: {
  flake.nixosModules.common = {pkgs, ... }: {
    # Use the systemd-boot EFI boot loader.
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;

    services.printing.enable = true;

    programs.firefox.enable = true;
    programs.bash.enable = true;

    environment.systemPackages = with pkgs; [
      vscode
    ];
  };
}