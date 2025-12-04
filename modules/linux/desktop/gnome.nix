{ config, pkgs, lib, ... }:

{
  # Enable the X11 windowing system.
  services.xserver.enable = true;
  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;
  programs.dconf.enable = true;
  xdg.portal.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gnome ];
  environment.gnome.excludePackages = with pkgs; [
    epiphany
    geary
    gnome-maps
    gnome-contacts
    gnome-weather
    gnome-tour
    yelp
  ];

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; lib.mkAfter [
    gnomeExtensions.dash-to-dock
    gnomeExtensions.blur-my-shell
    gnomeExtensions.just-perfection
    gnome-extension-manager
    refine
  ];

  home-manager.sharedModules = lib.mkAfter [{
    dconf.settings = {
      "org/gnome/shell" = {
        enabled-extensions = [
          "dash-to-dock@micxgx.gmail.com"
          "blur-my-shell@aunetx"
          "just-perfection@just-perfection"
        ];
      };
    };
  }];
}