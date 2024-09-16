" Airline options
" ===============================================
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#whitespace#enabled = 0
let g:airline#extensions#clock#format = '%b%d %H:%M'
let g:airline#parts#ffenc#skip_expected_string='utf-8[unix]'
let g:airline#extensions#wordcount#formatter#default#fmt = 'W:%s'
let g:airline#extensions#wordcount#formatter#default#fmt_short = 'W:%s'
"
" Color Scheme Options
" ===============================================
set termguicolors " needed for ayucolor to work
let g:indent_guides_start_level = 3
let g:indent_guides_enable_on_vim_startup = 1
let g:PaperColor_Theme_Options = {
  \   'theme': {
  \     'default': {
  \       'transparent_background': 1,
  \       'allow_bold': 1,
  \       'allow_italic': 1,
  \     }
  \   }
  \ }

" ChangeBackground changes the background mode based on macOS's `Appearance`
" setting. We also refresh the statusline colors to reflect the new mode.
function! SyncSignColumn()
  let sccolor = system("(kitty @ get-colors | grep '^background ' | sed -e 's/^background *'//) || echo NONE")
  if sccolor != 'NONE'
    execute 'highlight SignColumn guibg='.sccolor
  endif
endfunction

function! ChangeBackground()
  if system("black_cat") =~ '1'
    set background=light  " for the light version of the theme
  else
    set background=dark   " for the dark version of the theme
  endif
  colorscheme catppuccin

  try
    execute "AirlineRefresh"
  catch
  endtry
  try
    call SyncSignColumn()
  catch
  endtry
endfunction

let g:airline_theme="sol"
" initialize the colorscheme for the first run
call ChangeBackground()

" change the color scheme if we receive a SigUSR1
" autocmd SigUSR1 * call ChangeBackground()


" Alignment options
" ===============================================
" align arrows in R
vnoremap <leader>tar :Align <-<CR><CR>
" align comments in bash/r/python/etc
vnoremap <leader>tac :Align #<CR><CR>

" vim-signify options
" ===============================================
if has('nvim') || has('patch-8.0.902')
  set updatetime=100
endif


" DistractFree options
" ===============================================

let g:distractfree_width = '90' " 80 columns

" Editorconfig options
" ===============================================
" allows EditorConfig work well with fugitive
let g:EditorConfig_exclude_patterns = ['fugitive://.*']

" context.vim options
" ===============================================
let g:context_add_mappings = 0

" NERD Tree options
" ===============================================
" Mapping ctrl+n to toggle file tree
map <cr> :NERDTreeToggle<CR>
" Show Hidden files
let NERDTreeShowHidden=1

" setings :: rust.vim plugin
let g:rustfmt_autosave = 1

"" settings :: Nvim-R plugin
"" ===============================================
"" This searches if radian (an enhanced client for R) is installed
"" https://github.com/randy3k/radian
"if executable('radian')
"  let R_app = "radian"
"  let R_cmd = "R"
"  let R_hl_term = 0
"  let R_args = []
"  let R_bracketed_paste = 1
"else
"  " Default arguments on start
"  let R_args = ['--no-save', '--no-restore']
"endif

"" Let me have my snake case :}~~<
"let R_assign = 0

"" R output is highlighted with current colorscheme
"let g:rout_follow_colorscheme = 1
""
"" R commands in R output are highlighted
"let g:Rout_more_colors = 1

"" set a minimum source editor width
"let R_min_editor_width = 80

"" set the working directory to be vim's working directory
"let R_nvim_wd = 1

"" control the size of the R console
"let R_rconsole_width = winwidth(0) / 2
"let R_rconsole_height = 10
"autocmd VimResized * let R_rconsole_width = winwidth(0) / 2

"" Don't expand a dataframe to show columns by default
"let R_objbr_opendf = 0

"" disable annoying arg indent
"let r_indent_align_args = 0

"" Press the space bar to send lines and selection to R console
"vmap <Space> <Plug>RDSendSelection
"nmap <Space> <Plug>RDSendLine

"" Switch between file and test
"function! SwitchTestBuddy()
"  let f = expand('%:t')
"  if expand('%:p:h:t') == 'testthat'
"    execute ':edit R/'..substitute(f, 'test-', '', '')
"  else
"    execute ':edit tests/testthat/test-'..f
"  endif
"endfunction

"" Mappings for devtools vim
"map <c-L> :RLoadPackage<CR>
"map <c-D> :RDocumentPackage<CR>
"map <c-T> :RTestPackage<CR>
"map <tab> :call devtools#test_file()<CR>
"map <c-O> :call SwitchTestBuddy()<CR>
"map <c-E> :RCheckPackage<CR>

" Grep options
:let Grep_Skip_Dirs = '.git .Rproj.user'
if executable("rg")
  set grepprg=rg\ --vimgrep\ --smart-case\ --hidden
  set grepformat=%f:%l:%c:%m
endif

" SuperCollider Options
" =====================================
" Highlight the evaluated line
let g:scFlash = 1

" Remap the F5 and F6 to ones that work better for my keyboard since it's kind
" of awkward for me to type both fn and F{5,6} keys at the same time. I'm
" copying these directly from
" https://github.com/supercollider/scvim/blob/master/plugin/supercollider.vim

au Filetype supercollider nnoremap <leader>sc :call SClangStart()<CR>
au Filetype supercollider nnoremap <leader>b :call SendToSC('s.boot;')<CR>
au Filetype supercollider nnoremap <leader>t :call SendToSC('s.plotTree;')<CR>
au Filetype supercollider nnoremap <leader>m :call SendToSC('s.meter;')<CR>

" Sending a block of sc code <leader>f(eans)
" au Filetype supercollider inoremap <leader>f :call SClang_block()<CR>a
au Filetype supercollider nnoremap <leader>f :call SClang_block()<CR>
au Filetype supercollider vnoremap <leader>f :call SClang_send()<CR>

" Sending a single line is <Space>
au Filetype supercollider vnoremap <buffer> <Space> :call SClang_line()<CR>
au Filetype supercollider nnoremap <buffer> <Space> :call SClang_line()<CR>
" au Filetype supercollider inoremap <buffer> <Space> :call SClang_line()<CR>a

" Hardstop is <leader>x
au Filetype supercollider nnoremap <leader>x :call SClangHardstop()<CR>
