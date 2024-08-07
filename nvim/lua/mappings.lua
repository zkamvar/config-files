local fun = require('functions')
-- To change the hellacious CTRL-W to a much more wrist-friendly alternative
-- https://vi.stackexchange.com/a/3729/18729
map('n', '<Leader>w', '<C-w>', {noremap = true})

-- Copy to clipboard
-- https://stackoverflow.com/a/15971506/2752888
if vim.fn.has("mac") ~= 0 then
  -- vnoremap <C-c> :w !pbcopy<CR><CR>
  map('v', '<C-c>', ':w !pbcopy<CR><CR>', {noremap = true})
  -- let g:rust_clip_command = 'pbcopy'
  vim.g["rust_clip_command"] = 'pbcopy'
else
  -- vnoremap <C-C> :w !xclip -i -sel c<CR><CR>
  map('v', '<C-c>', ':w !xclip -i -sel c<CR><CR>', {noremap = true})
  -- let g:rust_clip_command = 'xclip -selection clipboard'
  vim.g["rust_clip_command"] = 'xclip -selection clipboard'
end

-- Use Ctrl+Space to do omnicompletion:
if vim.fn.has("nvim") ~= 0 or vim.fn.has("gui_running") ~= 0 then
  -- inoremap <C-Space> <C-x><C-o>
  map('i', '<C-Space>', '<C-x><C-o>', {noremap = true})
else
  -- inoremap <Nul> <C-x><C-o>
  map('i', '<Nul>', '<C-x><C-o>', {noremap = true})
end

-- Give me a testthat snippet
-- autocmd Filetype r :iabbrev tt <CR>test_that("", {<CR><CR>})<CR><UP><UP><UP><esc>wll
vim.api.nvim_create_autocmd({"Filetype"}, {
  pattern = {"r", "R"},
  command = [[
    :iabbrev tt <CR>test_that("", {<CR><CR>})<CR><UP><UP><UP><esc>wll
  ]],
})
vim.cmd([[ 
augroup pandoc_syntax 
    au! BufNewFile,BufFilePre,BufRead *.qmd set filetype=markdown 
    au! BufNewFile,BufFilePre,BufRead *.Rmd set filetype=markdown 
    au! BufNewFile,BufFilePre,BufRead *.md set filetype=markdown 
    au! BufNewFile,BufFilePre,BufRead *.markdown set filetype=markdown 
augroup END 
]])

