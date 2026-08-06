require("mini.indentscope").setup({
	symbol = "▏",
	-- symbol = "│",
	options = { try_as_border = true },
	draw = {
		-- Delay (in ms) between event and start of drawing scope indicator
		delay = 20,

		-- Symbol priority. Increase to display on top of more symbols.
		priority = 2,
	},
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = {
		"Trouble",
		"alpha",
		"dashboard",
		"fzf",
		"help",
		"lazy",
		"mason",
		"neo-tree",
		"notify",
		"sidekick_terminal",
		"snacks_dashboard",
		"snacks_notif",
		"snacks_terminal",
		"snacks_win",
		"toggleterm",
		"trouble",
	},
	callback = function()
		vim.b.miniindentscope_disable = true
	end,
})

vim.api.nvim_create_autocmd("User", {
	pattern = "SnacksDashboardOpened",
	callback = function(data)
		vim.b[data.buf].miniindentscope_disable = true
	end,
})

require("mini.surround").setup({
	-- Custom surroundings to be used on top of builtin ones.
	-- For more information with examples, see `:h MiniSurround.config`.
	custom_surroundings = {},

	-- Duration (in ms) of highlight when calling `MiniSurround.highlight()`
	highlight_duration = 500,

	-- Module mappings. Use `''` (empty string) to disable one.
	mappings = {
		add = "sa", -- Add surrounding in Normal and Visual modes
		delete = "sd", -- Delete surrounding
		find = "sf", -- Find surrounding (to the right)
		find_left = "sF", -- Find surrounding (to the left)
		highlight = "sh", -- Highlight surrounding
		replace = "sr", -- Replace surrounding

		suffix_last = "l", -- Suffix to search with "prev" method
		suffix_next = "n", -- Suffix to search with "next" method
	},

	-- Number of lines within which surrounding is searched
	n_lines = 20,

	-- Whether to respect selection type:
	-- - Place surroundings on separate lines in linewise mode.
	-- - Place surroundings on each line in blockwise mode.
	respect_selection_type = false,

	-- How to search for surrounding (first inside current line, then inside
	-- neighborhood). One of 'cover', 'cover_or_next', 'cover_or_prev',
	-- 'cover_or_nearest', 'next', 'prev', 'nearest'. For more details,
	-- see `:h MiniSurround.config`.
	search_method = "cover",

	-- Whether to disable showing non-error feedback
	-- This also affects (purely informational) helper messages shown after
	-- idle time if user input is required.
	silent = false,
})

require("mini.notify").setup({
	-- Content management
	content = {
		-- Function which formats the notification message
		-- By default prepends message with notification time
		format = nil,

		-- Function which orders notification array from most to least important
		-- By default orders first by level and then by update timestamp
		sort = nil,
	},

	-- Notifications about LSP progress
	lsp_progress = {
		-- Whether to enable showing
		enable = false,

		-- Notification level
		level = "ERROR",

		-- Duration (in ms) of how long last message should be shown
		duration_last = 1000,
	},

	-- Window options
	window = {
		-- Floating window config
		config = {},

		-- Maximum window width as share (between 0 and 1) of available columns
		max_width_share = 0.382,

		-- Value of 'winblend' option
		winblend = 30,
	},
})

require("mini.move").setup({
	-- Module mappings. Use `''` (empty string) to disable one.
	mappings = {
		-- Move visual selection in Visual mode. Defaults are Alt (Meta) + hjkl.
		left = "<M-h>",
		right = "<M-l>",
		down = "<M-j>",
		up = "<M-k>",

		-- Move current line in Normal mode
		line_left = "<M-h>",
		line_right = "<M-l>",
		line_down = "<M-j>",
		line_up = "<M-k>",
	},

	-- Options which control moving behavior
	options = {
		-- Automatically reindent selection during linewise vertical move
		reindent_linewise = true,
	},
})

require("mini.indentscope").setup({
	-- symbol = "▏",
	symbol = "│",
	options = { try_as_border = true },
	draw = {
		-- Delay (in ms) between event and start of drawing scope indicator
		delay = 60,

		-- Symbol priority. Increase to display on top of more symbols.
		priority = 2,
	},
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = {
		"Trouble",
		"alpha",
		"dashboard",
		"fzf",
		"help",
		"lazy",
		"mason",
		"neo-tree",
		"notify",
		"sidekick_terminal",
		"snacks_dashboard",
		"snacks_notif",
		"snacks_terminal",
		"snacks_win",
		"toggleterm",
		"trouble",
	},
	callback = function()
		vim.b.miniindentscope_disable = true
	end,
})

vim.api.nvim_create_autocmd("User", {
	pattern = "SnacksDashboardOpened",
	callback = function(data)
		vim.b[data.buf].miniindentscope_disable = true
	end,
})

require("mini.pairs").setup({
})
