{ config, ... }:

{
  programs.iamb = {
    enable = true;

    settings = {
      profiles.user.user_id = "@koi:system72.dev";
      dirs.downloads = config.xdg.userDirs.download;
      settings = {
        user_gutter_width = 20;
        username_display = "displayname";
        typing_notice_send = false;
        notifications.enabled = true;
        image_preview.protocol.type = "sixel";
        layout.style = "restore";
        sort.rooms = [
          "favorite"
          "recent"
          "unread"
          "name"
        ];
      };
    };
  };
}
