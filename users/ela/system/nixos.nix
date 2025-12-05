{ config, pkgs, inputs, lib, system, ... }:

lib.mkIf (system == "nixos") {
  users.users.ela = {
    isNormalUser = true;
    description = "Ela";
    home = "/home/ela";
    extraGroups = [ "docker" "lxd" "wheel" "networkmanager" ];
    initialPassword = "ela";
  };
}
