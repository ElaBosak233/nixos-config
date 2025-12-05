{ config, pkgs, lib, system, ... }:

lib.mkMerge [
  (lib.mkIf (system == "nixos") {
    users.defaultUserShell = pkgs.fish;
    programs.fish.enable = true;
    environment.shells = lib.mkAfter [ pkgs.fish ];
    environment.pathsToLink = lib.mkAfter [ "/share/fish" ];
  })

  (lib.mkIf (system == "darwin") {
    programs.fish.enable = true;
    users.defaultUserShell = pkgs.fish;
    environment.shells = lib.mkAfter [ pkgs.fish ];
  })
]
