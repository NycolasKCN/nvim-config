return {
  "hrsh7th/nvim-cmp",
  event = "InsertEnter",
  dependencies = {
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-nvim-lsp",
    "L3MON4D3/LuaSnip",
    "saadparwaiz1/cmp_luasnip",
    "rafamadriz/friendly-snippets",
    "onsails/lspkind.nvim",
    "micangl/cmp-vimtex",
  },
  config = function()
    local cmp = require("cmp")
    local luasnip = require("luasnip")
    local lspkind = require("lspkind")

    require("luasnip.loaders.from_vscode").lazy_load()

    cmp.setup({
      completion = { completeopt = "menu,menuone,preview,noselect" },
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      mapping = cmp.mapping.preset.insert({
        ["<C-k>"] = cmp.mapping.select_prev_item(),
        ["<C-j>"] = cmp.mapping.select_next_item(),
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-e>"] = cmp.mapping.abort(),
        ["<C-Tab>"] = cmp.mapping.complete(),
        ["<CR>"] = cmp.mapping.confirm({ select = true }),
      }),
      sorting = { priority_weight = 2 },
      sources = cmp.config.sources({
        { name = "nvim_lsp", priority = 100, group_index = 1 },
        { name = "luasnip",  priority = 50,  group_index = 2 },
        { name = "vimtex",   priority = 42,  group_index = 1 },
        { name = "buffer",   priority = 40,  group_index = 2 },
        { name = "path",     priority = 30,  group_index = 1 },
      }),
      formatting = {
        format = lspkind.cmp_format({
          maxwidth = 48,
          ellipsis_char = "...",
        }),
      },
    })

    cmp.setup.cmdline('/', {
      mapping = cmp.mapping.preset.cmdline(),
      sources = {
        { name = 'buffer' }
      }
    })

    cmp.setup.cmdline(':', {
      mapping = cmp.mapping.preset.cmdline(),
      sources = cmp.config.sources({
        { name = 'path' }
      }, {
        { name = 'cmdline' }
      }),
      matching = { disallow_symbol_nonprefix_matching = false }
    })
    vim.keymap.set({ "i", "s" }, "<C-l>", function() luasnip.jump(1) end, { silent = true })
    vim.keymap.set({ "i", "s" }, "<C-h>", function() luasnip.jump(-1) end, { silent = true })
  end,
}
