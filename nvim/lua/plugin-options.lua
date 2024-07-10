-- ChangeBackground changes the background mode based on macOS's `Appearance`
-- setting. We also refresh the statusline colors to reflect the new mode.
function! SyncSignColumn()
  let sccolor = system("(kitty @ get-colors | grep '^background ' | sed -e 's/^background *'//) || echo NONE")
  if sccolor != 'NONE'
    execute 'highlight SignColumn guibg='.sccolor
  endif
endfunction

function! ChangeBackground()
  if system("black_cat") =~ '1'
    vim.opt.background='light'  -- for the light version of the theme
  else
    vim.opt.background='dark'   -- for the dark version of the theme
  endif
  colorscheme PaperColor

  try
    execute --AirlineRefresh"
  catch
  endtry
  try
    call SyncSignColumn()
  catch
  endtry
endfunction

let g:airline_theme="sol"
-- initialize the colorscheme for the first run
call ChangeBackground()

-- change the color scheme if we receive a SigUSR1
-- autocmd SigUSR1 * call ChangeBackground()


-- Alignment options
-- ===============================================
-- align arrows in R
vnoremap <leader>tar :Align <-<CR><CR>
-- align comments in bash/r/python/etc
vnoremap <leader>tac :Align #<CR><CR>

-- vim-signify options
-- ===============================================
if has('nvim') || has('patch-8.0.902')
  vim.opt.updatetime=100
endif


-- DistractFree options
-- ===============================================

let g:distractfree_width = '90' -- 80 columns

-- Editorconfig options
-- ===============================================
-- allows EditorConfig work well with fugitive
let g:EditorConfig_exclude_patterns = ['fugitive://.*']

-- context.vim options
-- ===============================================
let g:context_add_mappings = 0

-- NERD Tree options
-- ===============================================
-- Mapping ctrl+n to toggle file tree
map <cr> :NERDTreeToggle<CR>
-- Show Hidden files
let NERDTreeShowHidden=1

-- setings :: rust.vim plugin
let g:rustfmt_autosave = 1

-- Grep options
:let Grep_Skip_Dirs = '.git .Rproj.user'
if executable("rg")
  vim.opt.grepprg='rg\ --vimgrep\ --smart-case\ --hidden'
  vim.opt.grepformat='%f:%l:%c:%m'
endif

-- SuperCollider Options
-- =====================================
-- Highlight the evaluated line
let g:scFlash = 1

-- Remap the F5 and F6 to ones that work better for my keyboard since it's kind
-- of awkward for me to type both fn and F{5,6} keys at the same time. I'm
-- copying these directly from
-- https://github.com/supercollider/scvim/blob/master/plugin/supercollider.vim

au Filetype supercollider nnoremap <leader>sc :call SClangStart()<CR>
au Filetype supercollider nnoremap <leader>b :call SendToSC('s.boot;')<CR>
au Filetype supercollider nnoremap <leader>t :call SendToSC('s.plotTree;')<CR>
au Filetype supercollider nnoremap <leader>m :call SendToSC('s.meter;')<CR>

-- Sending a block of sc code <leader>f(eans)
-- au Filetype supercollider inoremap <leader>f :call SClang_block()<CR>a
au Filetype supercollider nnoremap <leader>f :call SClang_block()<CR>
au Filetype supercollider vnoremap <leader>f :call SClang_send()<CR>

-- Sending a single line is <Space>
au Filetype supercollider vnoremap <buffer> <Space> :call SClang_line()<CR>
au Filetype supercollider nnoremap <buffer> <Space> :call SClang_line()<CR>
-- au Filetype supercollider inoremap <buffer> <Space> :call SClang_line()<CR>a

-- Hardstop is <leader>x
au Filetype supercollider nnoremap <leader>x :call SClangHardstop()<CR>
