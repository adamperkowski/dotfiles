{ pkgs }:

pkgs.treefmt.withConfig {
  runtimeInputs = with pkgs; [
    nixfmt-rfc-style
    js-beautify
    shfmt
    kdePackages.qtdeclarative
  ];

  settings = {
    on-unmatched = "info";
    tree-root-file = "flake.nix";

    formatter = {
      nixfmt = {
        command = "nixfmt";
        includes = [ "*.nix" ];
      };

      js-beautify = {
        command = "js-beautify";
        options = [
          "--replace"
          "--editorconfig"
          "--jslint-happy"
          "--max-preserve-newlines"
          "2"
        ];
        includes = [
          "*.js"
          "*.mjs"
          "*.css"
        ];
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

      qmlformat = {
        command = "qmlformat";
        options = [
          "--inplace"
          "--sort-imports"
          "--indent-width"
          "2"
        ];
        includes = [ "*.qml" ];
      };
    };
  };
}
