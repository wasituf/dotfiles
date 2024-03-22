return {
  "Exafunction/codeium.vim",
  event = "BufEnter",
  config = function ()
    -- Change '<C-g>' here to any keycode you like.
    vim.keymap.set("i", "<Tab>", function () return vim.fn["codeium#Accept"]() end, { expr = true, silent = true })
    vim.keymap.set("i", "<C-y>", function() return vim.fn["codeium#CycleCompletions"](1) end, { expr = true, silent = true })
    vim.keymap.set("i", "<C-u>", function() return vim.fn["codeium#CycleCompletions"](-1) end, { expr = true, silent = true })
    vim.keymap.set("i", "<C-;>", function() return vim.fn["codeium#Clear"]() end, { expr = true, silent = true })
    vim.keymap.set("i", "<C-k", function() return vim.fn["codium#Complete"]() end, { expr = true, silent = true })
  end
}
