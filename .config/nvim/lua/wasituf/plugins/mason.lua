return {
  "williamboman/mason.nvim",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
  },
  lazy = false,
  config = function()
    local mason = require("mason")
    local mason_lspconfig = require("mason-lspconfig")

    local lsp_zero = require('lsp-zero')

    mason.setup({
      ui = {
        icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
        }
      }
    })

    mason_lspconfig.setup({
      -- list of servers for mason to install
      ensure_installed = {
        "tsserver",
        -- "custom_elements_ls",
        "html",
        "cssls",
        "tailwindcss",
        "svelte",
        "graphql",
        "gopls",
        "emmet_ls",
        "eslint",
      },
      -- auto-install configured servers (with lspconfig)
      automatic_installation = true, -- not the same as ensure_installed
      handlers = {
        lsp_zero.default_setup,
      }
    })
  end,
}
