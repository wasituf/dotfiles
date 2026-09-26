{
  lib,
  pkgs,
  inputs,
  ...
}:
{
  programs.nixvim.lsp = {
    codelens.enable = false;
    completion.enable = true;
    documentColor.enable = true;
    inlayHints.enable = true;
    inlineCompletion.enable = true;
    linkedEditingRange.enable = true;
    onTypeFormatting.enable = true;
    semanticTokens.enable = true;
    keymaps = [
      {
        key = "L";
        lspBufAction = "hover";
      }
    ];
    servers = {
      "*" = {
        config = {
          capabilities = {
            textDocument = {
              semanticTokens = {
                multilineTokenSupport = true;
              };
            };
          };
          root_markers = [
            ".git"
          ];
        };
      };
      astro = {
        enable = true;
        config = {
          init_options = {
            typescript = {
              tsdk = "${pkgs.typescript_5}/lib/node_modules/typescript/lib";
            };
          };
        };
      };
      bashls.enable = true;
      clangd.enable = true;
      cssls = {
        enable = true;
        config = {
          css = {
            validate = true;
            lint = {
              unknownAtRules = "ignore";
            };
          };
        };
      };
      docker_compose_language_service.enable = true;
      docker_language_server.enable = true;
      emmet_language_server.enable = true;
      gdscript = {
        enable = true;
        package = null;
      };
      gopls = {
        enable = true;
        config = {
          gopls = {
            analyses = {
              unusedparams = true;
            };
            staticcheck = true;
            gofumpt = true;
          };
        };
      };
      jsonls.enable = true;
      lua_ls.enable = true;
      marksman.enable = true;
      nil_ls.enable = true;
      nixd.enable = true;
      racket_langserver = {
        enable = true;
        package = null;
        config = {
          cmd = [ "racket -l racket-langserver" ];
        };
      };
      ruff.enable = true;
      rust_analyzer = {
        enable = true;
        config = {
          checkOnSave = true;
          check = {
            command = "clippy";
          };
        };
      };
      sqruff.enable = true;
      superhtml.enable = true;
      svelte.enable = true;
      tailwindcss = {
        enable = true;
        config = {
          tailwindCSS = {
            lint = {
              invalidApply = false;
            };
          };
        };
      };
      templ.enable = true;
      texlab.enable = true;
      tinymist.enable = true;
      tsc = {
        enable = true;
        package = pkgs.typescript;
      };
      ty.enable = true;
    };
  };
  programs.nixvim.plugins = {
    lspconfig = {
      enable = true;
      package = pkgs.vimPlugins.nvim-lspconfig.overrideAttrs (old: {
        version = "unstable-2026-09-22";
        src = pkgs.fetchFromGitHub {
          owner = "neovim";
          repo = "nvim-lspconfig";
          rev = "ffd261c09c3dabd0bf1a438f47a8ae3b22f3c3ff";
          hash = "sha256-zHc0w8uExt7+5U3YrGT+Eg815htZXtWFOkT2Tm172V4=";
        };
      });
    };

    conform-nvim = {
      enable = true;
      settings = {
        log_level = "warn";
        notify_on_error = true;
        format_on_save = {
          lsp_fallback = true;
          timeout_ms = 2000;
        };
        formatters_by_ft = {
          bash = [ "shfmt" ];
          shell = [ "shfmt" ];
          sh = [ "shfmt" ];
          rust = [ "rustfmt" ];
          javascript = [ "biome-check" ];
          typescript = [ "biome-check" ];
          javascriptreact = [ "biome-check" ];
          typescriptreact = [ "biome-check" ];
          vue = [ "biome-check" ];
          markdown = [ "mdformat" ];
          kotlin = [ "ktfmt" ];
          tex = [ "tex-fmt" ];
          css = [ "biome-check" ];
          c = [ "clang-format" ];
          cpp = [ "clang-format" ];
          json = [ "biome-check" ];
          jsonc = [ "biome-check" ];
          scss = [ "biome-check" ];
          less = [ "biome-check" ];
          yaml = [ "biome-check" ];
          graphql = [ "biome-check" ];
          sql = [ "sqruff" ];
          html = [ "superhtml" ];
          astro = [ "biome-check" ];
          svelte = [ "biome-check" ];
          lua = [ "stylua" ];
          go = [
            "gofumpt"
            "goimports"
            "golines"
          ];
          temple = [ "templ" ];
          nix = [ "nixfmt" ];
          python = [
            "ruff_fix"
            "ruff_format"
            "ruff_organize_imports"
          ];
          typst = [ "typstyle" ];

          "_" = [
            "squeeze_blanks"
            "trim_whitespace"
            "trim_newlines"
          ];
        };
        formatters = {
          shfmt.command = lib.getExe pkgs.shfmt;
          biome-check.command = lib.getExe pkgs.biome;
          black.command = lib.getExe pkgs.black;
          prettierd.command = lib.getExe pkgs.prettierd;
          mdformat = {
            command = lib.getExe (
              pkgs.mdformat.withPlugins (
                ps: with ps; [
                  mdformat-gfm
                  mdformat-frontmatter
                ]
              )
            );
            prepend_args = [
              "--wrap"
              "80"
              "--number"
            ];
          };
          ktfmt = {
            command = lib.getExe pkgs.ktfmt;
            args = [
              "-"
              "--do-not-remove-unused-imports"
              "--google-style"
            ];
          };
          templ = {
            command = lib.getExe pkgs.templ;
            args = [
              "fmt"
              "-stdin-filepath"
              "$FILENAME"
            ];
          };
          typstyle = {
            command = lib.getExe pkgs.typstyle;
            prepend_args = [
              "--line-width"
              "80"
              "--wrap-text"
            ];
          };
          tex-fmt.command = lib.getExe pkgs.tex-fmt;
          stylua.command = lib.getExe pkgs.stylua;
          gofumpt.command = lib.getExe pkgs.gofumpt;
          goimports.command = lib.getExe' pkgs.gotools "goimports";
          golines.command = lib.getExe' pkgs.golines "golines";
          nixfmt.command = lib.getExe pkgs.nixfmt;
          squeeze_blanks.command = lib.getExe' pkgs.coreutils "cat";
        };
      };
    };

    lsp-format = {
      enable = true;
      lspServersToEnable = [
        "gdscript"
        "racket_langserver"
      ];
    };
  };
}
