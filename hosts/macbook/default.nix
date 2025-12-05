{ config, pkgs, ... }: 

{
  imports = [
    ../../modules/system/base.nix

    ../../modules/programs/shell.nix
  ];

  # This makes it work with the Determinate Nix installer
  ids.gids.nixbld = 30000;

  nix = {
    # We use the determinate-nix installer which manages Nix for us,
    # so we don't want nix-darwin to do it.
    enable = false;

    # Enable the Linux builder so we can run Linux builds on our Mac.
    # This can be debugged by running `sudo ssh linux-builder`
    linux-builder = {
      enable = false;
      ephemeral = true;
      maxJobs = 4;
      config = ({ pkgs, ... }: {
        # Make our builder beefier since we're on a beefy machine.
        virtualisation = {
          cores = 6;
          darwin-builder = {
            diskSize = 100 * 1024; # 100GB
            memorySize = 32 * 1024; # 32GB
          };
        };

        # Add some common debugging tools we can see whats up.
        environment.systemPackages = [
          pkgs.htop
        ];
      });
    };
  };

  environment.systemPackages = with pkgs; [
    cachix
  ];

  # Set in Sept 2024 as part of the macOS Sequoia release.
  system.stateVersion = 5;
}