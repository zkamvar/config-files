if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin("~/.vim/plugged")

" Better status bar
Plug 'vim-airline/vim-airline'

" Clock for the status bar
Plug 'enricobacis/vim-airline-clock'

" Themes for that status bar
Plug 'vim-airline/vim-airline-themes'

" Commenting lines
Plug 'tpope/vim-commentary'

" Git for vim
Plug 'tpope/vim-fugitive'

" Paper color theme
Plug 'NLKNguyen/papercolor-theme'

" NERD tree will be loaded on the first invocation of NERDTreeToggle command
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }

" Add git flags to nerdtree
Plug 'Xuyuanp/nerdtree-git-plugin'

" Add git gutter to files
if has('nvim') || has('patch-8.0.902')
  Plug 'mhinz/vim-signify'
else
  Plug 'mhinz/vim-signify', { 'branch': 'legacy' }
endif

" NvimR is the ESS of vim
Plug 'jalvesaq/Nvim-R', {'branch': 'stable'}

" Plugin to work with Nvim-R that includes devtools
Plug 'mllg/vim-devtools-plugin'

" Pandoc syntax for Rmarkdown
Plug 'vim-pandoc/vim-pandoc-syntax'

" Access grep from vim without moving to command line
Plug 'yegappan/grep'

" SuperCollider Audio Synthesis vim integration
Plug 'supercollider/scvim'

" Aligning assignment operators
" https://stackoverflow.com/q/16522235/2752888
Plug 'vim-scripts/Align'

" hybrid relative line numbers
" https://jeffkreeftmeijer.com/vim-number/
Plug 'jeffkreeftmeijer/vim-numbertoggle'

" context-aware scrolling for looooong nested elements
Plug 'wellle/context.vim'

" zen mode for vim
Plug 'junegunn/goyo.vim'

" dim all but current section when writing
Plug 'junegunn/limelight.vim'

" editorconfig file support
Plug 'editorconfig/editorconfig-vim'

" View ANSI colors in vim
Plug 'chrisbra/Colorizer'

" Indentation guides
Plug 'nathanaelkane/vim-indent-guides'

call plug#end()

" Global options
" ===============================================
set hidden " Allows for hidden buffers in the background
set cursorline " Highlights the current line
set number relativenumber " Number all the lines relative to cursor
set expandtab " Use spaces for tabs
set cc=81 " Set the color column at 81
set tabstop=2
set shiftwidth=2
set formatoptions=tcqr
    " t auto-wrap text
    " c auto-wrap commetns
    " q allow comments to wrap
    " r auto-continue comment lines
" https://stackoverflow.com/a/11560415/2752888
set list " Display unprintable characters f12 - switches
set listchars=tab:<->,trail:•,extends:»,precedes:« " Unprintable chars mapping
set backspace=indent,eol,start " more powerful backspacing
" To change the hellacious CTRL-W to a much more wrist-friendly alternative
" https://vi.stackexchange.com/a/3729/18729
:nnoremap <Leader>w <C-w>
" Give me a testthat snippet
autocmd Filetype r :iabbrev tt <CR>test_that("", {<CR><CR>})<CR><UP><UP><UP><esc>wll
" Move visual selection
" J will move lines down, K will move lines up
vnoremap J :m '>+1<cr>gv=gv
vnoremap K :m '<-2<cr>gv=gv
" have vim save the backups in the /tmp/ directory, remembering the
" file path of the files
" https://stackoverflow.com/a/4824781/2752888
set backupdir=~/.vim/tmp//
set directory=~/.vim/tmp//

" Copy to clipboard
" https://stackoverflow.com/a/15971506/2752888
if has('mac')
  vnoremap <C-c> :w !pbcopy<CR><CR>
else
  vnoremap <C-C> :w !xclip -i -sel c<CR><CR>
endif

" Use Ctrl+Space to do omnicompletion:
if has('nvim') || has('gui_running')
  inoremap <C-Space> <C-x><C-o>
else
  inoremap <Nul> <C-x><C-o>
endif
" https://stackoverflow.com/a/33358103/2752888
set mouse=a

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
  if system("(kitty @ get-colors | grep '^foreground ') || echo NONE") =~ '414141'
    set background=light  " for the light version of the theme
  else
    set background=dark   " for the dark version of the theme
  endif
  colorscheme PaperColor

  try
    execute "AirlineRefresh"
  catch
  endtry
  try
    call SyncSignColumn()
  catch
  endtry
endfunction

let g:airline_theme="papercolor"
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
map <c-m> :NERDTreeToggle<CR>
" Show Hidden files
let NERDTreeShowHidden=1

" settings :: Nvim-R plugin
" ===============================================
" This searches if radian (an enhanced client for R) is installed
" https://github.com/randy3k/radian
if executable('radian')
  let R_app = "radian"
  let R_cmd = "R"
  let R_hl_term = 0
  let R_args = []
  let R_bracketed_paste = 1
else
  " Default arguments on start
  let R_args = ['--no-save', '--no-restore']
endif

" Let me have my snake case :}~~<
let R_assign = 0

" R output is highlighted with current colorscheme
let g:rout_follow_colorscheme = 1
"
" R commands in R output are highlighted
let g:Rout_more_colors = 1

" set a minimum source editor width
let R_min_editor_width = 80

" set the working directory to be vim's working directory
let R_nvim_wd = 1

" make sure the console is at the bottom
let R_rconsole_width = winwidth(0) / 2
autocmd VimResized * let R_rconsole_width = winwidth(0) / 2

" Don't expand a dataframe to show columns by default
let R_objbr_opendf = 0

" disable annoying arg indent
let r_indent_align_args = 0

" Press the space bar to send lines and selection to R console
vmap <Space> <Plug>RDSendSelection
nmap <Space> <Plug>RDSendLine

" Switch between file and test
function! SwitchTestBuddy()
  let f = expand('%:t')
  if expand('%:p:h:t') == 'testthat'
    execute ':edit R/'..substitute(f, 'test-', '', '')
  else
    execute ':edit tests/testthat/test-'..f
  endif
endfunction

" Mappings for devtools vim
map <c-L> :RLoadPackage<CR>
map <c-D> :RDocumentPackage<CR>
map <c-T> :RTestPackage<CR>
map <c-I> :call devtools#test_file()<CR>
map <c-O> :call SwitchTestBuddy()<CR>
map <c-E> :RCheckPackage<CR>

" Grep options
:let Grep_Skip_Dirs = '.git .Rproj.user'

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
