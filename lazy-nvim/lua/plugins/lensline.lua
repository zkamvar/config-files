return {
  "oribarilan/lensline.nvim",
  tag = "1.1.2", -- or: branch = 'release/1.x' for latest non-breaking updates
  event = "LspAttach",
  config = function()
    require("lensline").setup({
      providers = {
        {
          name = "references",
          enabled = true, -- enable references provider
          quiet_lsp = true, -- suppress noisy LSP log messages (e.g., Pyright reference spam)
        },
        {
          name = "last_author",
          enabled = false, -- enabled by default with caching optimization
          cache_max_files = 50, -- maximum number of files to cache blame data for (default: 50)
        },
        -- built-in providers that are diabled by default:
        {
          name = "diagnostics",
          enabled = false, -- disabled by default - enable explicitly to use
          min_level = "WARN", -- only show WARN and ERROR by default (HINT, INFO, WARN, ERROR)
        },
        {
          name = "complexity",
          enabled = false, -- disabled by default - enable explicitly to use
          min_level = "L", -- only show L (Large) and XL (Extra Large) complexity by default
        },
        {
          name = "function_length",
          enabled = true,
          event = { "BufWritePost", "TextChanged" },
          handler = function(bufnr, func_info, provider_config, callback)
            local utils = require("lensline.utils")
            local function_lines = utils.get_function_lines(bufnr, func_info)
            local func_line_count = math.max(0, #function_lines - 1) -- Subtract 1 for signature
            local total_lines = vim.api.nvim_buf_line_count(bufnr)

            -- Show line count for all functions
            callback({
              line = func_info.line,
              text = string.format(
                "(%d/%d lines)",
                func_line_count,
                total_lines
              ),
            })
          end,
        },
      },
    })
  end,
}
