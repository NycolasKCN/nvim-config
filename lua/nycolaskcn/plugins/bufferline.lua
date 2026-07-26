vim.pack.add({
	{ src = "https://github.com/akinsho/bufferline.nvim" },
})

_G.__cached_neo_tree_selector = nil
_G.__get_selector = function()
	return _G.__cached_neo_tree_selector
end

require("bufferline").setup({
	options = {
		diagnostics = "nvim_lsp",
		mode = "buffers",
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
				raw = " %{%v:lua.__get_selector()%} ",
				highlight = { sep = { link = "WinSeparator" } },
				separator = "┃",
			},
		},
	},
})

-- Keymaps
local keymap = vim.keymap.set

keymap("n", "<leader>bp", "<Cmd>BufferLineTogglePin<CR>", { desc = "Toggle Pin" })
keymap("n", "<leader>bP", "<Cmd>BufferLineGroupClose ungrouped<CR>", { desc = "Delete Non-Pinned Buffers" })
keymap("n", "<leader>bl", "<Cmd>BufferLineCloseRight<CR>", { desc = "Delete Buffers to the Right" })
keymap("n", "<leader>bh", "<Cmd>BufferLineCloseLeft<CR>", { desc = "Delete Buffers to the Left" })
keymap("n", "<leader>bq", "<Cmd>b#<CR>:bd #<CR>", { desc = "Delete current Buffer and jump to previous" })
keymap("n", "<S-TAB>", "<Cmd>BufferLineCyclePrev<CR>", { desc = "Prev Buffer" })
keymap("n", "<TAB>", "<Cmd>BufferLineCycleNext<CR>", { desc = "Next Buffer" })
keymap("n", "<leader>bmb", "<Cmd>BufferLineMovePrev<CR>", { desc = "Move buffer prev" })
keymap("n", "<leader>bmf", "<Cmd>BufferLineMoveNext<CR>", { desc = "Move buffer next" })
keymap("n", "<leader>bj", "<Cmd>BufferLinePick<CR>", { desc = "Pick Buffer" })

-- Fix bufferline when restoring a session
vim.api.nvim_create_autocmd({ "BufAdd", "BufDelete" }, {
	callback = function()
		vim.schedule(function()
			pcall(vim.cmd, "redrawtabline")
		end)
	end,
})
