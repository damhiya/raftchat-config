{
  description = "NixOS system configuration";

  nixConfig = {
    substituters = [
      "https://cache.nixos.org/"
    ];
    trusted-public-keys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
    ];
  };

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs =
    { self, nixpkgs }:
    let
      baseModule = {
        imports = [ ];
        system.configurationRevision = nixpkgs.lib.mkIf (self ? rev) self.rev;
        nixpkgs.overlays = [ (import ./scripts/overlay.nix) ];
      };
    in
    {

      nixosConfigurations.raftchat = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          baseModule
          ./hosts/raftchat/configuration.nix
        ];
      };
    };
}
