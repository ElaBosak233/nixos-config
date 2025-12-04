{ config, pkgs, lib, ... }:

{
  programs.git.enable = true;

  environment.systemPackages = with pkgs; lib.mkAfter [
    wget
    tree
    ripgrep
  ];
}