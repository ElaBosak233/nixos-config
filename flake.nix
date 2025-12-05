{
  description = "Multi-host NixOS Flake By Ela";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    nixpkgs-master.url = "github:nixos/nixpkgs";

    home-manager.url = "github:nix-community/home-manager/release-25.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    wsl.url = "github:nix-community/NixOS-WSL";
    wsl.inputs.nixpkgs.follows = "nixpkgs";

    darwin.url = "github:lnl7/nix-darwin";
    darwin.inputs.nixpkgs.follows = "nixpkgs";

    rust-overlay.url = "github:oxalica/rust-overlay";
    rust-overlay.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, home-manager, wsl, darwin, ... }@inputs:
  let
    overlays = [
      inputs.rust-overlay.overlays.default
    ];

    mkSystem = import ./lib/mksystem.nix {
      inherit overlays nixpkgs inputs;
    };

  in {
    ####################################################################################
    # NixOS Hosts
    ####################################################################################
    nixosConfigurations = {
      thinkbook = mkSystem "thinkbook" {
        system = "nixos";
        roles = [ "workstation" ];
      };
      vmware = mkSystem "vmware" {
        system = "nixos";
        roles = [ "virtual-machine" ];
      };
    };

    ####################################################################################
    # macOS Hosts (nix-darwin)
    ####################################################################################
    darwinConfigurations = {
      macbook = mkSystem "macbook" {
        system = "darwin";
        roles = [ "workstation" ];
      };
    };

    ####################################################################################
    # WSL / Linux without NixOS
    ####################################################################################
    homeConfigurations = {
      wsl = home-manager.lib.homeManagerConfiguration {
        pkgs = import nixpkgs { system = "x86_64-linux"; };
        modules = [
          ./hosts/wsl-dev/default.nix
        ];
      };
    };
  };
}
