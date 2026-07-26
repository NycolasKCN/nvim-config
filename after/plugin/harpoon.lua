local harpoon = require('harpoon')
harpoon:setup({})
local harpoon_extensions = require("harpoon.extensions")
harpoon:extend(harpoon_extensions.builtins.highlight_current_file())

-- basic telescope configuration
local telescopeConf = require("telescope.config").values
local function toggle_telescope(harpoon_files)
  local file_paths = {}
  for _, item in ipairs(harpoon_files.items) do
    table.insert(file_paths, item.value)
  end

  require("telescope.pickers").new({}, {
    prompt_title = "Harpoon",
    finder = require("telescope.finders").new_table({
      results = file_paths,
    }),
    previewer = telescopeConf.file_previewer({}),
    sorter = telescopeConf.generic_sorter({}),
  }):find()
end

vim.keymap.set("n", "<C-f>", function() toggle_telescope(harpoon:list()) end, { desc = "Open harpoon window (telescope)" })
vim.keymap.set("n", "<C-d>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, { desc = "Open harpoon window" })
vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end, { desc = "Add to list (harpoon)" })

-- Toggle previous & next buffers stored within Harpoon list
vim.keymap.set("n", "<M-P>", function() harpoon:list():prev() end, { desc = "Goto next buffer" })
vim.keymap.set("n", "<M-N>", function() harpoon:list():next() end, { desc = "Goto prev buffer" })
