{ pkgs, iamb, ... }:

{
  programs.iamb = {
    enable = true;
    package = iamb.packages.${pkgs.stdenv.system}.default;

    settings = {
      profiles.user.user_id = "@xx0a_q:matrix.org";
      dirs.downloads = "/tmp/downloads";
      settings = {
        username_display = "displayname";
        notifications.enabled = true;
        image_preview.protocol.type = "kitty";
      };
    };
  };
}
