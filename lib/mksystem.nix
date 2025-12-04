# This function creates a NixOS system based on our VM setup for a
# particular architecture.
{ nixpkgs, overlays, inputs }:

name:
{
  darwin ? false,
  wsl ? false
}:

let
  # True if this is a WSL system.
  isWSL = wsl;

  # True if Linux, which is a heuristic for not being Darwin.
  isLinux = !darwin && !isWSL;

  # The config files for this system.
  hostConfig = ../hosts/${name};

  # NixOS vs nix-darwin functionst
  systemFunc = if darwin then inputs.darwin.lib.darwinSystem else nixpkgs.lib.nixosSystem;
  home-manager = if darwin then inputs.home-manager.darwinModules else inputs.home-manager.nixosModules;

in systemFunc rec {
  modules = [
    # Apply our overlays. Overlays are keyed by system type so we have
    # to go through and apply our system type. We do this first so
    # the overlays are available globally.
    { nixpkgs.overlays = overlays; }

    { 
      nix = {
        settings = {
          substituters = [ "https://mirror.sjtu.edu.cn/nix-channels/store" ];
          experimental-features = [ "nix-command" "flakes" ];
        };
      };

      # Allow unfree packages.
      nixpkgs.config.allowUnfree = true;
    }

    # Bring in WSL if this is a WSL build
    (if isWSL then inputs.wsl.nixosModules.wsl else {})

    hostConfig
    home-manager.home-manager {
      home-manager.useGlobalPkgs = true;
      home-manager.useUserPackages = true;

      home-manager.sharedModules = nixpkgs.lib.mkAfter [{
        home.stateVersion = "25.11";
      }];
    }

    # We expose some extra arguments so that our modules can parameterize
    # better based on these values.
    {
      config._module.args = {
        currentHost = name;
        isWSL = isWSL;
        inputs = inputs;
      };
    }
  ];
}