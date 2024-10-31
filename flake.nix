{
  description = "NixOS system configuration";

  nixConfig = {
    substituters = [
      "https://cache.nixos.org/"
      "https://nix-community.cachix.org"
    ];
    trusted-public-keys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
  };

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
    }:
    let
      baseModule = {
        imports = [ home-manager.nixosModules.default ];
        system.configurationRevision = nixpkgs.lib.mkIf (self ? rev) self.rev;
        nixpkgs.overlays = [ (import ./scripts/overlay.nix) ];
      };
    in
    {
      nixosConfigurations = {
        raftchat1 = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            baseModule
            ./common/configuration.nix
            ./hosts/raftchat1/hardware-configuration.nix
            { networking.hostName = "raftchat1"; }
          ];
        };
        raftchat2 = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            baseModule
            ./common/configuration.nix
            ./hosts/raftchat2/hardware-configuration.nix
            { networking.hostName = "raftchat2"; }
          ];
        };
      };
    };
}
