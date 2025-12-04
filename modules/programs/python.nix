{ lib, config, pkgs, ... }:

with lib;

{
  options.python.extraPackages = mkOption {
    type = types.functionTo (types.listOf types.package);
    default = ps: with ps; [
      pycryptodome
      pwntools
      flask
      requests
    ];
    description = ''
      A function ps: [...] that returns extra Python packages.
    '';
  };

  config = {
    environment.systemPackages = lib.mkAfter [
      (pkgs.python3.withPackages (ps: config.python.extraPackages ps))
    ];
  };
}
