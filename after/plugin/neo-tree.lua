require("neo-tree").setup({
	event_handlers = {
		{
			event = "after_render",
			handler = function(state)
				if state.current_position == "left" or state.current_position == "right" then
					vim.api.nvim_win_call(state.winid, function()
						local str = require("neo-tree.ui.selector").get()
						if str then
							_G.__cached_neo_tree_selector = str
						end
					end)
				end
			end,
		},
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
			["D"] = function(state)
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
	filesystem = {
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
				ignored = "◌",
				unstaged = "✗",
				staged = "✓",
				conflict = "",
			},
		},
	},
})

local keymap = vim.keymap.set

keymap("n", "<leader>ee", "<cmd>Neotree toggle<CR>", { desc = "Toggle file explorer" })
keymap("n", "<leader>ef", "<cmd>Neotree filesystem reveal left<CR>", { desc = "Select current file on file explorer" })
keymap("n", "<leader>er", "<cmd>Neotree filesystem reveal left<CR>", { desc = "Refresh file explorer" })
keymap("n", "<leader>ec", function()
  require("neo-tree.command").execute({
    action = "close_all_nodes",
    source = "filesystem",
    position = "left",
  })
end, { desc = "Collapse file explorer" })
