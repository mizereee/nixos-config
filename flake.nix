{
  description = "Мой NixOS флейк";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
    home-manager.url = "github:nix-community/home-manager/release-25.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nixpkgs-unst.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs, home-manager, nixpkgs-unst, ... }: 
  let
    system = "x86_64-linux";

    overlay-unst = final: prev: {
      unstable = import nixpkgs-unst {
        inherit system;
        config.allowUnfree = true;
      };
    };
  in {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
     inherit system;
      
      modules = [
        ./configuration.nix
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.miscere = import ./home.nix;
          
          nixpkgs.overlays = [ overlay-unst ];       
        }
      ];
    };
  };
}
