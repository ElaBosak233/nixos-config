{ config, pkgs, inputs, lib, system, ... }:

lib.mkIf (system == "nixos") {
  fonts = {
    fontconfig = {
      enable = true;
      defaultFonts = {
        monospace = [ "FiraCode" ];
      };
    };
  };
}
