vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
  { desc = "Search and replace word under cursor" })

vim.keymap.set({ "n", "v" }, "L", "$", { desc = "Go to end of line" })
vim.keymap.set({ "n", "v" }, "H", "0", { desc = "Go to start of line" })

vim.keymap.set("v", "<c-/>", "gc", { desc = "Toggle comment (Selection)" })
vim.keymap.set("n", "<c-/>", "gcc", { desc = "Toggle comment (Line)" })

vim.keymap.set({ "n", "v" }, "Y", "yy", { desc = "Yank line" })
vim.keymap.set("v", "p", "\"_dP", { desc = "Paste without losing current register" })

vim.keymap.set("n", "<leader><esc>", ":noh<CR>", { desc = "Clear search highlights" })
vim.keymap.set("n", "<leader>L", ":Lazy<CR>", { desc = "Open Lazy menu" })

-- vim.keymap.set("n", "<c-j>", "<c-w>j", { desc = "Go to window below" })
-- vim.keymap.set("n", "<c-k>", "<c-w>k", { desc = "Go to window above" })
-- vim.keymap.set("n", "<c-h>", "<c-w>h", { desc = "Go to window on the left" })
-- vim.keymap.set("n", "<c-l>", "<c-w>l", { desc = "Go to window on the right" })

vim.keymap.set("n", "<A-j>", ":resize +2<CR>", { desc = "Decrease window height" })
vim.keymap.set("n", "<A-k>", ":resize -2<CR>", { desc = "Increase window height" })
vim.keymap.set("n", "<A-h>", ":vertical resize +2<CR>", { desc = "Decrease window width" })
vim.keymap.set("n", "<A-l>", ":vertical resize -2<CR>", { desc = "Increase window width" })

vim.keymap.set("n", "<C-o>", "o<esc>", { desc = "Insert empty line below" })
vim.keymap.set("n", "<C-S-O>", "O<esc>", { desc = "Insert empty line above" })

-- vim.keymap.set("n", "<TAB>", ":tabn<CR>", { desc = "Next Tab" })
-- vim.keymap.set("n", "<S-TAB>", ":tabp<CR>", { desc = "Previous Tab" })
-- vim.keymap.set("n", "<leader>tn", ':tabnew<CR>', { desc = 'New Tab' })
-- vim.keymap.set("n", "<leader>tc", ':tabclose<CR>', { desc = 'Close Tab' })
-- vim.keymap.set("n", "<leader>tmf", ':tabmove +<CR>', { desc = 'Move Tab foward' })
-- vim.keymap.set("n", "<leader>tmb", ':tabmove -<CR>', { desc = 'Move Tab backwards' })

vim.keymap.set("n", "<C-S-Q>", ':qa<CR>', { desc = 'Close all editors' })
vim.keymap.set("n", "<C-S-W>", ':wa<CR>', { desc = 'Save all editors' })

vim.keymap.set("n", ",", "'", { desc = "Jump to mark" })

vim.keymap.set("n", "m/", "<cmd>MarksListAll<CR>", { desc = "List all marks" })
