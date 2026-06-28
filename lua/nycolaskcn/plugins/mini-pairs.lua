return {
  "nvim-mini/mini.pairs",
  event = "VeryLazy",
  config = function(_, opts)
    require("mini.pairs").setup()
  end,
}
