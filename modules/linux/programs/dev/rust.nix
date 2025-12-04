{ config, pkgs, lib, ... }:

{
  environment.systemPackages = with pkgs; lib.mkAfter [
    rust-bin.nightly.latest.default
    rust-analyzer
  ];
}