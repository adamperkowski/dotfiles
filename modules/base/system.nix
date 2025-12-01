{ pkgs, ... }:

{
  system = {
    replaceDependencies.replacements = with pkgs; [
      {
        oldDependency = coreutils-full;
        newDependency = symlinkJoin {
          name =
            "coreuutils-full"
            + builtins.concatStringsSep "" (
              builtins.genList (_: "_") (builtins.stringLength coreutils-full.version)
            );
          paths = [ uutils-coreutils-noprefix ];
        };
      }
      {
        oldDependency = coreutils;
        newDependency = symlinkJoin {
          name =
            "coreuutils"
            + builtins.concatStringsSep "" (
              builtins.genList (_: "_") (builtins.stringLength coreutils.version)
            );
          paths = [ uutils-coreutils-noprefix ];
        };
      }
      {
        oldDependency = findutils;
        newDependency = symlinkJoin {
          name =
            "finduutils"
            + builtins.concatStringsSep "" (
              builtins.genList (_: "_") (builtins.stringLength findutils.version)
            );
          paths = [ uutils-findutils ];
        };
      }
      {
        oldDependency = diffutils;
        newDependency = symlinkJoin {
          name =
            "diffuutils"
            + builtins.concatStringsSep "" (
              builtins.genList (_: "_") (builtins.stringLength diffutils.version)
            );
          paths = [ uutils-diffutils ];
        };
      }
    ];

    stateVersion = "25.11";
  };
}
