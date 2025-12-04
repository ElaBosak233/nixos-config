{ config, pkgs, ... }:

{
  fonts = {
    fontDir.enable = true;

    packages = with pkgs; [
      fira-code
      jetbrains-mono
      wqy_zenhei
    ];
  };
}