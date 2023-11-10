return {
  "nvim-telescope/telescope.nvim", branch = "0.1.x",
  dependencies = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope-fzf-native.nvim", "nvim-tree/nvim-web-devicons" },
  config = function() 
    require('telescope').setup{
      defaults = {
        mappings = {
          i = {
            ["<C-e>"] = "move_selection_previous",
	    ["<esc>"] = "close"
          }
        }
      }
    }  

    local builtin = require('telescope.builtin')
    vim.keymap.set('n', '<leader>pf', builtin.find_files, {})
    vim.keymap.set('n', '<C-p>', builtin.git_files, {})
    vim.keymap.set('n', '<leader>ps', function()
    builtin.grep_string({ search = vim.fn.input("Grep > ") })
    end)
  end,
}
