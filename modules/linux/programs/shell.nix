{ config, pkgs, lib, ... }:

{
  users.defaultUserShell = pkgs.fish;
  programs.fish.enable = true;
  environment.shells = lib.mkAfter [ pkgs.fish ];

  # Link /share/fish from packages into /run/current-system/sw
  # Ensures fish can load completions from installed programs
  environment.pathsToLink = lib.mkAfter [ "/share/fish" ];
}