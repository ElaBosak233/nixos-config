{ config, pkgs, ... }: {
  imports = [
    ../../modules/darwin/common.nix

    ../../modules/darwin/programs/shell.nix
  ];

  # This makes it work with the Determinate Nix installer
  ids.gids.nixbld = 30000;

  environment.systemPackages = with pkgs; [];

  # Set in Sept 2024 as part of the macOS Sequoia release.
  system.stateVersion = 5;
}