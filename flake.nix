{
  description = "Home Manager configuration of hakoai";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { nixpkgs, home-manager, ... }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};

      mkHome =
        isWsl:
        home-manager.lib.homeManagerConfiguration {
          inherit pkgs;

          modules = [ ./home.nix ];

          extraSpecialArgs = {
            inherit isWsl;
          };
        };
    in
    {
      homeConfigurations = {
        linux = mkHome false;
        wsl = mkHome true;
      };
    };
}
