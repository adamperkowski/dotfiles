{
  imports = [
    ./hardware-configuration.nix
  ];

  networking.hostName = "laptop";

  time.timeZone = "Europe/Warsaw";
  i18n.defaultLocale = "en_US.UTF-8";
  console.keyMap = "pl";
}
