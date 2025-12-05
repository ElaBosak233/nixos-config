{ lib, config, pkgs, ... }:

{
  options.python.extraPackages = lib.mkOption {
    type = lib.types.functionTo (lib.types.listOf lib.types.package);
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
    home.packages = with pkgs; lib.mkAfter [
      uv
      (python3.withPackages (ps: config.python.extraPackages ps))
    ];
  };
}
