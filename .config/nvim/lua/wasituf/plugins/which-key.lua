return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  lazy = true,
  init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 500
  end,
  opts = {
    triggers_blacklist = {
      n = { 'v', 'vi', 'vl', 'vk', 'vj', 'vh', 'vm', 'vn', 've' },
      v = { 'i', 'k', 'l', 'j', 'h', 'm', 'n', 'e' }
    }
  }
}
