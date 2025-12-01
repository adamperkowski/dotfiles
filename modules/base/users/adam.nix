{
  users.users.adam = {
    isNormalUser = true;
    hashedPassword = "$y$j9T$kpXvXU/Ftx9qI9LKssnpY/$mGPO35iEUCb8/.bdYA/Zys3MuIaNSlrnUY2S6wCoFD8";
    ignoreShellProgramCheck = true;
    extraGroups = [
      "wheel"
      "jellyfin"
    ];
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAID9feAlrIVPuVS28tz54/m7pZkjHHL5aVhV2qwBPPceT adam"
    ];
  };
}
