{ config, ... }:

{
  users.users.root.hashedPassword = config.users.users.koi.hashedPassword;
}
