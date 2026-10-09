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
opt.linebreak = false
opt.wrap = false
opt.breakindent = true
opt.smartindent = true
opt.smarttab = true

opt.number = true
opt.relativenumber = true
opt.cursorline = true
opt.colorcolumn = "80"
opt.scrolloff = 8

opt.splitright = true
opt.splitbelow = true

opt.hlsearch = true
opt.incsearch = true
opt.ignorecase = true
opt.smartcase = true

opt.undodir = os.getenv("HOME") .. "/.cache/nvim/undo"
opt.undofile = true
opt.clipboard = "unnamedplus"

opt.termguicolors = false
opt.background = "dark"
opt.guifont = "JetBrainsMono NFM:h14"

