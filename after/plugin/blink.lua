local cmp = require("blink.cmp")
cmp.build():pwait()

cmp.setup({
	fuzzy = { implementation = "prefer_rust_with_warning" },
	signature = { enabled = true },
	keymap = {
		preset = "default",
		["<C-space>"] = { "show" },
		["<C-p>"] = {},
		["<Tab>"] = { "select_and_accept", "fallback" },
		["<S-Tab>"] = {},
		["<C-K>"] = { "show", "show_documentation", "hide_documentation" },
		["<CR>"] = { "select_and_accept", "fallback" },
		["<C-k>"] = { "select_prev", "fallback" },
		["<C-j>"] = { "select_next", "fallback" },
		["<C-b>"] = { "scroll_documentation_down", "fallback" },
		["<C-f>"] = { "scroll_documentation_up", "fallback" },
		["<C-l>"] = { "snippet_forward", "fallback" },
		["<C-h>"] = { "snippet_backward", "fallback" },
		["<C-e>"] = { "hide" },
	},
	appearance = {
		use_nvim_cmp_as_default = true,
		nerd_font_variant = "normal",
	},

	completion = {
		keyword = { range = "full" },
		documentation = {
			auto_show = true,
			auto_show_delay_ms = 200,
			window = {
				border = "rounded",
			},
		},
		-- Displays a preview of the selected item on the current line
		ghost_text = {
			enabled = false,
		},
		menu = {
			border = "single",
			draw = {
				components = {
					kind_icon = {
						text = function(ctx)
							local icon = ctx.kind_icon
							if vim.tbl_contains({ "Path" }, ctx.source_name) then
								local dev_icon, _ = require("nvim-web-devicons").get_icon(ctx.label)
								if dev_icon then
									icon = dev_icon
								end
							else
								icon = require("lspkind").symbol_map[ctx.kind] or ""
							end

							return icon .. ctx.icon_gap
						end,
					},
				},
				padding = 0, -- padding only on right side
				columns = {
					{ "kind_icon", "label", "label_description", gap = 1 },
					{ "kind" },
				},
			},
		},
	},

	cmdline = {
		keymap = {
			preset = "inherit",
			["<CR>"] = { "accept_and_enter", "fallback" },
		},
	},

	sources = {
		default = { "lsp", "path", "snippets", "buffer", "vimtex" },
		providers = {
			lsp = {
				name = "lsp",
				enabled = true,
				module = "blink.cmp.sources.lsp",
				kind = "LSP",
				min_keyword_length = 1,
				score_offset = 90, -- the higher the number, the higher the priority
			},
			path = {
				name = "Path",
				module = "blink.cmp.sources.path",
				score_offset = 25,
				fallbacks = { "snippets", "buffer" },
				min_keyword_length = 2,
				opts = {
					trailing_slash = false,
					label_trailing_slash = true,
					get_cwd = function(context)
						return vim.fn.expand(("#%d:p:h"):format(context.bufnr))
					end,
					show_hidden_files_by_default = true,
				},
			},
			buffer = {
				name = "Buffer",
				enabled = true,
				max_items = 3,
				module = "blink.cmp.sources.buffer",
				min_keyword_length = 3,
				score_offset = 15, -- the higher the number, the higher the priority
			},
			snippets = {
				name = "snippets",
				enabled = true,
				max_items = 15,
				min_keyword_length = 1,
				module = "blink.cmp.sources.snippets",
				score_offset = 85, -- the higher the number, the higher the priority
			},

			-- add vimtex as sources
			-- credit: https://www.reddit.com/r/neovim/comments/1invqwg/comment/mcgttl5/?utm_source=share&utm_medium=web3x&utm_name=web3xcss&utm_term=1&utm_content=share_button
			vimtex = {
				name = "vimtex",
				min_keyword_length = 1,
				module = "blink.compat.source",
				score_offset = 80,
			},
		},
	},
})
