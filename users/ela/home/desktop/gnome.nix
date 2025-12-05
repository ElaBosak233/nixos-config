{ config, lib, pkgs, ... }:

lib.mkIf (config.services.desktopManager.gnome.enable or false) {
  dconf.settings = {
    "org/gnome/shell" = {
      enabled-extensions = [
        "dash-to-dock@micxgx.gmail.com"
        "blur-my-shell@aunetx"
        "just-perfection@just-perfection"
      ];
    };
  };
}