local keymap = vim.keymap.set
local ops = { silent = true }

--- REMAPS --------------

-- keymap("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
-- keymap("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })
-- keymap("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],  { desc = "Search and replace word under cursor" })

ops.desc = "Force buffer save"
keymap("n", "<Leader>w", "<cmd>w!<CR>", ops) -- Save the current file
ops.desc = "Close buffer"
keymap("n", "<Leader>q", "<cmd>q<CR>", ops) -- Quit Neovim

keymap({ "n", "v" }, "L", "$", { desc = "Go to end of line" })
keymap({ "n", "v" }, "H", "0", { desc = "Go to start of line" })

keymap("v", "<c-/>", "gc", { desc = "Toggle comment (Selection)" })
keymap("n", "<c-/>", "gcc", { desc = "Toggle comment (Line)" })

keymap({ "n", "v" }, "Y", "yy", { desc = "Yank line" })
keymap("v", "p", '"_dP', { desc = "Paste without losing current register" })

keymap("n", "<leader><esc>", ":noh<CR>", { desc = "Clear search highlights" })

keymap("n", "<c-j>", "<c-w>j", { desc = "Go to window below" })
keymap("n", "<c-k>", "<c-w>k", { desc = "Go to window above" })
keymap("n", "<c-h>", "<c-w>h", { desc = "Go to window on the left" })
keymap("n", "<c-l>", "<c-w>l", { desc = "Go to window on the right" })

keymap("n", "<M-C-S-j>", ":resize +2<CR>", { desc = "Decrease window height" })
keymap("n", "<M-C-S-k>", ":resize -2<CR>", { desc = "Increase window height" })
keymap("n", "<M-C-S-h>", ":vertical resize +2<CR>", { desc = "Decrease window width" })
keymap("n", "<M-C-S-l>", ":vertical resize -2<CR>", { desc = "Increase window width" })

keymap("n", "<C-o>", "o<esc>", { desc = "Insert empty line below" })
keymap("n", "<C-S-O>", "O<esc>", { desc = "Insert empty line above" })

-- keymap("n", "<TAB>", ":tabn<CR>", { desc = "Next Tab" })
-- keymap("n", "<S-TAB>", ":tabp<CR>", { desc = "Previous Tab" })
-- keymap("n", "<leader>tn", ':tabnew<CR>', { desc = 'New Tab' })
-- keymap("n", "<leader>tc", ':tabclose<CR>', { desc = 'Close Tab' })
-- keymap("n", "<leader>tmf", ':tabmove +<CR>', { desc = 'Move Tab foward' })
-- keymap("n", "<leader>tmb", ':tabmove -<CR>', { desc = 'Move Tab backwards' })

keymap("n", "<C-S-Q>", ":qa<CR>", { desc = "Close all editors" })
keymap("n", "<C-S-W>", ":wa<CR>", { desc = "Save all editors" })

keymap("n", ",", "'", { desc = "Jump to mark" })

--- KEYMAPS --------------
keymap("n", "<leader>ps", "<cmd>lua vim.pack.update()<CR>", { desc = "Vim pack update" })
keymap("n", "m/", "<cmd>MarksListAll<CR>", { desc = "List all marks" })

--- MASON --------------
keymap("n", "<leader>M", "<cmd>Mason<CR>", { desc = "[Mason] Open mason UI" })

--- LSP ----------------
vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("UserLspConfig", {}),
	callback = function(ev)
		-- Buffer local mappings.
		-- See `:help vim.lsp.*` for documentation on any of the below functions
		local opts = { buffer = ev.buf, silent = true }

		-- set keybinds
		opts.desc = "Show LSP references"
		keymap("n", "gR", "<cmd>Telescope lsp_references<CR>", opts) -- show definition, references

		opts.desc = "Go to definition"
		keymap("n", "gd", vim.lsp.buf.definition, opts) -- go to declaration

		opts.desc = "Show LSP declaration"
		keymap("n", "gD", vim.lsp.buf.declaration, opts) -- show lsp definition

		opts.desc = "Show LSP implementations"
		keymap("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts) -- show lsp implementations

		opts.desc = "Show LSP type definitions"
		keymap("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts) -- show lsp type definitions

		keymap({ "n", "x" }, "<leader>ca", function()
			require("tiny-code-action").code_action()
		end, { noremap = true, silent = true, desc = "See available code actions" })

		keymap({ "n" }, "<leader>ci", function()
			vim.lsp.buf.code_action({
				context = { only = { "source.organizeImports" } },
				apply = true,
			})
		end, { noremap = true, silent = true, desc = "Organize Imports" })

		-- opts.desc = "Smart rename"
		-- keymap.set("n", "gr", vim.lsp.buf.rename, opts) -- smart rename

		opts.desc = "Show buffer diagnostics"
		keymap("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts) -- show  diagnostics for file

		opts.desc = "show line diagnostics"
		keymap("n", "<M-C-k>", vim.diagnostic.open_float, opts) -- show diagnostics for line

		opts.desc = "Show documentation for what is under cursor"
		keymap("n", "K", vim.lsp.buf.hover, opts) -- show documentation for what is under cursor

		opts.desc = "Signature Help"
		keymap("n", "gK", vim.lsp.buf.signature_help, opts)

		opts.desc = "Go to previous diagnostic"
		keymap("n", "gE", function()
			vim.diagnostic.jump({ count = -1, float = true })
		end, opts) -- jump to previous diagnostic in buffer
		--
		opts.desc = "Go to next diagnostic"
		keymap("n", "ge", function()
			vim.diagnostic.jump({ count = 1, float = true })
		end, opts) -- jump to next diagnostic in buffer

		opts.desc = "Format buffer"
		keymap("n", "gf", "<cmd>lua vim.lsp.buf.format()<CR>", opts) -- mapping to restart lsp if necessary

		opts.desc = "Restart LSP"
		keymap("n", "<leader>rs", ":LspRestart<CR>", opts) -- mapping to restart lsp if necessary
	end,
})
