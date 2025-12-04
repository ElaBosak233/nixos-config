{ config, pkgs, lib, ... }:

{
  nix = {
    settings = {
      substituters = [ "https://mirror.sjtu.edu.cn/nix-channels/store" ];
      experimental-features = [ "nix-command" "flakes" ];
    };
  };

  nixpkgs.config.allowUnfree = true;
}