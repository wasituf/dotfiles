{ ... }:
{
  programs.nixvim.plugins = {
    which-key = {
      enable = true;
      lazyLoad.settings.event = "UIEnter";
      settings = {
        delay = 150;
        preset = "helix";
        win = {
          border = "rounded";
          wo.winblend = 25;
        };
        spec = [
          {
            __unkeyed-1 = "<leader><tab>";
            group = "tabs";
            icon = "󰓩 ";
          }
          {
            __unkeyed-1 = "<leader>b";
            group = "buffers";
            icon = {
              icon = " ";
              color = "orange";
            };
            expand = {
              __raw = ''
                function()
                  return require("which-key.extras").expand.buf()
                end
              '';
            };
          }
          {
            __unkeyed-1 = "<leader>c";
            group = "code";
            icon = {
              icon = " ";
              color = "blue";
            };
          }
          {
            __unkeyed-1 = "<leader>e";
            group = "eval";
            icon = {
              icon = "󰨯 ";
              color = "red";
            };
          }
          {
            __unkeyed-1 = "<leader>f";
            group = "file/find";
            icon = {
              icon = "󰈔 ";
              color = "blue";
            };
          }
          {
            __unkeyed-1 = "<leader>g";
            group = "git";
            icon = {
              icon = "󰘬 ";
              color = "purple";
            };
          }
          {
            __unkeyed-1 = "<leader>n";
            group = "notifications";
            icon = {
              icon = " ";
              color = "pink";
            };
          }
          {
            __unkeyed-1 = "<leader>s";
            group = "search";
            icon = {
              icon = " ";
              color = "green";
            };
          }
          {
            __unkeyed-1 = "<leader>t";
            group = "toggle";
            icon = {
              icon = " ";
              color = "yellow";
            };
          }
          {
            __unkeyed-1 = "<leader>w";
            group = "window";
            icon = {
              icon = " ";
              color = "red";
            };
            proxy = "<C-w>";
            expand = {
              __raw = ''
                function()
                  return require("which-key.extras").expand.win()
                end
              '';
            };
          }
          {
            __unkeyed-1 = "<leader>x";
            group = "trouble";
            icon = {
              icon = "󱖫 ";
              color = "green";
            };
          }
          {
            __unkeyed-1 = "[";
            group = "prev";
          }
          {
            __unkeyed-1 = "]";
            group = "next";
          }
          {
            __unkeyed-1 = "g";
            group = "goto";
          }
          {
            __unkeyed-1 = "gs";
            group = "surround";
          }
          {
            __unkeyed-1 = "z";
            group = "fold";
          }
        ];
      };
    };
  };
}
