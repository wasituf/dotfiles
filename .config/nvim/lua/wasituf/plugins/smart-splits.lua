return {
  'mrjones2014/smart-splits.nvim',
  config = function()
    require('smart-splits').setup({
      default_amount = 2,
      resize_mode = {
        resize_keys = { 'm', 'n', 'e', 'i' }
      }
    })

    -- recommended mappings
    -- resizing splits
    -- these keymaps will also accept a range,
    -- for example `10<A-h>` will `resize_left` by `(10 * config.default_amount)`
    vim.keymap.set('n', '<A-M>', require('smart-splits').resize_left)
    vim.keymap.set('n', '<A-N>', require('smart-splits').resize_down)
    vim.keymap.set('n', '<A-E>', require('smart-splits').resize_up)
    vim.keymap.set('n', '<A-I>', require('smart-splits').resize_right)
    -- moving between splits
    vim.keymap.set('n', '<A-m>', require('smart-splits').move_cursor_left)
    vim.keymap.set('n', '<A-n>', require('smart-splits').move_cursor_down)
    vim.keymap.set('n', '<A-e>', require('smart-splits').move_cursor_up)
    vim.keymap.set('n', '<A-i>', require('smart-splits').move_cursor_right)
    -- swapping buffers between windows
    vim.keymap.set('n', '<leader><leader>m', require('smart-splits').swap_buf_left)
    vim.keymap.set('n', '<leader><leader>n', require('smart-splits').swap_buf_down)
    vim.keymap.set('n', '<leader><leader>e', require('smart-splits').swap_buf_up)
    vim.keymap.set('n', '<leader><leader>i', require('smart-splits').swap_buf_right)
  end
}
