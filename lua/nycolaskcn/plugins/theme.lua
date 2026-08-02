-- local utils = require("nycolaskcn.utils")

vim.pack.add({
	{ src = "https://github.com/bluz71/vim-moonfly-colors" },
})

vim.g.moonflyCursorColor = true
vim.g.moonflyTerminalColors = true
vim.g.moonflyTransparent = true
vim.g.moonflyWinSeparator = 2
vim.g.moonflyItalics = false
vim.o.winborder = "single"
local moonfly = require("moonfly")

-- utils.log:write(moonfly.palette)
moonfly.custom_colors({
	grey0 = "#2C313D",
	grey1 = "#373E4D",
	grey11 = "#1A1D23",
	grey13 = "#1C1F26",
	grey15 = "#20242C",
	grey16 = "#222630",
	grey18 = "#272B35",
	grey23 = "#313643",
	grey27 = "#39404F",
	grey30 = "#42495A",
	grey35 = "#4A5266",
	grey39 = "#525C72",
	grey50 = "#6C7894",
	grey58 = "#838DA5",
	grey62 = "#8E98AE",
	grey7 = "#0F1115",
	grey70 = "#A6ADBE",
	grey89 = "#E0E2E8",
})
vim.cmd("colorscheme moonfly")
