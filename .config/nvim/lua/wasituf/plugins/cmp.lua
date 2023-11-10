return {
	'hrsh7th/nvim-cmp',
	dependencies = {
    'L3MON4D3/LuaSnip',
    'onsails/lspkind.nvim',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-path',
    'saadparwaiz1/cmp_luasnip',
    'rafamadriz/friendly-snippets',
    'https://github.com/chrisgrieser/cmp-nerdfont',
    'https://github.com/hrsh7th/cmp-emoji',
  },
	config = function()
    local has_words_before = function()
      unpack = unpack or table.unpack
      local line, col = unpack(vim.api.nvim_win_get_cursor(0))
      return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
    end

		local cmp = require('cmp')
		local lspkind = require('lspkind')
    local luasnip = require('luasnip')

    require("luasnip.loaders.from_vscode").lazy_load()

		cmp.setup({
			completion = {
				completeopt = "menu,menuone,preview,noselect",
			},
			mapping = cmp.mapping.preset.insert({
				["<C-l>"] = cmp.mapping.complete(), -- show completion suggestions
				["<C-;>"] = cmp.mapping.abort(), -- abort completion

        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
            -- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable() 
            -- that way you will only jump inside the snippet region
          elseif luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
          elseif has_words_before() then
            cmp.complete()
          else
            fallback()
          end
        end, { "i", "s" }),

        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { "i", "s" }),

        ["<CR>"] = cmp.mapping({
          i = function(fallback)
            if cmp.visible() and cmp.get_active_entry() then
              cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false })
            else
              fallback()
            end
          end,
          s = cmp.mapping.confirm({ select = true }),
          c = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true }),
        }),
        
			}),
			snippet = {
				expand = function(args)
					luasnip.lsp_expand(args.body)
				end,
			},
			sources = cmp.config.sources({
				{ name = "nvim_lsp", priority = 9 },	
				{ name = "luasnip", priority = 8 },	
        { name = "nerdfont", priority = 7 },
        { name = "emoji", priority = 7 },
        { name = "buffer", priority = 6 },
				{ name = "path", priority = 6 },	
			}),
			formatting = {
        format = lspkind.cmp_format({
          mode = 'symbol_text', 					
          maxwidth = 50, 					
          ellipsis_char = '...', 
        }),
      },
		})
	end
}
