-- neotree integration (dont wok)
-- _G.__cached_neo_tree_selector = nil
-- _G.__get_selector = function()
-- 	return _G.__cached_neo_tree_selector
-- end
--
require("bufferline").setup({
	options = {
		diagnostics = "nvim_lsp",
		mode = "buffers",
		numbers = "ordinal",
		separator_style = "slant",
		always_show_bufferline = true,
		enforce_regular_tabs = true,
		auto_toggle_bufferline = true,
		offsets = {
			{
				filetype = "NvimTree",
				text = "File Explorer",
				text_align = "left",
				separator = "┃",
			},
			{
				filetype = "neo-tree",
				text = "File Explorer",
				text_align = "center",
				separator = "┃",
			},
		},
	},
})

-- Keymaps
local wk = require("which-key")
wk.add({
	{ "<leader>b", group = "Buffer" },
	{ "<leader>bp", "<Cmd>BufferLineTogglePin<CR>", desc = "Toggle Pin", mode = "n" },
	{ "<leader>bP", "<Cmd>BufferLineGroupClose ungrouped<CR>", desc = "Delete Non-Pinned Buffers", mode = "n" },
	{ "<leader>bc", "<Cmd>BufferLineCloseOthers<CR>", desc = "Delete othter Buffers", mode = "n" },
	{ "<leader>bl", "<Cmd>BufferLineCloseRight<CR>", desc = "Delete Buffers to the Right", mode = "n" },
	{ "<leader>bh", "<Cmd>BufferLineCloseLeft<CR>", desc = "Delete Buffers to the Left", mode = "n" },
	{ "<leader>bq", "<Cmd>b#<CR>:bd #<CR>", desc = "Delete current Buffer and jump to previous", mode = "n" },
	{ "<leader>bmb", "<Cmd>BufferLineMovePrev<CR>", desc = "Move buffer prev", mode = "n" },
	{ "<leader>bmf", "<Cmd>BufferLineMoveNext<CR>", desc = "Move buffer next", mode = "n" },
	{ "<leader>bj", "<Cmd>BufferLinePick<CR>", desc = "Pick Buffer", mode = "n" },
	{ "<S-TAB>", "<Cmd>BufferLineCyclePrev<CR>", desc = "Prev Buffer", mode = "n" },
	{ "<TAB>", "<Cmd>BufferLineCycleNext<CR>", desc = "Next Buffer", mode = "n" },
})

-- Fix bufferline when restoring a session
vim.api.nvim_create_autocmd({ "BufAdd", "BufDelete" }, {
	callback = function()
		vim.schedule(function()
			pcall(vim.cmd, "redrawtabline")
		end)
	end,
})
