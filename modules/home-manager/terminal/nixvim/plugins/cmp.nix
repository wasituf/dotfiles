{ ... }:
{
  programs.nixvim.plugins = {
    cmp = {
      enable = false;
      autoEnableSources = true;
      settings = {
        performance = {
          debounce = 0;
          throttle = 0;
        };
        completeion = {
          completeopt = "menu,menuone,preview,noselect";
        };
        mapping = {
          "<C-Space>" = "cmp.mapping.complete()";
          "<C-l>" = "cmp.mapping.confirm()";
          "<C-;>" = "cmp.mapping.close()";
          "<C-n>" = "cmp.mapping(cmp.mapping.select_next_item(), { 'i', 's' })";
          "<C-e>" = "cmp.mapping(cmp.mapping.select_prev_item(), { 'i', 's' })";
          "<C-u>" = "cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 's' })";
          "<C-y>" = "cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 's' })";
        };
        snippet.expand = ''
          function(args)
            local luasnip = require("luasnip")
            luasnip.lsp_expand(args.body)
          end
        '';
        sources = [
          { name = "nvim_lsp"; }
          { name = "nvim_lsp_signature_help"; }
          { name = "luasnip"; }
          { name = "async_path"; }
          { name = "emoji"; }
          { name = "nerdfont"; }
          { name = "latex_symbols"; }
          { name = "buffer"; }
        ];
        window = {
          completion = {
            __raw = ''
              cmp.config.window.bordered()
            '';
          };
          documentation = {
            __raw = ''
              cmp.config.window.bordered()
            '';
          };
        };
      };
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
