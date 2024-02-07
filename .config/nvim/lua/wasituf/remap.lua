vim.g.mapleader = " "

vim.keymap.set("n", "m", "h", { noremap = true })
vim.keymap.set("n", "n", "j", { noremap = true })
vim.keymap.set("n", "e", "k", { noremap = true })
vim.keymap.set("n", "i", "l", { noremap = true })

vim.keymap.set("n", "M", "H", { noremap = true })
vim.keymap.set("n", "N", "L", { noremap = true })
vim.keymap.set("n", "E", "K", { noremap = true })
vim.keymap.set("n", "I", "L", { noremap = true })

vim.keymap.set("n", "h", "i", { noremap = true })
vim.keymap.set("n", "k", "nzzzv", { noremap = true })
vim.keymap.set("n", "j", "e", { noremap = true })
vim.keymap.set("n", "l", "m", { noremap = true })

vim.keymap.set("n", "H", "I", { noremap = true })
vim.keymap.set("n", "K", "Nzzzv", { noremap = true })
vim.keymap.set("n", "J", "E", { noremap = true })
vim.keymap.set("n", "L", "M", { noremap = true })

vim.keymap.set("v", "m", "h", { noremap = true })
vim.keymap.set("v", "n", "j", { noremap = true })
vim.keymap.set("v", "e", "k", { noremap = true })
vim.keymap.set("v", "i", "l", { noremap = true })

vim.keymap.set("v", "M", "H", { noremap = true })
vim.keymap.set("v", "I", "L", { noremap = true })
vim.keymap.set("v", "N", ":m '>+1<CR>gv=gv", { noremap = true })
vim.keymap.set("v", "E", ":m '<-2<CR>gv=gv", { noremap = true })

vim.keymap.set("v", "h", "i", { noremap = true })
vim.keymap.set("v", "k", "n", { noremap = true })
vim.keymap.set("v", "j", "e", { noremap = true })
vim.keymap.set("v", "l", "m", { noremap = true })

vim.keymap.set("v", "H", "I", { noremap = true })
vim.keymap.set("v", "K", "N", { noremap = true })
vim.keymap.set("v", "J", "E", { noremap = true })
vim.keymap.set("v", "L", "M", { noremap = true })

vim.keymap.set("n", "<C-u>", "<C-d>zz")
vim.keymap.set("n", "<C-y>", "<C-u>zz")

vim.keymap.set("n", "<leader>w", ":w<CR>", { noremap = true, desc = "save" })
vim.keymap.set("n", "<leader>q", ":q<CR>", { noremap = true, desc = "quit" })
vim.keymap.set("n", "<leader>qq", ":q!<CR>", { noremap = true, desc = "quit!" })
vim.keymap.set("n", "<leader>qw", ":wq<CR>", { noremap = true, desc = "save & quit" })

-- greatest remap ever
vim.keymap.set("x", "<leader>p", "\"_dP", { noremap = true, desc = "paste to void" })

-- next greatest remap ever : asbjornHaland
vim.keymap.set({"n", "v"}, "<leader>y", [["+y]], { desc = "copy to clipboard" })
vim.keymap.set("n", "<leader>Y", [["+Y]], { desc = "copy line to clipboard" })

vim.keymap.set({"n", "v"}, "<leader>d", [["_d]], { desc = "delete to void" })

vim.keymap.set("n", "Q", "<nop>")
vim.keymap.set("n", "<C-t>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format, { desc = "format file" })

vim.keymap.set("n", "<C-n>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-e>", "<cmd>cprev<CR>zz")

-- backspace whole word
-- *Doesn't work with with tmux+kitty
-- vim.keymap.set("i", "<C-Backspace>", "<Esc>vbc")
--
-- This could be a temporary solution
vim.keymap.set("i", "<C-o>", "<Esc>vbc")

vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = "replace all" })
vim.keymap.set("n", "<leader>ch", "<cmd>!chmod +x %<CR>", { silent = true, desc = "chmod" })

-- close buffer
vim.keymap.set({"n", "v"}, "<leader>cc", "<cmd>BufferLinePickClose<CR>", { silent = true, desc = "buffer: pick close" })
vim.keymap.set({"n", "v"}, "<leader>ca", "<cmd>BufferLineCloseOthers<CR>", { silent = true, desc = "buffer: close all w/o current" })
vim.keymap.set({"n", "v"}, "<leader>cd", ":bd!<CR>", { silent = true, desc = "buffer: close current" })

-- navigate buffers
vim.keymap.set({"n", "v"}, "<leader>bb", ":BufferLinePick<CR>", { silent = true, desc = "buffer: pick" })
vim.keymap.set({"n", "v"}, "<M-u>", ":bprevious<CR>", { silent = true, desc = "buffer: previous" })
vim.keymap.set({"n", "v"}, "<M-y>", ":bnext<CR>", { silent = true, desc = "buffer: next" })


-- nvim-tree
vim.keymap.set("n", "<leader>p.", "<cmd>NvimTreeToggle<CR>", { desc = "nvim-tree: toggle" })
