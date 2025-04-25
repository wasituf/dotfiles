{ ... }:
{
  programs.nixvim = {
    plugins.neo-tree = {
      enable = true;
      closeIfLastWindow = true;
      popupBorderStyle = "rounded";
      # useDefaultMappings = false;
      filesystem = {
        bindToCwd = false;
        useLibuvFileWatcher = true;
      };
      defaultComponentConfigs = {
        indent = {
          withExpanders = true;
          expanderCollapsed = "";
          expanderExpanded = "";
          expanderHighlight = "NeoTreeExpander";
        };
        gitStatus = {
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
      sources = [
        "filesystem"
        "buffers"
        "git_status"
        "document_symbols"
      ];
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
