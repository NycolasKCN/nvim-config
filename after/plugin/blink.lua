local cmp = require('blink.cmp')
cmp.build():pwait()
cmp.setup({
  fuzzy = { implementation = 'prefer_rust_with_warning' },
  signature = { enabled = true },
  keymap = {
      preset = "default",
      ["<C-space>"] = {},
      ["<C-p>"] = {},
      ["<Tab>"] = {},
      ["<S-Tab>"] = {},
      ["<S-K>"] = { "show", "show_documentation", "hide_documentation" },
      ["<C-CR>"] = { "select_and_accept" },
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
      documentation = {
          auto_show = true,
          auto_show_delay_ms = 200,
      },
      menu = {
        border = "single",
      },
      -- Displays a preview of the selected item on the current line
      ghost_text = {
        enabled = true,
      },
  },

  cmdline = {
      keymap = {
          preset = 'inherit',
          ['<CR>'] = { 'accept_and_enter', 'fallback' },
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
          min_keyword_length = 3,
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
          min_keyword_length = 2,
          score_offset = 15, -- the higher the number, the higher the priority
        },
        snippets = {
          name = "snippets",
          enabled = true,
          max_items = 15,
          min_keyword_length = 2,
          module = "blink.cmp.sources.snippets",
          score_offset = 85, -- the higher the number, the higher the priority
        },

      -- add vimtex as sources
      -- credit: https://www.reddit.com/r/neovim/comments/1invqwg/comment/mcgttl5/?utm_source=share&utm_medium=web3x&utm_name=web3xcss&utm_term=1&utm_content=share_button
      vimtex = {
        name = "vimtex",
        min_keyword_length = 2,
        module = "blink.compat.source",
        score_offset = 80,
      },
    }
  }
})
