local bufnr = vim.api.nvim_get_current_buf()
vim.keymap.set(
  "n", 
  "<leader>a", 
  function()
    vim.lsp.buf.codeAction() -- supports rust-analyzer's grouping
    -- or vim.lsp.buf.codeAction() if you don't want grouping.
  end,
  { silent = true, buffer = bufnr }
)
vim.keymap.set(
  "n", 
  "F",  -- Render diagnostics
  function()
    vim.diagnostic.open_float()
  end,
  { silent = true, buffer = bufnr }
)
vim.keymap.set(
  "n", 
  "K",  -- Render diagnostics
  function()
    vim.diagnostic.open_float()
  end,
  { silent = true, buffer = bufnr }
)
