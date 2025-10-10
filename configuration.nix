{ config, lib, pkgs, ... }:

{
  imports = [ ./hardware.nix ];

  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
  };

  networking = {
    hostName = "nixos";
    networkmanager.enable = true;
    firewall.enable = true;
  };

  time.timeZone = "Europe/Warsaw";

  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "pl";
    useXkbConfig = false;
  };

  users.users.adam = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    packages = with pkgs; [ chromium gh ];
  };

  environment.systemPackages = with pkgs; [ htop ];

  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
    pinentryPackage = pkgs.pinentry-curses;
  };

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  system.stateVersion = "25.05";
}
