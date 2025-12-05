{ config, pkgs, lib, system, ... }:

lib.mkMerge [
  (lib.mkIf (system == "nixos") {
    # Enable networking
    networking.networkmanager.enable = true;

    environment.localBinInPath = true;

    time.timeZone = "Asia/Shanghai";

    # List packages installed in system profile.
    environment.systemPackages = with pkgs; lib.mkAfter [];

    # keep fewer generations
    boot.loader.systemd-boot.configurationLimit = 10;
    # If you use GRUB instead:
    # boot.loader.grub.configurationLimit = 10;

    # do garbage collection weekly to keep disk usage low
    nix.gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };

    # optimise the store automatically
    nix.settings.auto-optimise-store = true;
  })

  (lib.mkIf (system == "darwin") {
    nix.gc = {
      automatic = true;
      dates = "weekly";
    };
  })
]
