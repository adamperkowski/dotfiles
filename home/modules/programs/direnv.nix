{ pkgs, ... }:

{
  programs.direnv = {
    enable = true;
    silent = true;
    enableZshIntegration = true;

    nix-direnv = {
      enable = true;
      package = pkgs.nix-direnv.override { nix = pkgs.lixPackageSets.stable.lix; };
    };

    stdlib = ''
      : ''${XDG_CACHE_HOME:=$HOME/.cache}
      declare -A direnv_layout_dirs

      direnv_layout_dir() {
        echo "''${direnv_layout_dirs[$PWD]:=$(
          echo -n "$XDG_CACHE_HOME"/direnv/layouts/
          echo -n "$PWD" | sha1sum | cut -d ' ' -f 1
        )}"
      }
    '';
  };
}
