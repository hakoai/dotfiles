{
  description = "Home Manager configuration of hakoai";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-parts.url = "github:hercules-ci/flake-parts";
  };

  outputs =
    inputs @ { flake-parts, nixpkgs, home-manager, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [
        "x86_64-linux"
        "aarch64-darwin"
      ];

      flake = {
        homeConfigurations =
          let
            mkHome =
              { system, isWsl, isDarwin ? false }:
              let
                pkgs = import nixpkgs { inherit system; };
              in
              home-manager.lib.homeManagerConfiguration {
                inherit pkgs;
                modules = [ ./home/default.nix ];
                extraSpecialArgs = { inherit isWsl isDarwin; };
              };
          in
          {
            linux = mkHome {
              system = "x86_64-linux";
              isWsl = false;
            };
            wsl = mkHome {
              system = "x86_64-linux";
              isWsl = true;
            };
            darwin = mkHome {
              system = "aarch64-darwin";
              isWsl = false;
              isDarwin = true;
            };
          };
      };
    };
}
