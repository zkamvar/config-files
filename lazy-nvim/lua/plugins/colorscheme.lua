-- Configure LazyVim to load dark or light mode scheme
return {
  { "rktjmp/lush.nvim" },
  { "EdenEast/nightfox.nvim" },
  { "rose-pine/neovim", name = "rose-pine" },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "rose-pine",
    },
  },
}
