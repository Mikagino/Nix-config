{ pkgs, ... }:
{
 # nix helper which cleans up automatically every week
  programs.nh = {
    enable = true;
    clean.enable = true;
    clean.extraArgs = "--keep-since 7d --keep 3";
    flake = "/home/mika/.nix-config";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  services.earlyoom = {
    enable = true;
    freeSwapThreshold = 2;
    freeMemThreshold = 2;
    extraArgs = [
      "-g" "--avoid '^(X|plasma.*|konsole|kwin)$'"
      "--prefer '^(electron|libreoffice|gimp)$'"];
  };

  systemd.oomd.enableUserSlices = true;  # take action on user-space process hierarchies

  environment.systemPackages = with pkgs; [
    home-manager
    wineWow64Packages.stable
    winetricks
  ];

  programs.firefox.enable = true;

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;  # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports for Source Dedicated Server hosting
    extraCompatPackages = with pkgs; [
      proton-ge-bin
    ];
  };
}
