{
  lib,
  config,
  user,
  ...
}:
with lib;
let
  cfg = config.modules.terminal.programs.superfile;
in
{
  options.modules.terminal.programs.superfile = {
    enable = mkEnableOption "superfile";
    theme = mkOption {
      type = types.enum [
        "rose-pine"
        "catppuccin"
        "gruvbox"
      ];
      default = "rose-pine";
      description = "Theme to use for superfile";
    };
  };

  config = mkIf cfg.enable {
    programs.superfile = {
      enable = true;
      firstUseCheck = false;
      pinnedFolders = [
        {
          name = "Downloads";
          location = "/home/${user}/Downloads";
        }
        {
          name = "Netflix";
          location = "/media/Netflix";
        }
        {
          name = "Media";
          location = "/media";
        }
        {
          name = "USB";
          location = "/USB";
        }
      ];
      settings = {
        theme = "rose-pine";
        dir_editor = "nvim";
        auto_check_update = false;
        code_previewer = "bat";
        transparent_background = true;
        metadata = true;
        zoxide_support = true;
      };
      hotkeys = {
        confirm = [
          "enter"
          "right"
          "i"
        ];
        quit = [
          "q"
          "esc"
        ];
        cd_quit = [
          "Q"
          ""
        ];
        # movement;
        list_up = [
          "up"
          "e"
        ];
        list_down = [
          "down"
          "n"
        ];
        page_up = [
          "ctrl+y"
          ""
        ];
        page_down = [
          "ctrl+u"
          ""
        ];
        # file panel control;
        create_new_file_panel = [
          "h"
          ""
        ];
        close_file_panel = [
          "w"
          ""
        ];
        next_file_panel = [
          "tab"
          "alt+i"
          "I"
        ];
        previous_file_panel = [
          "shift+tab"
          "alt+m"
          "M"
        ];
        toggle_file_preview_panel = [
          "f"
          ""
        ];
        open_sort_options_menu = [
          "o"
          ""
        ];
        toggle_reverse_sort = [
          "R"
          ""
        ];
        # change focus;
        focus_on_process_bar = [
          "j"
          ""
        ];
        focus_on_sidebar = [
          "s"
          ""
        ];
        focus_on_metadata = [
          "l"
          ""
        ];
        # create file/directory and rename;
        file_panel_item_create = [
          "a"
          ""
        ];
        file_panel_item_rename = [
          "r"
          ""
        ];
        # file operations;
        copy_items = [
          "ctrl+c"
          "c"
        ];
        cut_items = [
          "ctrl+x"
          "x"
        ];
        paste_items = [
          "ctrl+v"
          "p"
        ];
        delete_items = [
          "ctrl+d"
          "delete"
          "d"
        ];
        permanently_delete_items = [
          "D"
          ""
        ];
        # compress and extract;
        extract_file = [
          "ctrl+e"
          ""
        ];
        compress_file = [
          "ctrl+a"
          ""
        ];
        # editor;
        open_file_with_editor = [
          "k"
          ""
        ];
        open_current_directory_with_editor = [
          "K"
          ""
        ];
        # other;
        pinned_directory = [
          "P"
          ""
        ];
        toggle_dot_file = [
          "."
          ""
        ];
        change_panel_mode = [
          "v"
          ""
        ];
        open_help_menu = [
          "?"
          ""
        ];
        open_command_line = [
          ":"
          ""
        ];
        open_spf_prompt = [
          ">"
          ""
        ];
        open_zoxide = [
          "z"
          ""
        ];
        copy_path = [
          "ctrl+p"
          ""
        ];
        copy_present_working_directory = [
          "ctrl+c"
          ""
        ];
        toggle_footer = [
          "F"
          ""
        ];
        # =================================================================================================;
        # Typing hotkeys (can conflict with all hotkeys);
        confirm_typing = [
          "enter"
          ""
        ];
        cancel_typing = [
          "ctrl+c"
          "esc"
        ];
        # =================================================================================================;
        # Normal mode hotkeys (can conflict with other modes  cannot conflict with global hotkeys);
        parent_directory = [
          "m"
          "left"
          "backspace"
        ];
        search_bar = [
          "/"
          ""
        ];
        # =================================================================================================;
        # Select mode hotkeys (can conflict with other modes  cannot conflict with global hotkeys);
        file_panel_select_mode_items_select_down = [
          "shift+down"
          "N"
        ];
        file_panel_select_mode_items_select_up = [
          "shift+up"
          "E"
        ];
        file_panel_select_all_items = [
          "shift+v"
          "A"
        ];
      };
    };
  };
}
