{ ... }:
{
  programs.nixvim = {
    plugins.neo-tree = {
      enable = true;
      settings = {
        popup_border_style = "rounded";
        close_if_last_window = true;
        filesystem = {
          bind_to_cwd = false;
          use_libuv_file_watcher = true;
        };
        sources = [
          "filesystem"
          "buffers"
          "git_status"
          "document_symbols"
        ];
        default_component_configs = {
          indent = {
            with_expanders = true;
            expander_collapsed = "";
            expander_expanded = "";
            expander_highlight = "NeoTreeExpander";
          };
          git_status = {
            symbols = {
              unstaged = "󰄱";
              staged = "󰱒";
            };
          };
        };
        window = {
          position = "float";
          width = 50;
          mappings = {
            e = "";
          };
        };
      };
    };
    keymaps = [
      {
        action = {
          __raw = ''
            function()
              require("neo-tree.command").execute({ toggle = true, dir = vim.uv.cwd() })
            end
          '';
        };
        key = "<leader>f.";
        mode = [
          "n"
          "x"
        ];
        options = {
          desc = "NeoTree";
        };
      }
      {
        action = {
          __raw = ''
            function()
              require("neo-tree.command").execute({ source = "buffers", toggle = true })
            end
          '';
        };
        key = "<leader>b.";
        mode = [
          "n"
          "x"
        ];
        options = {
          desc = "Buffers in NeoTree";
        };
      }
      {
        action = {
          __raw = ''
            function()
              require("neo-tree.command").execute({ source = "git_status", toggle = true })
            end
          '';
        };
        key = "<leader>g.";
        mode = [
          "n"
          "x"
        ];
        options = {
          desc = "Git Status in NeoTree";
        };
      }
      {
        action = {
          __raw = ''
            function()
              require("neo-tree.command").execute({ source = "document_symbols", toggle = true,
                position = "right" })
            end
          '';
        };
        key = "<leader>c.";
        mode = [
          "n"
          "x"
        ];
        options = {
          desc = "Symbols in NeoTree";
        };
      }
    ];
  };
}
