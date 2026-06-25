{ ... }:
{
  programs.nixvim.plugins = {
    cmp = {
      enable = false;
      autoEnableSources = false;
    };

    blink-cmp = {
      enable = true;
      settings = {
        appearance = {
          nerd_font_variant = "mono";
        };
        completion = {
          documentation = {
            auto_show = true;
            auto_show_delay_ms = 200;
            # window = {
            #   border = "rounded";
            # };
          };
          ghost_text.enabled = false;
          menu = {
            # border = "rounded";
            scrolloff = 0;
            scrollbar = true;
            draw = {
              treesitter = {
                __raw = ''{ "lsp" },'';
              };
            };
          };
        };
        signature = {
          enabled = true;
          # window = {
          #   border = "rounded";
          # };
        };
        sources = {
          default = [
            "lsp"
            "snippets"
            "path"
            "emoji"
            "buffer"
          ];
          providers = {
            emoji = {
              module = "blink-emoji";
              name = "Emoji";
            };
            latex_symbols = {
              name = "latex_symbols";
              module = "blink.compat.source";
            };
          };
        };
        snippets = {
          preset = "luasnip";
        };
        keymap = {
          "<C-y>" = [
            "scroll_documentation_up"
            "fallback"
          ];
          "<C-u>" = [
            "scroll_documentation_down"
            "fallback"
          ];
          "<C-n>" = [
            "select_next"
            "fallback"
          ];
          "<C-e>" = [
            "select_prev"
            "fallback"
          ];
          "<C-o>" = [
            "show"
            "show_documentation"
            "hide_documentation"
            "fallback"
          ];
          "<C-l>" = [
            "show"
            "select_and_accept"
          ];
          "<Down>" = [
            "select_next"
            "fallback"
          ];
          "<Up>" = [
            "select_prev"
            "fallback"
          ];
        };
      };
    };

    blink-compat.enable = true;
    cmp-latex-symbols.enable = true;
    blink-emoji.enable = true;
    friendly-snippets.enable = true;

    luasnip = {
      enable = true;
      fromVscode = [
        {
          lazyLoad = true;
        }
      ];
      filetypeExtend = {
        astro = [
          "js"
          "ts"
          "css"
          "html"
        ];
        nix = [
          "bash"
          "fish"
          "lua"
        ];
      };
    };
  };
}
