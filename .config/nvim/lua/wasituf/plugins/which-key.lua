return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  lazy = true,
  init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 500
  end,
  opts = {
    preset = "helix",
  },
}
