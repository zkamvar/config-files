local fun = require("config/functions")

local opts = {}

-- settings :: Nvim-R plugin
-- ===============================================
-- This searches if radian (an enhanced client for R) is installed
-- https://github.com/randy3k/radian
local no_lockfile = vim.fn.filereadable("renv.lock") ~= 1
local no_profile = vim.fn.filereadable(".Rprofile") ~= 1
local okay_for_radian = no_lockfile or no_profile
if vim.fn.executable("radian") == 1 and okay_for_radian then
  opts.R_app = "radian"
  opts.R_cmd = "R"
  opts.hl_term = false
  opts.R_args = {}
  opts.bracketed_paste = true
else
  -- Default arguments on start
  opts.R_args = { "--no-save", "--no-restore" }
end

-- set a minimum source editor width
opts.min_editor_width = 80
-- set the working directory to be vim's working directory
setwd = "nvim"
-- control the size of the R console
opts.rconsole_width = math.floor(vim.fn.winwidth(0) / 2)
  - vim.fn.getwininfo(vim.fn.win_getid())[1]["textoff"]
opts.auto_quit = true
-- opts.external_term = "kitty_split"
opts.rconsole_height = 10

-- Chaos
opts.hook = {
  on_filetype = function()
    -- Creating maps to "<Plug>RDSendLine" and "<Plug>RSendSelection"
    -- will prevent R.nvim of creating its default maps to them.
    local fname = vim.api.nvim_buf_get_name(0)

    vim.api.nvim_buf_set_keymap(0, "n", "<Space>", "<Plug>RDSendLine", {})
    vim.api.nvim_buf_set_keymap(0, "v", "<Space>", "<Plug>RSendSelection", {})

    vim.api.nvim_buf_set_keymap(
      0,
      "n",
      "<LocalLeader>L",
      "<Cmd>lua require('r.run').action('levels')<CR>",
      {}
    )

    -- If you want an action over an selection, then the second
    -- argument must be the string `"v"`:
    -- In this case, the beginning and the end of the selection must be
    -- in the same line.
    vim.api.nvim_buf_set_keymap(
      0,
      "v",
      "<LocalLeader>T",
      "<Cmd>lua require('r.run').action('head')<CR>",
      {}
    )

    -- If a third optional argument starts with a comma, it will be
    -- inserted as argument(s) to the `action`:
    vim.api.nvim_buf_set_keymap(
      0,
      "n",
      "<LocalLeader>H",
      "<Cmd>lua require('r.run').action('head', 'n', ', n = 10')<CR>",
      {}
    )

    -- DEVTOOLS COMMANDS
    -- If the command that you want to send does not require an R
    -- object as argument, you can use `cmd()` from the `r.send` module
    -- to send it directly to R Console:
    vim.api.nvim_buf_set_keymap(
      0,
      "n",
      "<c-L>",
      "<Cmd>lua require('r.send').cmd('devtools::load_all()')<CR>",
      {}
    )
    vim.api.nvim_buf_set_keymap(
      0,
      "n",
      "<c-D>",
      "<Cmd>lua require('r.send').cmd('devtools::document()')<CR>",
      {}
    )
    vim.api.nvim_buf_set_keymap(
      0,
      "n",
      "<c-T>",
      "<Cmd>lua require('r.send').cmd('devtools::test()')<CR>",
      {}
    )
    vim.api.nvim_buf_set_keymap(
      0,
      "n",
      "<c-E>",
      "<Cmd>lua require('r.send').cmd('devtools::check()')<CR>",
      {}
    )
    vim.api.nvim_buf_set_keymap(
      0,
      "n",
      "<tab>",
      "<Cmd>lua require('r.send').cmd('devtools::test_active_file("
        .. '"'
        .. fname
        .. '"'
        .. ")')<CR>",
      {}
    )
  end,
}

-- Let me have my snake case :}~~<
vim.g.R_assign = 0

-- R output is highlighted with current colorscheme
vim.g.rout_follow_colorscheme = 1
--
-- R commands in R output are highlighted
vim.g.Rout_more_colors = 1

vim.cmd("autocmd VimResized * g:rconsole_width = winwidth(0) / 2")

-- Don't expand a dataframe to show columns by default
vim.g.R_objbr_opendf = 0

-- disable annoying arg indent
vim.g.r_indent_align_args = 0

-- Switch between file and test
vim.cmd([[
function! SwitchTestBuddy()
let f = expand('%:t')
if expand('%:p:h:t') == 'testthat'
execute ':edit R/'..substitute(f, 'test-', '', '')
else
execute ':edit tests/testthat/test-'..f
endif
endfunction

" Mappings for devtools vim
map <c-O> :call SwitchTestBuddy()<CR>
]])

return {
  "R-nvim/R.nvim",
  -- Only required if you also set defaults.lazy = true
  lazy = false,
  -- R.nvim is still young and we may make some breaking changes from time
  -- to time (but also bug fixes all the time). If configuration stability
  -- is a high priority for you, pin to the latest minor version, but unpin
  -- it and try the latest version before reporting an issue:
  -- version = "~0.1.0"
  config = function()
    require("r").setup(opts)
  end,
}
