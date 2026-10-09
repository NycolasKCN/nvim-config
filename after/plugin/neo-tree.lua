require("neo-tree").setup({
	event_handlers = {
		-- Bufferline integration (dont work)
		-- {
		-- 	event = "after_render",
		-- 	handler = function(state)
		-- 		if state.current_position == "left" or state.current_position == "right" then
		-- 			vim.api.nvim_win_call(state.winid, function()
		-- 				local str = require("neo-tree.ui.selector").get()
		-- 				if str then
		-- 					_G.__cached_neo_tree_selector = str
		-- 				end
		-- 			end)
		-- 		end
		-- 	end,
		-- },
	},
	window = {
		mappings = {
			["e"] = function()
				vim.cmd("Neotree focus filesystem left", true)
			end,
			["b"] = function()
				vim.cmd("Neotree focus buffers left", true)
			end,
			["g"] = function()
				vim.cmd("Neotree focus git_status left", true)
			end,
			["D"] = function(state) -- Diff
				local node = state.tree:get_node()
				local log = require("neo-tree.log")
				state.clipboard = state.clipboard or {}
				if diff_Node and diff_Node ~= tostring(node.id) then
					local current_Diff = node.id
					require("neo-tree.utils").open_file(state, diff_Node, open)
					vim.cmd("vert diffs " .. current_Diff)
					log.info("Diffing " .. diff_Name .. " against " .. node.name)
					diff_Node = nil
					current_Diff = nil
					state.clipboard = {}
					require("neo-tree.ui.renderer").redraw(state)
				else
					local existing = state.clipboard[node.id]
					if existing and existing.action == "diff" then
						state.clipboard[node.id] = nil
						diff_Node = nil
						require("neo-tree.ui.renderer").redraw(state)
					else
						state.clipboard[node.id] = { action = "diff", node = node }
						diff_Name = state.clipboard[node.id].node.name
						diff_Node = tostring(state.clipboard[node.id].node.id)
						log.info("Diff source file " .. diff_Name)
						require("neo-tree.ui.renderer").redraw(state)
					end
				end
			end,
		},
	},
	source_selector = {
		winbar = true, -- toggle to show selector on winbar
		statusline = false, -- toggle to show selector on statusline
		show_scrolled_off_parent_node = false, -- boolean
		sources = { -- table
			{
				source = "filesystem", -- string
				display_name = " 󰉓 Files ", -- string | nil
			},
			{
				source = "buffers", -- string
				display_name = " 󰈚 Buffers ", -- string | nil
			},
			{
				source = "git_status", -- string
				display_name = " 󰊢 Git ", -- string | nil
			},
		},
		content_layout = "start", -- string
		tabs_layout = "equal", -- string
		truncation_character = "…", -- string
		tabs_min_width = nil, -- int | nil
		tabs_max_width = nil, -- int | nil
		padding = 0, -- int | { left: int, right: int }
		separator = { left = "▏", right = "▕" }, -- string | { left: string, right: string, override: string | nil }
		separator_active = nil, -- string | { left: string, right: string, override: string | nil } | nil
		show_separator_on_edge = false, -- boolean
		highlight_tab = "NeoTreeTabInactive", -- string
		highlight_tab_active = "NeoTreeTabActive", -- string
		highlight_background = "NeoTreeTabInactive", -- string
		highlight_separator = "NeoTreeTabSeparatorInactive", -- string
		highlight_separator_active = "NeoTreeTabSeparatorActive", -- string
	},
	filesystem = {
		follow_current_file = { enabled = true },
		hijack_netrw_behavior = "open_current",
		components = {
			harpoon_index = function(config, node, _)
				local harpoon_list = require("harpoon"):list()
				local path = node:get_id()
				local harpoon_key = vim.uv.cwd()

				for i, item in ipairs(harpoon_list.items) do
					local value = item.value
					if string.sub(item.value, 1, 1) ~= "/" then
						value = harpoon_key .. "/" .. item.value
					end

					if value == path then
						vim.print(path)
						return {
							text = string.format(" ⥤ %d", i), -- <-- Add your favorite harpoon like arrow here
							highlight = config.highlight or "NeoTreeDirectoryIcon",
						}
					end
				end
				return {}
			end,
		},
		renderers = {
			file = {
				{ "icon" },
				{ "name", use_git_status_colors = true },
				{ "harpoon_index" }, --> This is what actually adds the component in where you want it
				{ "diagnostics" },
				{ "git_status", highlight = "NeoTreeDimText" },
			},
		},
		window = {
			mappings = {
				["o"] = "system_open",
			},
		},
		filtered_items = {
			-- when true, they will just be displayed differently than normal items
			visible = false,
			-- whether children of filtered parents should inherit their parent's highlight group
			children_inherit_highlights = true,
			hide_dotfiles = false,
			hide_gitignored = true,
			hide_ignored = true, -- hide files that are ignored by other gitignore-like files
			-- other gitignore-like files, in descending order of precedence.
			ignore_files = {
				".neotreeignore",
				".ignore",
				-- ".rgignore"
			},
			hide_hidden = true, -- only works on Windows for hidden files/directories
			hide_by_name = {
				".DS_Store",
				"thumbs.db",
				"node_modules",
			},
			hide_by_pattern = {
				--"*.meta",
				--"*/src/*/tsconfig.json",
			},
			always_show = { -- remains visible even if other settings would normally hide it
				--".gitignored",
			},
			always_show_by_pattern = { -- uses glob style patterns
				".env*",
			},
			never_show = { -- remains hidden even if visible is toggled to true, this overrides always_show
				--".DS_Store",
				--"thumbs.db",
			},
			never_show_by_pattern = { -- uses glob style patterns
				--".null-ls_*",
			},
		},
	},

	commands = {
		system_open = function(state)
			local node = state.tree:get_node()
			local path = node:get_id()
			-- macOs: open file in default application in the background.
			vim.fn.jobstart({ "open", path }, { detach = true })
			-- Linux: open file in default application
			vim.fn.jobstart({ "xdg-open", path }, { detach = true })

			-- Windows: Without removing the file from the path, it opens in code.exe instead of explorer.exe
			local p
			local lastSlashIndex = path:match("^.+()\\[^\\]*$") -- Match the last slash and everything before it
			if lastSlashIndex then
				p = path:sub(1, lastSlashIndex - 1) -- Extract substring before the last slash
			else
				p = path -- If no slash found, return original path
			end
			vim.cmd("silent !start explorer " .. p)
		end,
	},
	default_component_configs = {
		git_status = {
			symbols = {
				added = "✚",
				modified = "",
				deleted = "✖",
				renamed = "➜",
				untracked = "★",
				ignored = "",
				unstaged = "󰄱",
				staged = "",
				conflict = "",
			},
		},
		indent = {
			with_markers = true,
			indent_marker = "│",
			last_indent_marker = "└",
			indent_size = 2,
			-- expanders
			with_expanders = true,
			expander_collapsed = "",
			expander_expanded = "",
			expander_highlight = "NeoTreeExpander",
		},
	},
})

local wk = require("which-key")
wk.add({
	{ "<leader>e", group = "Explorer (Neotree)" },
	{
		"<leader>ee",
		"<cmd>Neotree toggle<CR>",
		desc = "Toggle file explorer",
		mode = "n",
	},
	{
		"<leader>ef",
		"<cmd>Neotree filesystem reveal left<CR>",
		desc = "Select current file on file explorer",
		mode = "n",
	},
	{
		"<leader>er",
		"<cmd>Neotree filesystem reveal left<CR>",
		desc = "Refresh file explorer",
		mode = "n",
	},
	{
		"<leader>ec",
		function()
			require("neo-tree.command").execute({
				action = "close_all_nodes",
				source = "filesystem",
				position = "left",
			})
		end,
		desc = "Collapse file explorer",
		mode = "n",
	},
})
