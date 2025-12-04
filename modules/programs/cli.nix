{ config, pkgs, lib, ... }:

{
  environment.systemPackages = with pkgs; lib.mkAfter [
    wget
    git
    tree
    ripgrep
  ];
}