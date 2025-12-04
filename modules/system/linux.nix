{ config, pkgs, lib, ... }:

{
  # Enable networking
  networking.networkmanager.enable = true;

  environment.localBinInPath = true;

  time.timeZone = "Asia/Shanghai";

  programs.clash-verge.enable = true;
  programs.clash-verge.serviceMode = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; lib.mkAfter [
    vlc
    google-chrome
    vscode
    github-desktop
  ];
}