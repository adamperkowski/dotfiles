{ config, inputs, ... }:

{
  imports = [ inputs.agenix.homeManagerModules.default ];

  age.identityPaths = [ "${config.home.homeDirectory}/.ssh/id_ed25519" ];
}
