{
  pkgs,
  ...
}:

{
  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
  };

  networking = {
    networkmanager.enable = true;
    firewall.enable = true;
  };

  console = {
    font = "Lat2-Terminus16";
    useXkbConfig = false;
  };

  users.users.adam = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    packages = with pkgs; [
      gh
      spotify
    ];
  };

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [ htop ];

  programs.nano.enable = false;

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

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  system.stateVersion = "25.05";
}
