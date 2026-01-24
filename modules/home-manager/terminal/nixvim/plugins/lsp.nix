{
  lib,
  pkgs,
  inputs,
  ...
}:
{
  programs.nixvim.plugins = {
    lsp = {
      enable = true;
      inlayHints = true;
      keymaps = {
        lspBuf = {
          L = "hover";
        };
      };
      servers = {
        astro.enable = true;
        bashls.enable = true;
        cssls.enable = true;
        docker_compose_language_service.enable = true;
        dockerls.enable = true;
        emmet_ls.enable = true;
        gopls = {
          enable = true;
          settings = {
            gopls = {
              analyses = {
                unusedparams = true;
              };
              staticcheck = true;
              gofumpt = true;
            };
          };
        };
        html.enable = true;
        jsonls.enable = true;
        kotlin_language_server.enable = true;
        lua_ls.enable = true;
        marksman.enable = true;
        nil_ls.enable = true;
        nixd.enable = true;
        nushell.enable = true;
        pylyzer.enable = true;
        racket_langserver = {
          enable = true;
          package = null;
          cmd = [ "racket -l racket-langserver" ];
        };
        rust_analyzer = {
          enable = true;
          installRustc = false;
          installCargo = false;
          settings = {
            checkOnSave = true;
            check = {
              command = "clippy";
            };
          };
        };
        sqls.enable = true;
        svelte.enable = true;
        tailwindcss.enable = true;
        templ.enable = true;
        texlab.enable = true;
        tinymist.enable = true;
        ts_ls.enable = true;
      };
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
          javascript = [
            "biome-check"
          ];
          typescript = [
            "biome-check"
          ];
          javascriptreact = [
            "biome-check"
          ];
          typescriptreact = [
            "biome-check"
          ];
          vue = [
            "biome-check"
          ];
          markdown = [
            "mdformat"
          ];
          kotlin = [
            "ktfmt"
          ];
          tex = [
            "tex-fmt"
          ];
          css = [
            "biome-check"
          ];
          json = [
            "biome-check"
          ];
          jsonc = [
            "biome-check"
          ];
          scss = [
            "biome-check"
          ];
          less = [
            "biome-check"
          ];
          yaml = [
            "biome-check"
          ];
          graphql = [
            "biome-check"
          ];
          html = [
            "biome-check"
          ];
          astro = [
            "biome-check"
          ];
          svelte = [
            "prettierd"
          ];
          lua = [ "stylua" ];
          go = [
            "gofumpt"
            "goimports"
            "golines"
          ];
          nix = [ "nixfmt" ];
          python = [ "black" ];

          "_" = [
            "squeeze_blanks"
            "trim_whitespace"
            "trim_newlines"
          ];
          typst = [ "typstyle" ];
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
        "racket_langserver"
      ];
    };

    # lsp-lines = {
    #   enable = true;
    # };
  };
}
