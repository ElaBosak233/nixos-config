{ lib, ... }:

{
  imports = [
    ./ela.nix
  ];

  home-manager.sharedModules = lib.mkAfter [{
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

    home.sessionPath = [
      "$HOME/.local/bin"
    ];

    home.stateVersion = "25.11";
  }];
}