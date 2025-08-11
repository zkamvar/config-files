-- Configure LazyVim to load dark or light mode scheme
return {
  { "rktjmp/lush.nvim" },
  { "EdenEast/nightfox.nvim" },
  { "rose-pine/neovim", name = "rose-pine" },
  { "talha-akram/noctis.nvim" },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin",
      -- colorscheme = function()
      --   local is_dark = vim.o.background == "dark"
      --   if is_dark then
      --     require("nightfox").load()
      --   else
      --     require("dayfox").load()
      --   end
      -- end,
    },
  },
}
