{ config, pkgs, ... }:

{
  services.k3s = {
    enable = true;

    role = "server";

    disable = [ "traefik" ];

    extraFlags = [
      "--write-kubeconfig-mode=644"
    ];
  };

  environment.etc."rancher/k3s/registries.yaml".text = ''
    mirrors:
      docker.io:
        endpoint:
          - "https://docker.m.daocloud.io"
          - "https://docker.sunzishaokao.com"
          - "https://run-docker.cn"
          - "https://docker.hlmirror.com"
          - "https://ccr.ccs.tencentyun.com"
          - "https://dhub.kubesre.xyz"
      registry.k8s.io:
        endpoint:
          - "https://k8s.m.daocloud.io"
      ghcr.io:
        endpoint:
          - "https://ghcr.nju.edu.cn"
          - "https://ghcr.linkos.org"
  '';
}
