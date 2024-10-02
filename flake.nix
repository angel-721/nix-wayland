{


  description = "My first flake setup.";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";
    home-manager.url =  "github:nix-community/home-manager/release-23.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    stylix.url = "github:danth/stylix";
  };

  outputs = { self, nixpkgs, home-manager, stylix, ... }:
    let 
      # declare vars here such as system
      system = "x86_64-linux";
      lib = nixpkgs.lib;
      pkgs = nixpkgs.legacyPackages.${system};


  in {
  

   nixosConfigurations = {
    # I know that "nixos" is a boring hostname
    nixos = lib.nixosSystem{
      inherit system;
      modules = [ ./configuration.nix ];
    };
   };
  
  homeConfigurations = {
    # give name of user
    angel = home-manager.lib.homeManagerConfiguration{
      inherit pkgs;
      modules = [ ./home.nix ];
    };
   };


  };


}
