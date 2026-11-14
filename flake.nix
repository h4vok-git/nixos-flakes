{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    helium-flake.url = "github:oxcl/nix-flake-helium-browser";
    helium-flake.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, helium-flake, ... }: {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      modules = [
        ./configuration.nix

        ({ pkgs, ... }: {
          nixpkgs.overlays = [ helium-flake.overlays.default ];

          environment.systemPackages = [
            pkgs.helium
          ];
        })
      ];
    };
  };
}
