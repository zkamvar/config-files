-- Global options
-- ===============================================
-- have vim save the backups in the /tmp/ directory, remembering the
-- file path of the files
-- https://stackoverflow.com/a/4824781/2752888
home = os.getenv("HOME")
vim.opt.backupdir=home.."/.vim/tmp//"
vim.opt.directory=home.."/.vim/tmp//"
vim.opt.hidden = true -- Allows for hidden buffers in the background
vim.opt.cursorline = true-- Highlights the current line
vim.opt.number=true-- Number all the lines relative to cursor
vim.opt.relativenumber=true-- Number all the lines relative to cursor
vim.opt.expandtab = true-- Use spaces for tabs
vim.opt.cc="81" -- Set the color column at 81
vim.opt.tabstop=2
vim.opt.shiftwidth=2
vim.opt.formatoptions="tcqr"
    -- t auto-wrap text
    -- c auto-wrap commetns
    -- q allow comments to wrap
    -- r auto-continue comment lines
-- https://stackoverflow.com/a/11560415/2752888
vim.opt.list = true-- Display unprintable characters f12 - switches
-- https://vi.stackexchange.com/a/34644
vim.opt.listchars:append({ tab = '<->' }) 
vim.opt.listchars:append({ trail = '•' }) 
vim.opt.listchars:append({ extends = '»' }) 
vim.opt.listchars:append({ precedes = '«' })  -- Unprintable chars mapping
vim.opt.backspace={"indent","eol","start"} -- more powerful backspacing
-- https://stackoverflow.com/a/33358103/2752888
vim.opt.mouse="a"
require("catppuccin").setup({
    flavour = "auto", -- latte, frappe, macchiato, mocha
    background = { -- :h background
        light = "latte",
        dark = "mocha",
    },
    transparent_background = false, -- disables setting the background color.
    show_end_of_buffer = false, -- shows the '~' characters after the end of buffers
    term_colors = false, -- sets terminal colors (e.g. `g:terminal_color_0`)
    dim_inactive = {
        enabled = false, -- dims the background color of inactive window
        shade = "dark",
        percentage = 0.15, -- percentage of the shade to apply to the inactive window
    },
    no_italic = false, -- Force no italic
    no_bold = false, -- Force no bold
    no_underline = false, -- Force no underline
    styles = { -- Handles the styles of general hi groups (see `:h highlight-args`):
        comments = { "italic" }, -- Change the style of comments
        conditionals = { "italic" },
        loops = {},
        functions = {},
        keywords = {},
        strings = {},
        variables = {},
        numbers = {},
        booleans = {},
        properties = {},
        types = {},
        operators = {},
        -- miscs = {}, -- Uncomment to turn off hard-coded styles
    },
    color_overrides = {},
    custom_highlights = {},
    default_integrations = true,
    integrations = {
        cmp = true,
        gitsigns = true,
        nvimtree = true,
        treesitter = true,
        notify = false,
        mini = {
            enabled = true,
            indentscope_color = "",
        },
        -- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
    },
})

-- https://gist.github.com/OXY2DEV/645c90df32095a8a397735d0be646452
require("lsp_hover").setup({
  ["^lua_ls"] = {
    border_hl = "Special"
  },
  ["^rust"] = {
    name = "🦀/RustLSP"
  }
});

vim.lsp.config('rust_analyzer', {
  -- Server-specific settings. See `:help lsp-quickstart`
  settings = {
    ['rust-analyzer'] = {
    },
  },
})
vim.lsp.inlay_hint.enable()
