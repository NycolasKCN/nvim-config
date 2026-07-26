require('mini.indentscope').setup({
    -- symbol = "▏",
    symbol = "│",
    options = { try_as_border = true },
    draw = {
      -- Delay (in ms) between event and start of drawing scope indicator
      delay = 60,

      -- Symbol priority. Increase to display on top of more symbols.
      priority = 2,
    },
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = {
    "Trouble",
    "alpha",
    "dashboard",
    "fzf",
    "help",
    "lazy",
    "mason",
    "neo-tree",
    "notify",
    "sidekick_terminal",
    "snacks_dashboard",
    "snacks_notif",
    "snacks_terminal",
    "snacks_win",
    "toggleterm",
    "trouble",
  },
  callback = function()
    vim.b.miniindentscope_disable = true
  end,
})

vim.api.nvim_create_autocmd("User", {
  pattern = "SnacksDashboardOpened",
  callback = function(data)
    vim.b[data.buf].miniindentscope_disable = true
  end,
})
