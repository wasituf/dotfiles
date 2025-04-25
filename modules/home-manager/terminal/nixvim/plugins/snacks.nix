{ ... }:
{
  programs.nixvim = {
    plugins = {
      snacks = {
        enable = true;
        lazyLoad.settings.events = "UIEnter";
        settings = {
          bufdelete = {
            enabled = true;
          };
          dim = {
            enabled = true;
          };
          indent = {
            enabled = true;
            indent = {
              char = "┃";
            };
            scope = {
              char = "┃";
            };
            chunk = {
              enabled = false;
              char = {
                corner_top = "╭";
                corner_bottom = "╰";
                arrow = "─";
              };
            };
          };
          input = {
            enabled = true;
          };
          image = {
            enabled = true;
          };
          notifier = {
            enabled = true;
          };
          # TODO: replace fzf-lua with picker when snacks package is updated in nixpkgs
          # picker = {
          #   enabled = true;
          # };
          scroll = {
            enabled = true;
          };
          statuscolumn = {
            enabled = true;
          };
          toggle = {
            enabled = true;
          };
          words = {
            enabled = true;
          };
          zen = {
            enabled = true;
          };
        };
      };
    };

    keymaps = [
      {
        action = {
          __raw = ''function() Snacks.zen() end'';
        };
        key = "<leader>tz";
        options = {
          desc = "Toggle Zen Mode";
        };
      }
      {
        action = {
          __raw = ''function() Snacks.zen.zoom() end'';
        };
        key = "<leader>tZ";
        options = {
          desc = "Toggle Zoom Mode";
        };
      }
      {
        action = {
          __raw = ''function() Snacks.notifier.show_history() end'';
        };
        key = "<leader>nh";
        options = {
          desc = "Notification History";
        };
      }
      {
        action = {
          __raw = ''function() Snacks.notifier.hide() end'';
        };
        key = "<leader>nd";
        options = {
          desc = "Dismiss All Notification";
        };
      }
      {
        action = {
          __raw = ''function() Snacks.bufdelete() end'';
        };
        key = "<leader>bd";
        options = {
          desc = "Delete Buffer";
        };
      }
      {
        action = {
          __raw = ''function() Snacks.words.jump(vim.v.count1) end'';
        };
        key = "]]";
        options = {
          desc = "Next Reference";
        };
      }
      {
        action = {
          __raw = ''function() Snacks.words.jump(-vim.v.count1) end'';
        };
        key = "[[";
        options = {
          desc = "Previous Reference";
        };
      }
    ];
    autoCmd = [
      {
        callback = {
          __raw = ''
            function()
              -- Setup some globals for debugging (lazy-loaded)
              _G.dd = function(...)
                Snacks.debug.inspect(...)
              end
              _G.bt = function()
                Snacks.debug.backtrace()
              end
              vim.print = _G.dd -- Override print to use snacks for `:=` command

              -- Create some toggle mappings
              -- Snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>tw")
              Snacks.toggle.option("relativenumber", { name = "Relative Number" }):map("<leader>tL")
              Snacks.toggle.diagnostics():map("<leader>td")
              Snacks.toggle.line_number():map("<leader>tl")
              -- Snacks.toggle.option("conceallevel", { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 }):map("<leader>tc")
              -- Snacks.toggle.treesitter():map("<leader>tT")
              Snacks.toggle.option("background", { off = "dark", on = "light", name = "Light Mode" }):map("<leader>tb")
              -- Snacks.toggle.inlay_hints():map("<leader>th")
              Snacks.toggle.indent():map("<leader>tg")
              Snacks.toggle.dim():map("<leader>tD")
            end
          '';
        };
        pattern = [ "*" ];
        event = [ "VimEnter" ];
      }
    ];
  };
}
