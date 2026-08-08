{
  description = "Home Manager Configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";
    unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixGL = {
      url = "github:nix-community/nixGL";
      inputs.nixpkgs.follows = "unstable";
    };
  };

  outputs = {
    self,
    nixpkgs,
    unstable,
    home-manager,
    nixGL,
    ...
  }: {
    nixosConfigurations."shinkiro" = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./nixos/configuration.nix
        home-manager.nixosModules.default
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            extraSpecialArgs = {
              unstable = import unstable {
                system = "x86_64-linux";
                config = {
                  allowUnfree = true;
                  allowUnfreePredicate = _: true;
                };
              };
            };
            users."miglou" = ./home-manager/shinkiro.nix;
          };
        }
      ];
      specialArgs = {
        unstable = import unstable {
          system = "x86_64-linux";
          config = {
            allowUnfree = true;
            allowUnfreePredicate = _: true;
          };
        };
      };
    };
    homeConfigurations."pedro.amaral" = home-manager.lib.homeManagerConfiguration {
      pkgs = import unstable {
        system = "x86_64-linux";
        config = {
          allowUnfree = true;
          allowUnfreePredicate = _: true;
        };
      };
      extraSpecialArgs = {
        inherit nixGL;
      };
      modules = [./home-manager/home.nix];
    };
  };
}