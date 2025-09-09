return {
  "nvim-telescope/telescope.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  optional = true,
  keys = {
    { "<leader>fp", pick, desc = "Projects" },
  },
}
