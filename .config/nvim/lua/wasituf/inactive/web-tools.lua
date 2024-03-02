return {
  'https://github.com/ray-x/web-tools.nvim',
  lazy = true,
  event = { 'BufEnter *.html', 'BufEnter *.htmx' },
  config = function()
    require('web-tools').setup()

    vim.keymap.set("n", "<leader>bx", ":BrowserStop<CR>")
    vim.keymap.set("n", "<leader>bs", ":BrowserPreview<CR>")
  end
}
