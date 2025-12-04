{ lib, ... }:

{
  imports = [
    ./go.nix
    ./python.nix
    ./rust.nix
  ];
}