{ config, lib, pkgs, ... }:

lib.mkIf (config.services.desktopManager.plasma6.enable or false) {
  home.packages = with pkgs; lib.mkAfter [
    kdePackages.kate
  ];
}