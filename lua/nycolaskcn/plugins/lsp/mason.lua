return {
  "mason-org/mason-lspconfig.nvim",
  opts = {
    -- list of servers for mason to install
    ensure_installed = {
      "prettier",
      "html",
      "ts_ls",
      "cssls",
      "tailwindcss",
      "graphql",
      "eslint",

      "roslyn",
      "ast_grep",

      "lua_ls",

      "pyright",

      "clangd",

      "kotlin_language_server",
      "kotlin_lsp",
    },
    automatic_enable = true,
  },
  dependencies = {
    {
      "mason-org/mason.nvim",
      opts = {
        ui = {
          icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗",
          },
        },
        registries = {
          "github:mason-org/mason-registry",
          "github:Crashdummyy/mason-registry"
        }
      },
    },
    {
      "neovim/nvim-lspconfig",
    },
  }
}
