{ ... }:
{
  shellAliases = {
    cls = "clear";

    # NixOs
    test-nix = "sudo nixos-rebuild test --flake ~/.nix-config#hauptquartier --cores 4 --max-jobs 2";
    rebuild = "sudo nixos-rebuild switch --flake ~/.nix-config#hauptquartier --cores 4 --max-jobs 2";
    homesw = "home-manager switch --flake ~/.nix-config";
    list-gens = "nixos-rebuild list-generations";
    find-store-path = ''function { nix-shell -p $1 --command "nix eval -f \"<nixpkgs>\" --raw $1" }'';
    sys-update = "nix flake update --flake ~/.nix-config && rebuild";
  };
}
