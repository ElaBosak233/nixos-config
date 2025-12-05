{ lib, system, pkgs, ... }:

{
  imports = [
    ./desktop/gnome.nix
    ./desktop/plasma.nix

    ./dev/go.nix
    ./dev/python.nix
    ./dev/rust.nix

    ./misc/xdg.nix
    ./misc/fonts.nix
  ];

  home.packages = with pkgs; [
    vlc
    google-chrome
    vscode
    github-desktop
    wechat-uos
  ];

  programs.starship.enable = true;
  programs.gpg.enable = true;

  programs.git = {
    enable = true;
    lfs.enable = true;
    settings = {
      user.name = "Ela";
      user.email = "i@e23.dev";

      commit.gpgsign = true;
      user.signingkey = "67FB8DA1";
    };
  };
}
