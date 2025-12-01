{ config, ... }:

{
  users.users.root.hashedPassword = config.users.users.adam.hashedPassword;
}
