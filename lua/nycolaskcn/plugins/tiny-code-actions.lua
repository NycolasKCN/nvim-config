vim.pack.add({
  {src = "https://github.com/rachartier/tiny-code-action.nvim"}
})

require("tiny-code-action").setup({
  backend = "vim",

  -- The picker to use, "telescope", "snacks", "select", "buffer", "fzf-lua" are supported
  -- And it's opts that will be passed at the picker's creation, optional
  --
  -- You can also set `picker = "<picker>"` without any opts.
  picker = {
    "buffer",
    opts = {
      hotkeys = true, -- Enable hotkeys for quick selection of actions
      hotkeys_mode = "text_diff_based", -- Modes for generating hotkeys
      auto_preview = false, -- Enable or disable automatic preview
      auto_accept = false, -- Automatically accept the selected action (with hotkeys)
      position = "cursor", -- Position of the picker window
      winborder = "single", -- Border style for picker and preview windows
      keymaps = {
        preview = "K", -- Key to show preview
        close = { "q", "<Esc>" }, -- Keys to close the window (can be string or table)
        select = "<CR>", -- Keys to select action (can be string or table)
        preview_close = { "q", "<Esc>" }, -- Keys to return from preview to main window (can be string or table)
      },
      custom_keys = {
        { key = 'm', pattern = 'Fill match arms' },
        { key = 'r', pattern = 'Rename.*' }, -- Lua pattern matching
      },
      group_icon = " └",
    },
  },
  backend_opts = {
    delta = {
      -- Header from delta can be quite large.
      -- You can remove them by setting this to the number of lines to remove
      header_lines_to_remove = 4,

      -- The arguments to pass to delta
      -- If you have a custom configuration file, you can set the path to it like so:
      -- args = {
      --     "--config" .. os.getenv("HOME") .. "/.config/delta/config.yml",
      -- }
      args = {
        "--line-numbers",
      },
    },
    difftastic = {
      header_lines_to_remove = 1,

      -- The arguments to pass to difftastic
      args = {
        "--color=always",
        "--display=inline",
        "--syntax-highlight=on",
      },
    },
    diffsofancy = {
      header_lines_to_remove = 4,
    }
  },

  resolve_timeout = 100,   -- Timeout in milliseconds to resolve code actions

  -- Notification settings
  notify = {
    enabled = true,    -- Enable/disable all notifications
    on_empty = true,   -- Show notification when no code actions are found
  },

  -- Customize how action titles are displayed in the picker
  -- Function receives (action, client) and returns a formatted string
  -- Default: action.title
  format_title = nil,

  -- The icons to use for the code actions
  -- You can add your own icons, you just need to set the exact action's kind of the code action
  -- You can set the highlight like so: { link = "DiagnosticError" } or  like nvim_set_hl ({ fg ..., bg..., bold..., ...})
  signs = {
    quickfix = { "", { link = "DiagnosticWarning" } },
    others = { "", { link = "DiagnosticWarning" } },
    refactor = { "", { link = "DiagnosticInfo" } },
    ["refactor.move"] = { "󰪹", { link = "DiagnosticInfo" } },
    ["refactor.extract"] = { "", { link = "DiagnosticError" } },
    ["source.organizeImports"] = { "", { link = "DiagnosticWarning" } },
    ["source.fixAll"] = { "󰃢", { link = "DiagnosticError" } },
    ["source"] = { "", { link = "DiagnosticError" } },
    ["rename"] = { "󰑕", { link = "DiagnosticWarning" } },
    ["codeAction"] = { "", { link = "DiagnosticWarning" } },
  },
})

vim.keymap.set({ "n", "x" }, "<leader>ca", function()
  require("tiny-code-action").code_action()
end, { noremap = true, silent = true })
