local keymap = vim.keymap -- for conciseness

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspConfig", {}),
  callback = function(ev)
    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local opts = { buffer = ev.buf, silent = true }

    -- set keybinds
    opts.desc = "Show LSP references"
    keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts) -- show definition, references

    opts.desc = "Go to definition"
    keymap.set("n", "gd", vim.lsp.buf.definition, opts) -- go to declaration

    opts.desc = "Show LSP declaration"
    keymap.set("n", "gD", vim.lsp.buf.declaration, opts) -- show lsp definition

    opts.desc = "Show LSP implementations"
    keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts) -- show lsp implementations

    opts.desc = "Show LSP type definitions"
    keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts) -- show lsp type definitions

    keymap.set({ "n", "x" }, "<leader>ca", function()
      require("tiny-code-action").code_action()
    end, { noremap = true, silent = true, desc = "See available code actions" })

    keymap.set({ "n" }, "<leader>ci", function()
      vim.lsp.buf.code_action({
        context = { only = { "source.organizeImports" } },
        apply = true,
      })
    end, { noremap = true, silent = true, desc = "Organize Imports" })

    -- opts.desc = "Smart rename"
    -- keymap.set("n", "gr", vim.lsp.buf.rename, opts) -- smart rename

    opts.desc = "Show buffer diagnostics"
    keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts) -- show  diagnostics for file

    opts.desc = "show line diagnostics"
    keymap.set("n", "<C-K>", vim.diagnostic.open_float, opts) -- show diagnostics for line

    opts.desc = "Show documentation for what is under cursor"
    keymap.set("n", "K", vim.lsp.buf.hover, opts) -- show documentation for what is under cursor

    opts.desc = "Go to previous diagnostic"
    keymap.set("n", "gE", function()
      vim.diagnostic.jump({ count = -1, float = true })
    end, opts) -- jump to previous diagnostic in buffer
    --
    opts.desc = "Go to next diagnostic"
    keymap.set("n", "ge", function()
      vim.diagnostic.jump({ count = 1, float = true })
    end, opts) -- jump to next diagnostic in buffer

    opts.desc = "Format buffer"
    keymap.set("n", "gf", "<cmd>lua vim.lsp.buf.format()<CR>", opts) -- mapping to restart lsp if necessary

    opts.desc = "Restart LSP"
    keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts) -- mapping to restart lsp if necessary
  end,
})

-- vim.lsp.inlay_hint.enable(true)

local severity = vim.diagnostic.severity

vim.diagnostic.config({
  virtual_text = {
    -- Set the format function to filter diagnostics
    format = function(diagnostic)
      -- Check if the diagnostic severity is less than or equal to vim.diagnostic.severity.ERROR
      -- WARNING is severity 3, ERROR is severity 2. This logic is correct to only show ERRORs
      if diagnostic.severity <= vim.diagnostic.severity.ERROR then
        -- You can customize the format here or return the default message
        return string.format("[%s] %s", diagnostic.source, diagnostic.message)
      else
        -- Return nil or an empty string to hide the virtual text for other severities (e.g., Warning, Info, Hint)
        return nil
      end
    end,
  },
  signs = {
    text = {
      [severity.ERROR] = "",
      [severity.WARN] = "",
      [severity.HINT] = "󰠠",
      [severity.INFO] = "",
    },
  },
})
