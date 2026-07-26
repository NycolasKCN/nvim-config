vim.g.mapleader = " "
vim.g.maploacalleader = "\\"
vim.g.vimtex_view_method = "zathura"

local opt = vim.opt
opt.signcolumn = "yes:1"
opt.tabstop = 2
opt.softtabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.autoindent = false
opt.linebreak = true
opt.breakindent = true
opt.smartindent = true
opt.smarttab = true

opt.number = true
opt.relativenumber = true
opt.cursorline = true
opt.scrolloff = 8

opt.hlsearch = true
opt.incsearch = true
opt.ignorecase = true
opt.smartcase = true

opt.undodir = os.getenv("HOME") .. "/.config/nvim/undodir"
opt.undofile = false
opt.clipboard = "unnamedplus"

opt.termguicolors = false
opt.background = "dark"
opt.guifont = "JetBrainsMono NFM:h16"

