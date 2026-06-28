return {
  "bluz71/vim-moonfly-colors",
  name = "moonfly",
  lazy = false,
  priority = 1000,
  config = function()
    vim.g.moonflyCursorColor = true
    vim.g.moonflyTerminalColors = false
    vim.g.moonflyTransparent = true
    vim.g.moonflyWinSeparator = 2
    vim.cmd("colorscheme moonfly")
  end
}
