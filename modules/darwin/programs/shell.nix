{ config, pkgs, lib, ... }:

{
  users.defaultUserShell = pkgs.fish;
  programs.fish.enable = true;
  environment.shells = lib.mkAfter [ pkgs.fish ];

  programs.fish.shellInit = ''
    # Nix
    if test -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.fish'
      source '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.fish'
    end
    # End Nix
    '';
}