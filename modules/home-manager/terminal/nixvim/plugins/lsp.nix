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
      # capabilities = '''';
      # onAttach = '''';
      # preConfig = '''';
      keymaps = {
        lspBuf = {
          L = "hover";
        };
      };
      servers = {
        astro.enable = true;
        bashls.enable = true;
        # biome.enable = true;
        cssls.enable = true;
        # css_variables.enable = true;
        # denols.enable = true;
        docker_compose_language_service.enable = true;
        dockerls.enable = true;
        emmet_ls.enable = true;
        # eslint.enable = true;
        # fish_lsp.enable = true;
        # gdscript.enable = true;
        # gdshader_lsp.enable = true;
        # gleam.enable = true;
        # glsl_analyzer.enable = true;
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
        # guile_ls.enable = true;
        html.enable = true;
        # htmx.enable = true;
        jsonls.enable = true;
        lua_ls.enable = true;
        marksman.enable = true;
        # mdx_analyzer.enable = true;
        nil_ls.enable = true;
        nixd.enable = true;
        nushell.enable = true;
        # prismals.enable = true;
        pylyzer.enable = true;
        racket_langserver = {
          enable = true;
          package = null;
          cmd = [ "racket -l racket-langserver" ];
        };
        rust_analyzer = {
          enable = true;
          installCargo = true;
          installRustc = true;
        };
        sqls.enable = true;
        svelte.enable = true;
        tailwindcss.enable = true;
        templ.enable = true;
        texlab.enable = true;
        ts_ls.enable = true;
        # unocss = true;
        # vala_ls.enable = true;
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
            "prettierd"
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
            "tailwind_sort"
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
        };
        formatters = {
          shfmt.command = lib.getExe pkgs.shfmt;
          rustfmt.command = lib.getExe pkgs.rustfmt;
          biome-check.command = lib.getExe pkgs.biome;
          black.command = lib.getExe pkgs.black;
          prettierd.command = lib.getExe pkgs.prettierd;
          # prettier.command = lib.getExe pkgs.nodePackages_latest.prettier;
          ktfmt = {
            command = lib.getExe pkgs.ktfmt;
            args = [
              "-"
              "--do-not-remove-unused-imports"
              "--google-style"
            ];
          };
          tex-fmt.command = lib.getExe pkgs.tex-fmt;
          stylua.command = lib.getExe pkgs.stylua;
          gofumpt.command = lib.getExe pkgs.gofumpt;
          goimports.command = lib.getExe' pkgs.gotools "goimports";
          golines.command = lib.getExe' pkgs.golines "golines";
          nixfmt.command = lib.getExe pkgs.nixfmt-rfc-style;
          squeeze_blanks.command = lib.getExe' pkgs.coreutils "cat";
          tailwind_sort.command = {
            __raw = ''function() return vim.cmd("TailwindSort") end'';
          };
        };
      };
    };

    lsp-format = {
      enable = true;
      lspServersToEnable = [ "racket_langserver" ];
    };

    # lsp-lines = {
    #   enable = true;
    # };
  };
}
