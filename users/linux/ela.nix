{ config, pkgs, inputs, ... }:

{
  users.users.ela = {
    isNormalUser = true;
    description = "Ela";
    home = "/home/ela";
    extraGroups = [ "docker" "lxd" "wheel" "networkmanager" ];
  };

  home-manager.users.ela = { config, pkgs, ... }: {
    xdg.userDirs = {
      enable = true;
      createDirectories = true;

      desktop = "Desktop";
      documents = "Documents";
      download = "Downloads";
      music = "Music";
      pictures = "Pictures";
      videos = "Videos";
      templates = "Templates";
      publicShare = "Public";
    };

    xdg.configFile."user-dirs.dirs".force = true;

    dconf.settings = {
      "org/gnome/shell" = {
        enabled-extensions = [
          "dash-to-dock@micxgx.gmail.com"
          "blur-my-shell@aunetx"
          "just-perfection@just-perfection"
        ];
      };
    };

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
      clash-verge-rev
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

    home.sessionPath = [
      "$HOME/.local/bin"
    ];

    home.stateVersion = "25.11";
  };
}
