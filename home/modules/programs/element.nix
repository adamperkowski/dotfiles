{ pkgs, ... }:

{
  home.packages = with pkgs; [
    sqlcipher
  ];

  programs.element-desktop = {
    enable = true;
    settings = {
      default_server_config = {
        "m.homeserver" = {
          base_url = "https://matrix.org";
          server_name = "matrix.org";
        };
        "m.identity_server" = {
          base_url = "https://vector.im";
        };
      };
      disable_custom_urls = true;
      disable_guests = true;
      disable_login_language_selector = true;
      disable_3pid_login = false;
      force_verification = true;
      brand = "Element";
      integrations_ui_url = "https://scalar.vector.im/";
      integrations_rest_url = "https://scalar.vector.im/api";
      integrations_widgets_urls = [
        "https://scalar.vector.im/_matrix/integrations/v1"
        "https://scalar.vector.im/api"
        "https://scalar-staging.vector.im/_matrix/integrations/v1"
        "https://scalar-staging.vector.im/api"
      ];
      show_labs_settings = true;
      features = { };
      default_federate = true;
      default_theme = "catppuccin";
      room_directory.servers = [ "matrix.org" ];
      setting_defaults.breadcrumbs = true;
      jitsi.preferred_domain = "meet.element.io";
      element_call = {
        url = "https://call.element.io";
        participant_limit = 8;
        brand = "Element Call";
      };
      map_style_url = "https://api.maptiler.com/maps/streets/style.json?key=fU3vlMsMn4Jb6dnEIFsx";

      custom_themes = [
        {
          name = "catppuccin";
          is_dark = true;
          colors = {
            accent-color = "#b4befe";
            primary-background-color = "#b4befe";
            warning-color = "#eba0ac";
            alert = "#f9e2af";
            sidebar-color = "#11111b";
            roomlist-background-color = "#181825";
            roomlist-text-color = "#cdd6f4";
            roomlist-text-secondary-color = "#9399b2";
            roomlist-highlights-color = "#45475a";
            roomlist-separator-color = "#7f849c";
            timeline-background-color = "#1e1e2e";
            timeline-text-color = "#cdd6f4";
            secondary-content = "#cdd6f4";
            tertiary-content = "#cdd6f4";
            timeline-text-secondary-color = "#a6adc8";
            timeline-highlights-color = "#181825";
            reaction-row-button-selected-bg-color = "#45475a";
            menu-selected-color = "#45475a";
            focus-bg-color = "#585b70";
            room-highlight-color = "#cba6f7";
            togglesw-off-color = "#9399b2";
            other-user-pill-bg-color = "#cba6f7";
            username-colors = [
              "#b4befe"
              "#74c7ec"
              "#89dceb"
              "#94e2d5"
              "#a6e3a1"
              "#fab387"
              "#eba0ac"
              "#cba6f7"
            ];
          };
        }
      ];
    };
  };
}
