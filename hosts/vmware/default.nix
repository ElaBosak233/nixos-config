# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [
      ../../modules/system/linux.nix

      ../../modules/desktop/gnome.nix
      ../../modules/desktop/audio.nix

      ../../modules/services/docker.nix
      ../../modules/services/k3s.nix

      ../../modules/programs/dev
      ../../modules/programs/clash.nix
      ../../modules/programs/fonts.nix
      ../../modules/programs/cli.nix
      ../../modules/programs/shell.nix

      ../../users/linux

      ./i18n.nix
      ./hardware.nix
    ];

  # Bootloader.
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda";
  boot.loader.grub.useOSProber = true;

  networking.hostName = "vmware"; # Define your hostname.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "cn";
    variant = "";
  };
  
  services.xserver.videoDrivers = [ "vmware" ];
  virtualisation.vmware.guest.enable = true;

  security.sudo.wheelNeedsPassword = false;

  environment.systemPackages = with pkgs; lib.mkAfter [];

  services.openssh.enable = true;
  networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.11"; # Did you read the comment?

}
