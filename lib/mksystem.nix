# lib/mksystem.nix
{ nixpkgs, overlays, inputs }:

name:

{
  system ? "nixos",       # "nixos" | "darwin" | "wsl"
  roles ? [],             # list of roles for this host
  extraModules ? [],
  ...
}:

let
  # Platform-specific system builder
  systemFunc =
    if system == "darwin"
    then inputs.darwin.lib.darwinSystem
    else nixpkgs.lib.nixosSystem;

  # home-manager module types based on system
  homeManagerModules =
    if system == "darwin"
    then inputs.home-manager.darwinModules
    else inputs.home-manager.nixosModules;

  # Path to host folder
  hostConfig = ../hosts/${name};
  userOSConfig = ../users/ela/system/${system}.nix;

in systemFunc rec {
  inherit system;

  modules = [

    ###################################################################
    # Global overlays
    ###################################################################
    { nixpkgs.overlays = overlays; }

    ###################################################################
    # Common Nix settings
    ###################################################################
    {
      nix.settings = {
        substituters = [
          "https://mirror.sjtu.edu.cn/nix-channels/store"
        ];
        experimental-features = [ "nix-command" "flakes" ];
      };
      nixpkgs.config.allowUnfree = true;
    }

    ###################################################################
    # WSL ONLY when system == "wsl"
    # ###################################################################
    # (nixpkgs.lib.mkIf (system == "wsl") {
    #   imports = inputs.wsl.nixosModules;
    # })

    ###################################################################
    # Host-specific settings
    ###################################################################
    hostConfig
    userOSConfig

    ###################################################################
    # Home-manager integrated as module
    ###################################################################
    homeManagerModules.home-manager {
      home-manager.useGlobalPkgs = true;
      home-manager.useUserPackages = true;
      home-manager.users.ela = import ../users/ela/default.nix;
      home-manager.extraSpecialArgs = {
        system = system;
        roles = roles;
        inputs = inputs;
      };
      home-manager.sharedModules = [
        { home.stateVersion = "25.11"; }
      ];
    }

    ###################################################################
    # Expose custom arguments to **all** modules
    ###################################################################
    {
      config._module.args = {
        currentHost = name;
        system = system;
        roles = roles;
        inputs = inputs;
      };
    }

  ] ++ extraModules;
}
