return {
	  'stevearc/conform.nvim',
	opts = {},
  event = { "BufWritePre" },
	config = function()
		require("conform").setup({
			-- Map of filetype to formatters
			formatters_by_ft = {
				javascript = { { "prettierd", "prettier" }, "eslint_d" },
				typescript = { { "prettierd", "prettier" }, "eslint_d" },
				javascriptreact = { { "prettierd", "prettier" }, "eslint_d" },
				typescriptreact = { { "prettierd", "prettier" }, "eslint_d" },
				vue = { { "prettierd", "prettier" } },
				markdown = { { "prettierd", "prettier" } },
				css = { { "prettierd", "prettier" } },
				json = { { "prettierd", "prettier" } },
				jsonc = { { "prettierd", "prettier" } },
				scss = { { "prettierd", "prettier" } },
				less = { { "prettierd", "prettier" } },
				yaml = { { "prettierd", "prettier" } },
				graphql = { { "prettierd", "prettier" } },
				html = { { "prettierd", "prettier" } },
        gdscript = { { "gdformat" } },
			},
			format_on_save = {
				lsp_fallback = true,
				timeout_ms = 2000,
			},
			log_level = vim.log.levels.ERROR,
			notify_on_error = true,
		})

		-- You can set formatters_by_ft and formatters directly
    local util = require("conform.util")
    local prettierd = require("conform.formatters.prettierd")
    require("conform").formatters.prettierd = vim.tbl_deep_extend("force", prettierd, {
      args = util.extend_args(prettierd.args, { 
        "--print-width 80", 
        "--indent 2", 
        "--tab-width 2", 
        "--no-semi", 
        "--single-quote", 
        "--jsx-single-quote", 
        "--arrow-parens always", 
        "--prosewrap always", 
        "--end-of-line lf", 
      }),
      range_args = util.extend_args(prettierd.range_args, { 
        "--print-width 80", 
        "--indent 2", 
        "--tab-width 2", 
        "--no-semi", 
        "--single-quote", 
        "--jsx-single-quote", 
        "--arrow-parens always", 
        "--prosewrap always", 
        "--end-of-line lf", 
      }),
    })
	end
}
