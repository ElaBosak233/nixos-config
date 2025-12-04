{ config, pkgs, lib, ... }:

{
  virtualisation.docker = {
    enable = true;
    autoPrune = {
      enable = true;
      dates = "weekly";
    };

    daemon.settings = {
      "registry-mirrors" = [
        "https://docker.1ms.run"
      ];
      "log-driver" = "json-file";
      "log-opts" = {
        "max-size" = "10m";
        "max-file" = "3";
      };
      features = {
        buildkit = true;
      };
    };
  };
}