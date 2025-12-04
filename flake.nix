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

  outputs = { self, nixpkgs, nixpkgs-unstable, home-manager, wsl, darwin, rust-overlay, ... }@inputs:
  let
    systems = [
      "x86_64-linux"
      "aarch64-linux"
      "aarch64-darwin"
      "x86_64-darwin"
    ];

    forAllSystems = f: builtins.listToAttrs (map (system: {
      name = system;
      value = f system;
    }) systems);

  in {
    ####################################################################################
    # NixOS Hosts
    ####################################################################################
    nixosConfigurations = {
      thinkbook = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {
          inherit nixpkgs nixpkgs-unstable home-manager rust-overlay;
        };
        modules = [
          ./hosts/thinkbook
        ];
      };

      vmware = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {
          inherit nixpkgs nixpkgs-unstable home-manager rust-overlay;
        };
        modules = [
          ./hosts/vmware
        ];
      };
    };

    ####################################################################################
    # macOS Hosts (nix-darwin)
    ####################################################################################
    darwinConfigurations = {
      macbook = darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        specialArgs = {
          inherit nixpkgs nixpkgs-unstable;
        };
        modules = [
          ./hosts/macbook
        ];
      };
    };

    ####################################################################################
    # WSL / Linux without NixOS
    ####################################################################################
    homeConfigurations = {
      ela-wsl = home-manager.lib.homeManagerConfiguration {
        pkgs = import nixpkgs { system = "x86_64-linux"; };
        modules = [
          ./hosts/wsl-dev/default.nix
        ];
      };
    };

    ####################################################################################
    # Packages & devShells
    ####################################################################################
    # packages = forAllSystems (system:
    #   let pkgs = import nixpkgs { inherit system; };
    #   in import ./pkgs { inherit pkgs; }
    # );

    # devShells = forAllSystems (system:
    #   let pkgs = import nixpkgs { inherit system; };
    #   in import ./pkgs/devshells { inherit pkgs; }
    # );
  };
}
