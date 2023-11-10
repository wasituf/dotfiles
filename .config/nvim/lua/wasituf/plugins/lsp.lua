return {
	'VonHeikemen/lsp-zero.nvim', 
	branch = 'v3.x',
  dependencies = { "neovim/nvim-lspconfig", "hrsh7th/cmp-nvim-lsp" },
	lazy = true,
	config = function()
		local lsp_zero = require('lsp-zero')
		lsp_zero.extend_lspconfig()

    local lspconfig = require('lspconfig')
    local navic = require("nvim-navic")

		lsp_zero.on_attach(function(client, bufnr)
			-- see :help lsp-zero-keybindings
			-- to learn the available actions
			lsp_zero.default_keymaps({ buffer = bufnr })
      local opts = { buffer = bufnr, noremap = true }

      if client.server_capabilities.documentSymbolProvider then
       navic.attach(client, bufnr)
      end

      -- vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
      vim.keymap.set("n", "L", function() vim.lsp.buf.hover() end, opts)
		end)

    lspconfig.gopls.setup({
      settings = {
        gopls = {
          analyses = {
            unusedparams = true,
          },
          staticcheck = true,
          gofumpt = true,
        },
      },
    })

    lspconfig.gdscript.setup{
      on_attach = function(client, bufnr)
        navic.attach(client, bufnr)
      end,
      flags = {
        debounce_text_changes = 150,
      }
    }

		lsp_zero.setup()
	end
}
