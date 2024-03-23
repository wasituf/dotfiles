return {
  "Exafunction/codeium.vim",
  event = "BufEnter",
  config = function ()
    -- Disable default bindings
    vim.g.codeium_disable_bindings = 1

    -- Keybindings.
    vim.keymap.set("i", "<Tab>", function () return vim.fn["codeium#Accept"]() end, { expr = true, silent = true })
    vim.keymap.set("i", "<C-y>", function() return vim.fn["codeium#CycleCompletions"](1) end, { expr = true, silent = true })
    vim.keymap.set("i", "<C-u>", function() return vim.fn["codeium#CycleCompletions"](-1) end, { expr = true, silent = true })
    vim.keymap.set("i", "<C-;>", function() return vim.fn["codeium#Clear"]() end, { expr = true, silent = true })
    vim.keymap.set("i", "<C-k", function() return vim.fn["codium#Complete"]() end, { expr = true, silent = true })
    vim.keymap.set("n", "<leader>o", function() return vim.fn["codeium#Chat"]() end, { expr = true, silent = true })
  end
}
