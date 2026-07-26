vim.pack.add({
	{ src = "https://github.com/stevearc/conform.nvim.git" },
})

local conform = require("conform")
conform.setup({
	formatters_by_ft = {
		javascript = { "prettier" },
		typescript = { "prettier" },
		javascriptreact = { "prettier" },
		typescriptreact = { "prettier" },
		css = { "prettier" },
		html = { "prettier" },
		json = { "prettier" },
		yaml = { "prettier" },
		markdown = { "prettier" },
		graphql = { "prettier" },
		svelte = { "prettier" },
	},
	-- format_on_save = {
	--   lsp_fallback = true,
	--   async = false,
	--   timeout_ms = 1000,
	-- },
})

vim.keymap.set("n", "<leader>l", function()
	conform.format({
		lsp_fallback = true,
		async = false,
		timeout_ms = 1000,
	})
end, { desc = "Format buffer (conform)" })
