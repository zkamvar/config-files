call plug#begin("~/.vim/plugged")

" Better status bar
Plug 'vim-airline/vim-airline'

" Clock for the status bar
Plug 'enricobacis/vim-airline-clock'

" Themes for that status bar
Plug 'vim-airline/vim-airline-themes'

" Buffers are now tabs
Plug 'fholgado/minibufexpl.vim'

" Commenting lines
Plug 'tpope/vim-commentary'

" Git for vim
Plug 'tpope/vim-fugitive'

" Paper color theme
Plug 'NLKNguyen/papercolor-theme'

" A lot of colorschemes
Plug 'daylerees/colour-schemes', { 'rtp': 'vim' }

" Monokai
Plug 'patstockwell/vim-monokai-tasty'

" Palenight color scheme
Plug 'drewtempelmeyer/palenight.vim'

" Another theme that is apparently unstable
Plug 'ayu-theme/ayu-vim'

" A muted color scheme
Plug 'nightsense/rusticated'

" Another muted color scheme that has bold colors
Plug 'yuttie/inkstained-vim'

" Nord color scheme
Plug 'arcticicestudio/nord-vim'

" NERD tree will be loaded on the first invocation of NERDTreeToggle command
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }

" Add git flags to nerdtree
Plug 'Xuyuanp/nerdtree-git-plugin'

" NvimR is the ESS of vim
Plug 'jalvesaq/Nvim-R'

" Plugin to work with Nvim-R that includes devtools
Plug 'mllg/vim-devtools-plugin'

" Gives me auto documentation with <leader>d
Plug 'kkoomen/vim-doge'

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

call plug#end()
" Global options
" ===============================================
set hidden " Allows for hidden buffers in the background
set cursorline " Highlights the current line
set number relativenumber " Number all the lines relative to cursor
set expandtab
set cc=81 " Set the color column at 81
set tabstop=2
set shiftwidth=2
set formatoptions=tcqr
" https://stackoverflow.com/a/11560415/2752888
set backspace=indent,eol,start " more powerful backspacing
" To change the hellacious CTRL-W to a much more wrist-friendly alternative
" https://vi.stackexchange.com/a/3729/18729
:nnoremap <Leader>w <C-w>
" Move visual selection
" J will move lines down, K will move lines up
vnoremap J :m '>+1<cr>gv=gv
vnoremap K :m '<-2<cr>gv=gv
" have vim save the backups in the /tmp/ directory, remembering the
" file path of the files
" https://stackoverflow.com/a/4824781/2752888
set backupdir=/tmp//
set directory=/tmp//

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
"
" Color Scheme Options
" ===============================================
set termguicolors " needed for ayucolor to work
let g:nord_italic = 1
let g:nord_underline = 1
let g:nord_italic_comments = 1
let g:vim_monokai_tasty_italic = 1
let g:palenight_terminal_italics = 1
let g:ayu_terminal_italics = 1
let ayucolor = "dark" " light,mirage

colorscheme PaperColor 
set background=dark
let g:airline_theme="molokai"

" Alignment options
" ===============================================
" align arrows in R
vnoremap <leader>tar :Align <-<CR><CR>
" align comments in bash/r/python/etc
vnoremap <leader>tac :Align #<CR><CR>

" DistractFree options
" ===============================================

let g:distractfree_width = '90' " 80 columns

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

" make sure the console is at the bottom
let R_rconsole_width = 80

" make sure the console is default of 20 lines high
" let R_rconsole_height = 20

" show arguments for functions during omnicompletion
let R_show_args = 1

" Don't expand a dataframe to show columns by default
let R_objbr_opendf = 0

" Maybe allow scrolling?
" let R_auto_scroll = 0

" Press the space bar to send lines and selection to R console
vmap <Space> <Plug>RDSendSelection
nmap <Space> <Plug>RDSendLine

" Mappings for devtools vim
map <c-L> :RLoadPackage<CR>
map <c-D> :RDocumentPackage<CR>
map <c-T> :RTestPackage<CR>
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
" On macOS, open a new terminal with iTerm
if has('mac')
  let g:sclangTerm = "open -n -a iTerm"
endif

