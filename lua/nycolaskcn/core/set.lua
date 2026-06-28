vim.g.mapleader = " "
vim.g.maploacalleader = "\\"

vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.autoindent = false
vim.opt.linebreak = true
vim.opt.breakindent = true
vim.opt.smartindent = true
vim.opt.smarttab = true

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.scrolloff = 8

vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.undodir = os.getenv("HOME") .. "/.config/nvim/undodir"
vim.opt.undofile = true
vim.opt.clipboard = "unnamedplus"

vim.opt.termguicolors = false
vim.opt.background = "dark"
vim.opt.guifont = "JetBrainsMono NFM:h16"

