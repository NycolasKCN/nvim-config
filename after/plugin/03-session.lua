local persistence = require("persistence")

vim.api.nvim_create_autocmd("BufReadPre", {
	once = true,
	callback = function()
		persistence.setup()
	end,
})

local wk = require("which-key")

wk.add({
	{ "<leader>q", group = "Session/Persistence" },
	{
		"<leader>qs",
		function()
			persistence.load()
		end,
		desc = "Load session (cwd)",
		mode = "n",
	},
	{
		"<leader>qS",
		function()
			persistence.select()
		end,
		desc = "Select session",
		mode = "n",
	},
	{
		"<leader>ql",
		function()
			persistence.load({ last = true })
		end,
		desc = "Load last session",
		mode = "n",
	},
	{
		"<leader>qd",
		function()
			persistence.stop()
		end,
		desc = "Stop Persistence",
		mode = "n",
	},
})
