{ config, pkgs, inputs, ... }:

{
  users.users.ela = {
    isNormalUser = true;
    description = "Ela";
    home = "/home/ela";
    extraGroups = [ "docker" "lxd" "wheel" "networkmanager" ];
  };

  home-manager.users.ela = { config, pkgs, ... }: {
    fonts = {
      fontconfig = {
        enable = true;
        defaultFonts = {
          monospace = [ "FiraCode" ];
        };
      };
    };

    home.packages = with pkgs; [
      vlc
      google-chrome
      vscode
      github-desktop
    ];

    programs.starship.enable = true;
    programs.gpg.enable = true;

    programs.git = {
      enable = true;
      settings = {
        user.name = "Ela";
        user.email = "i@e23.dev";

        commit.gpgsign = true;
        user.signingkey = "67FB8DA1";
      };
    };
  };
}
