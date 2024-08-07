-- AUGROUPS
local au_folds = vim.api.nvim_create_augroup("folds", {clear = true})
local au_format = vim.api.nvim_create_augroup("format", {clear = true})
local au_quirks = vim.api.nvim_create_augroup("quirks", {clear = true})

-- AUTOCMD: folds
vim.api.nvim_create_autocmd("BufWinLeave",{
    pattern = "*",
    command = "if expand('%:p') != '' | mkview | endif",
    group = folds
})
vim.api.nvim_create_autocmd("BufWinEnter",{
    pattern = "*",
    command = "silent! loadview",
    group = folds
})

-- AUTOCMD: go
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.go",
  group = format,
  callback = function()
    local params = vim.lsp.util.make_range_params()
    params.context = {only = {"source.organizeImports"}}
    -- buf_request_sync defaults to a 1000ms timeout. Depending on your
    -- machine and codebase, you may want longer. Add an additional
    -- argument after params if you find that you have to write the file
    -- twice for changes to be saved.
    -- E.g., vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, 3000)
    local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, 2000)
    for cid, res in pairs(result or {}) do
      for _, r in pairs(res.result or {}) do
        if r.edit then
          local enc = (vim.lsp.get_client_by_id(cid) or {}).offset_encoding or "utf-16"
          vim.lsp.util.apply_workspace_edit(r.edit, enc)
        end
      end
    end
    vim.lsp.buf.format({async = false})
  end
})

-- AUTOCMD: conform
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "\\.go$",
  group = format,
  callback = function()
    require("conform").format({ bufnr = vim.api.nvim_get_current_buf() })
  end,
})

-- AUTOCMD: tailwind-tools
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = { "*.astro", "*.svelte", "*.html", "*.css", "*.js", "*.ts", "*.jsx", "*.tsx", "*.php", "*.vue" },
  group = format,
  command = "silent! TailwindSort | redraw!",
})

-- AUTOCMD: exit insert mode on bufenter/insertenter
vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "*",
  group = quirks,
  callback = function()
    if vim.fn.mode() == "i" then
      vim.cmd("stopinsert")
    end
  end
})
