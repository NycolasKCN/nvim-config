require("which-key").setup({
  ---@type false | "classic" | "modern" | "helix"
  preset = "helix",

  -- Delay before showing the popup. Can be a number or a function that returns a number.
  ---@type number | fun(ctx: { keys: string, mode: string, plugin?: string }):number
  delay = 360,

  -- show a warning when issues were detected with your mappings
  notify = true,

  -- Which-key automatically sets up triggers for your mappings.
  -- But you can disable this and setup the triggers manually.
  -- Check the docs for more info.
  ---@type wk.Spec
  triggers = {
    { "<auto>", mode = "nxso" },
  },

  plugins = {
    marks = true,       -- shows a list of your marks on ' and `
    registers = true,   -- shows your registers on " in NORMAL or <C-r> in INSERT mode
    spelling = {
      enabled = true,     -- enabling this will show WhichKey when pressing z= to select spelling suggestions
      suggestions = 12,   -- how many suggestions should be shown in the list?
    },
    presets = {
      operators = true,      -- adds help for operators like d, y, ...
      motions = false,        -- adds help for motions
      text_objects = true,   -- help for text objects triggered after entering an operator
      windows = true,        -- default bindings on <c-w>
      nav = true,            -- misc bindings to work with windows
      z = true,              -- bindings for folds, spelling and others prefixed with z
      g = true,              -- bindings for prefixed with g
    },
  },

  ---@type wk.Win.opts
  win = {
    -- don't allow the popup to overlap with the cursor
    no_overlap = true,
    title = true,
    title_pos = "left",
    zindex = 1000,
  },

  layout = {
    width = { min = 20 },   -- min and max width of the columns
    spacing = 3,            -- spacing between columns
  },

  keys = {
    scroll_down = "<c-d>",   -- binding to scroll down inside the popup
    scroll_up = "<c-u>",     -- binding to scroll up inside the popup
  },

  ---@type (string|wk.Sorter)[]
  sort = { "local", "order", "group", "alphanum", "mod" },

  ---@type number|fun(node: wk.Node):boolean?
  expand = 0,   -- expand groups when <= n mappings

  icons = {
    breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
    separator = "➜", -- symbol used between a key and it's label
    group = "+", -- symbol prepended to a group
    ellipsis = "…",
    colors = true,
    keys = {
      Up = " ",
      Down = " ",
      Left = " ",
      Right = " ",
      S = "󰘶 ",
      CR = "󰌑 ",
      Esc = "󱊷 ",
      ScrollWheelDown = "󱕐 ",
      ScrollWheelUp = "󱕑 ",
      NL = "󰌑 ",
      BS = "󰁮",
      Space = "󱁐 ",
      Tab = "󰌒 ",
      F1 = "󱊫",
      F2 = "󱊬",
      F3 = "󱊭",
      F4 = "󱊮",
      F5 = "󱊯",
      F6 = "󱊰",
      F7 = "󱊱",
      F8 = "󱊲",
      F9 = "󱊳",
      F10 = "󱊴",
      F11 = "󱊵",
      F12 = "󱊶",
    },
  },
  show_help = true,   -- show a help message in the command line for using WhichKey
  show_keys = true,   -- show the currently pressed key and its label as a message in the command line
  debug = false,   -- enable wk.log in the current directory
})

vim.keymap.set("n", "<leader>?", function()
  require("which-key").show({ global = false })
end, { desc = "Buffer Local Keymaps (which-key)" })
