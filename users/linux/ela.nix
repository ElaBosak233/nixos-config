{ config, pkgs, inputs, ... }:

{
  users.users.ela = {
    isNormalUser = true;
    description = "Ela";
    home = "/home/ela";
    extraGroups = [ "docker" "lxd" "wheel" "networkmanager" ];
  };

  home-manager.users.ela = { config, pkgs, ... }: {

    home.stateVersion = "25.11";

    home.packages = with pkgs; [
      vlc
      google-chrome
      vscode
      clash-verge-rev
      github-desktop
    ];

    home.file.".gnupg/pubkey-ela.asc".text = ''
      -----BEGIN PGP PUBLIC KEY BLOCK-----

      mDMEaBCipxYJKwYBBAHaRw8BAQdA1EKymTap5e7kp1GDunMBAvNunYgaD5ytlk/A
      M8RiD9u0D0VsYSA8aUBlMjMuZGV2PoiTBBMWCgA7FiEELqrEhYn+xNJ8PkKi5mMk
      m2f7jaEFAmgQoqcCGwMFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgkQ5mMk
      m2f7jaGdkwD/bgnEd4hnD/oB0VYYKhU+bUCMp5I2t5Bnnd+HIq4AvrUBAMUJcf/D
      T6eU4HeRpizoqDKD3BigFg0KAqtI6DASxTsOuDgEaBCipxIKKwYBBAGXVQEFAQEH
      QK1vsyot3tFSY0k+RoGaorVXh3aSMT5YETz+wMQq7JAmAwEIB4h4BBgWCgAgFiEE
      LqrEhYn+xNJ8PkKi5mMkm2f7jaEFAmgQoqcCGwwACgkQ5mMkm2f7jaGOXQEAmO4d
      22pSdCjp8KWZhMytrsJhE5Aeknt9lL1RiW8+W8cBAOQkX4xi1CjYv9vc0ezwJYX4
      BUfpu+suS07YZgJ0rXAE
      =Jp8S
      -----END PGP PUBLIC KEY BLOCK-----
    '';

    programs.gpg = {
      enable = true;
      publicKeys = [
        {
          source = "${config.home.homeDirectory}/.gnupg/pubkey-ela.asc";
          trust = "ultimate";
        }
      ];
    };

    programs.starship.enable = true;

    programs.git = {
      enable = true;
      settings = {
        user.name = "Ela";
        user.email = "i@e23.dev";

        commit.gpgsign = true;
        user.signingkey = "67FB8DA1";
      };
    };

    programs.vscode = {
      enable = true;
      profiles.default.extensions = with pkgs.vscode-extensions; [
        ms-python.python
        rust-lang.rust-analyzer
      ];
    };

    home.sessionPath = [
      "$HOME/.local/bin"
    ];
  };
}
