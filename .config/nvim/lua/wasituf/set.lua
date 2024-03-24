vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.wrap = true
vim.opt.textwidth = 100
vim.opt.linebreak = true
vim.opt.breakindent = true

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

-- Decrease update time
vim.opt.updatetime = 50

-- Decrease mapped sequence wait time
-- Displays which-key popup sooner
vim.opt.timeoutlen = 300

vim.opt.colorcolumn = "80"

vim.showtabline = 0

-- Nerd Font
vim.g.have_nerd_font = true

-- Show mode in cmdline
vim.opt.showmode = false

-- Case insensitive searching
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Markdown Preview
vim.g.mkdp_auto_start = 0
vim.g.mkdp_browser = "chromium"
vim.g.mkdp_theme = "dark"
