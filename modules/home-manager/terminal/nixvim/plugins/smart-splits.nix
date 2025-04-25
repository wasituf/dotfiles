{ ... }:
{
  programs.nixvim = {
    plugins.smart-splits = {
      enable = true;
      lazyLoad.enable = false;
      settings = {
        default_amount = 2;
        resize_mode = {
          quit_key = "<ESC>";
          resize_keys = [
            "m"
            "n"
            "e"
            "i"
          ];
          slient = true;
        };
      };
    };

    keymaps = [
      # Resizing splits
      {
        action = {
          __raw = ''require('smart-splits').resize_left'';
        };
        key = "<M-M>";
        mode = [
          "n"
          "x"
        ];
        options.desc = "Smart Splits Resize Left";
      }
      {
        action = {
          __raw = ''require('smart-splits').resize_down'';
        };
        key = "<M-N>";
        mode = [
          "n"
          "x"
        ];
        options.desc = "Smart Splits Resize Down";
      }
      {
        action = {
          __raw = ''require('smart-splits').resize_up'';
        };
        key = "<M-E>";
        mode = [
          "n"
          "x"
        ];
        options.desc = "Smart Splits Resize Up";
      }
      {
        action = {
          __raw = ''require('smart-splits').resize_right'';
        };
        key = "<M-I>";
        mode = [
          "n"
          "x"
        ];
        options.desc = "Smart Splits Resize Right";
      }

      # Moving between splits
      {
        action = {
          __raw = ''require('smart-splits').move_cursor_left'';
        };
        key = "<M-m>";
        mode = [
          "n"
          "x"
        ];
        options.desc = "Smart Splits Move Left";
      }
      {
        action = {
          __raw = ''require('smart-splits').move_cursor_down'';
        };
        key = "<M-n>";
        mode = [
          "n"
          "x"
        ];
        options.desc = "Smart Splits Move Down";
      }
      {
        action = {
          __raw = ''require('smart-splits').move_cursor_up'';
        };
        key = "<M-e>";
        mode = [
          "n"
          "x"
        ];
        options.desc = "Smart Splits Move Up";
      }
      {
        action = {
          __raw = ''require('smart-splits').move_cursor_right'';
        };
        key = "<M-i>";
        mode = [
          "n"
          "x"
        ];
        options.desc = "Smart Splits Move Right";
      }
    ];
  };
}
