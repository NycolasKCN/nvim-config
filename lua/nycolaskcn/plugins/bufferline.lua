return {
  "akinsho/bufferline.nvim",
  event = "VeryLazy",
  keys = {
    { "<leader>bp",  "<Cmd>BufferLineTogglePin<CR>",            desc = "Toggle Pin" },
    { "<leader>bP",  "<Cmd>BufferLineGroupClose ungrouped<CR>", desc = "Delete Non-Pinned Buffers" },
    { "<leader>bl",  "<Cmd>BufferLineCloseRight<CR>",           desc = "Delete Buffers to the Right" },
    { "<leader>bh",  "<Cmd>BufferLineCloseLeft<CR>",            desc = "Delete Buffers to the Left" },
    { "<leader>bq",  "<Cmd>b#<CR>:bd #<CR>",                    desc = "Delete current Buffer and jump to previous" },
    { "<S-TAB>",     "<cmd>BufferLineCyclePrev<cr>",            desc = "Prev Buffer" },
    { "<TAB>",       "<cmd>BufferLineCycleNext<cr>",            desc = "Next Buffer" },
    { "<leader>bmb", "<cmd>BufferLineMovePrev<cr>",             desc = "Move buffer prev" },
    { "<leader>bmf", "<cmd>BufferLineMoveNext<cr>",             desc = "Move buffer next" },
    { "<leader>bj",  "<cmd>BufferLinePick<cr>",                 desc = "Pick Buffer" },
  },
  opts = {
    options = {
      diagnostics = "nvim_lsp",
      mode = "buffers",
      separator_style = "slant",
      always_show_bufferline = true,
      enforce_regular_tabs = true,
      auto_toggle_bufferline = true,
      offsets = {
        {
          filetype = "NvimTree",
          text = "File Explorer",
          text_align = "left",
          separator = true
        },
      },
    },
  },
  config = function(_, opts)
    require("bufferline").setup(opts)
    -- Fix bufferline when restoring a session
    vim.api.nvim_create_autocmd({ "BufAdd", "BufDelete" }, {
      callback = function()
        vim.schedule(function()
          pcall(nvim_bufferline)
        end)
      end,
    })
  end,
}
