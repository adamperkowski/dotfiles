{ pkgs, inputs, ... }:

{
  programs.iamb = {
    enable = true;
    package = inputs.iamb.packages.${pkgs.stdenv.system}.default;

    settings = {
      profiles.user.user_id = "@adam:matrix.system72.dev";
      dirs.downloads = "/tmp/downloads";
      settings = {
        username_display = "displayname";
        notifications.enabled = true;
        image_preview.protocol.type = "kitty";
      };
    };
  };
}
