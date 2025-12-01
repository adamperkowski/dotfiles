{ pkgs }:

pkgs.treefmt.withConfig {
  runtimeInputs = with pkgs; [
    nixfmt-rfc-style
    shfmt
  ];

  settings = {
    on-unmatched = "info";
    tree-root-file = "flake.nix";

    formatter = {
      nixfmt = {
        command = "nixfmt";
        includes = [ "*.nix" ];
      };

      shfmt = {
        command = "shfmt";
        options = [ "-w" ];
        includes = [
          "*.sh"
          "*.bash"
          # "*.zsh" # https://github.com/mvdan/sh/issues/120
        ];
      };
    };
  };
}
