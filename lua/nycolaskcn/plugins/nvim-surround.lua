return {
  "kylechui/nvim-surround",
  version = "^3.0.0", -- Use for stability; omit to use `main` branch for the latest features
  event = "VeryLazy",
  config = function()
    require("nvim-surround").setup({
      -- Configuration here, or leave empty to use defaults
      surrounds = {
        ["<"] = {
          add = function()
            local config = require("nvim-surround.config")
            local result = config.get_input("Enter the tag name: ")
            return { { "<" .. result .. ">" }, { "</" .. result .. ">" } }
          end
        },
      },
    })
  end
}
