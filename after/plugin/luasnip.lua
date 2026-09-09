local ls = require("luasnip")

local wk = require("which-key")
wk.add({
	{ "<C-K>", function() ls.expand() end, mode = "i" },
	{ "<C-L>", function() ls.jump(1) end, mode = { "i", "s" } },
	{ "<C-J>", function() ls.jump(-1) end, mode = { "i", "s" } },
	{ "<C-E>", function()
		if ls.choice_active() then
			ls.change_choice(1)
		end
	end, mode = { "i", "s" } },
})

require("luasnip.loaders.from_vscode").lazy_load()
