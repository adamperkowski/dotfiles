{ pkgs, inputs, ... }:

{
  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    kernelParams = [
      "vt.default_red=30,243,166,249,137,245,148,186,88,243,166,249,137,245,148,166"
      "vt.default_grn=30,139,227,226,180,194,226,194,91,139,227,226,180,194,226,173"
      "vt.default_blu=46,168,161,175,250,231,213,222,112,168,161,175,250,231,213,200"
    ];
  };

  networking = {
    networkmanager.enable = true;
    firewall.enable = true;
  };

  console = {
    font = "Lat2-Terminus16";
    useXkbConfig = true;
  };

  users.users.adam = {
    isNormalUser = true;
    shell = pkgs.zsh;
    ignoreShellProgramCheck = true;
    extraGroups = [
      "wheel"
      "jellyfin"
    ];
    packages = with pkgs; [
      pavucontrol
      gh
    ];
  };

  nixpkgs = {
    config.allowUnfree = true;
    overlays = [
      (_: prev: {
        unstable = import inputs.nixpkgs-unstable {
          system = prev.stdenv.hostPlatform.system;
          config = prev.config;
        };
      })
      inputs.niri.overlays.niri
    ];
  };

  environment = {
    localBinInPath = true;
    systemPackages = with pkgs; [
      xwayland-satellite
      htop
    ];
  };

  programs.niri = {
    enable = true;
    package = pkgs.niri-unstable;
  };

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  programs.nano.enable = false;

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
    pinentryPackage = pkgs.pinentry-curses;
  };

  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };

  services.openssh = {
    enable = true;
    openFirewall = true;
    hostKeys = [
      {
        path = "/home/adam/.ssh/id_ed25519";
        type = "ed25519";
      }
    ];
    settings = {
      PasswordAuthentication = false;
      PermitRootLogin = "no";
      PubkeyAuthentication = true;
    };
  };

  nix = {
    package = pkgs.lixPackageSets.stable.lix;

    settings.experimental-features = [
      "nix-command"
      "flakes"
    ];
  };

  system = {
    replaceDependencies.replacements = with pkgs; [
      {
        oldDependency = coreutils-full;
        newDependency = symlinkJoin {
          name =
            "coreuutils-full"
            + builtins.concatStringsSep "" (
              builtins.genList (_: "_") (builtins.stringLength pkgs.coreutils-full.version)
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
              builtins.genList (_: "_") (builtins.stringLength pkgs.coreutils.version)
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
              builtins.genList (_: "_") (builtins.stringLength pkgs.findutils.version)
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
              builtins.genList (_: "_") (builtins.stringLength pkgs.diffutils.version)
            );
          paths = [ uutils-diffutils ];
        };
      }
    ];

    stateVersion = "25.05";
  };
}
