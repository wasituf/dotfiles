return {
  "folke/todo-comments.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  opts = {
  },
  config = function()
    require("todo-comments").setup()
    vim.keymap.set("n", "<leader>ta", "<cmd>TodoTrouble<CR>", { silent = true, desc = "open all todos in trouble"})
    vim.keymap.set("n", "<leader>ts", "<cmd>TodoTrouble cwd=./src<CR>", { silent = true, desc = "open todos from ./src trouble"})
    vim.keymap.set("n", "<leader>tA", "<cmd>TodoTelescope<CR>", { silent = true, desc = "open all todos in telescope"})
    vim.keymap.set("n", "<leader>tS", "<cmd>TodoTelescope cwd=./src<CR>", { silent = true, desc = "open todos from ./src telescope"})
  end
}
