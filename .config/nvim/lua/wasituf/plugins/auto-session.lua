return {
  'rmagatti/auto-session',
  config = function()
    require("auto-session").setup({
      log_level = "error",
      session_lens = {
        path_display={'shorten'},
        theme = 'dropdown',
        theme_conf = { border = true },
        prompt_title = 'SESSIONS',
      },
    })
    vim.keymap.set("n", "<C-s>", require("auto-session.session-lens").search_session, { noremap = true, })
  end
}
