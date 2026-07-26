local treesitter = require("nvim-treesitter")

treesitter.setup({
	install_dir = vim.fn.stdpath("data") .. "/site",
	highlight = {
		enable = true,
    disable = { "neo-tree", "notify" },
	},
	-- enable indentation
	indent = { enable = true },
	folds = { enable = false },
	-- ensure these language parsers are installed
	ensure_installed = {
		"json",
		"javascript",
		"typescript",
		"tsx",
		"yaml",
		"html",
		"css",
		"markdown",
		"markdown_inline",
		"bash",
		"lua",
		"vim",
		"dockerfile",
		"gitignore",
		"query",
		"vimdoc",
		"c",
		"java",
		"kotlin",
		"python",
		"qml",
	},
	incremental_selection = {
		enable = true,
		keymaps = {
			init_selection = "<C-space>",
			node_incremental = "<C-space>",
			scope_incremental = false,
			node_decremental = "<bs>",
		},
	},
})

vim.treesitter.language.register("bash", "zsh")

vim.api.nvim_create_autocmd("PackChanged", {
	callback = function(ev)
		local name, kind = ev.data.spec.name, ev.data.kind
		if name == "nvim-treesitter" and kind == "update" then
			if not ev.data.active then
				vim.cmd.packadd("nvim-treesitter")
			end
			vim.cmd("TSUpdate")
		end
	end,
})

-- vim.api.nvim_create_autocmd("FileType", {
-- 	desc = "Enable Treesitter features",
-- 	callback = function(args)
-- 		local buf = args.buf
--
-- 		-- Ensure the parser is available before starting
-- 		local lang = vim.bo[buf].filetype
--
-- 		if pcall(vim.treesitter.language.add, lang) then
-- 			-- Enable modern syntax highlighting
-- 			vim.treesitter.start(buf)
--
-- 			-- Enable treesitter-based indentation
-- 			vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
-- 		end
-- 	end,
-- })
