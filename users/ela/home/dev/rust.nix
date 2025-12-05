{ config, pkgs, lib, ... }:

{
  home.packages = with pkgs; lib.mkAfter [
    rust-bin.nightly.latest.default
    rust-analyzer
  ];
}