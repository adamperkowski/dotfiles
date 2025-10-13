{ config, lib, pkgs, ... }:

{
  imports = [ ./hardware.nix ];

  boot = {
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

  nixpkgs.config.allowUnfree = true;

  users.users.adam = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    packages = with pkgs; [
      gh
      spotify
    ];
  };

  environment.systemPackages = with pkgs; [ htop ];

  hardware.graphics.enable = true;
  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = true;
    open = true;
    nvidiaSettings = false;
  };

  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };

  programs.nano.enable = false;

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
    pinentryPackage = pkgs.pinentry-curses;
  };

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  programs.steam = {
    enable = true;
    extraCompatPackages = with pkgs; [ proton-ge-bin ];
    remotePlay.openFirewall = true;
  };

  programs.gamemode.enable = true;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  system.stateVersion = "25.05";
}
