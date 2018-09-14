call plug#begin("~/.vim/plugged")

" Better status bar
Plug 'vim-airline/vim-airline'

" Buffers are now tabs
Plug 'fholgado/minibufexpl.vim'

" Palenight color scheme
Plug 'drewtempelmeyer/palenight.vim'

" Another theme that is apparently unstable
Plug 'ayu-theme/ayu-vim'

" A muted color scheme
Plug 'nightsense/rusticated'

" Another muted color scheme that has bold colors
Plug 'yuttie/inkstained-vim'

" NERD tree will be loaded on the first invocation of NERDTreeToggle command
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }

" Add git flags to nerdtree
Plug 'Xuyuanp/nerdtree-git-plugin'

" NvimR is the ESS of vim
Plug 'jalvesaq/Nvim-R'

" Plugin to work with Nvim-R that includes devtools
Plug 'mllg/vim-devtools-plugin'

" Pandoc syntax for Rmarkdown
Plug 'vim-pandoc/vim-pandoc-syntax'

" Syntax checker
Plug 'vim-syntastic/syntastic'

" Access grep from vim without moving to command line
Plug 'yegappan/grep'

" SuperCollider Audio Synthesis vim integration
Plug 'supercollider/scvim'

call plug#end()
" Global options
" ===============================================
set hidden " Allows for hidden buffers in the background
set cursorline " Highlights the current line
set number " Number all the lines
set cc=81 " Set the color column at 81
set tabstop=2
set shiftwidth=2
set expandtab
"
" Color Scheme Options
" ===============================================
set termguicolors " needed for ayucolor to work
let ayucolor="light"  " for light version of theme
" let ayucolor="mirage" " for mirage version of theme
" let ayucolor="dark"   " for dark version of theme
colorscheme inkstained
let g:airline_theme='rusticated'
" colorscheme ayu
" set background=dark
" colorscheme palenight


" Italics for my favorite color scheme
let g:palenight_terminal_italics=1
let g:ayu_terminal_italics=1
" NERD Tree options
" ===============================================
"
" Mapping ctrl+n to toggle file tree
map <c-m> :NERDTreeToggle<CR>
" map <C-M> :NERDTreeClose<CR>
" 
" Show Hidden files
let NERDTreeShowHidden=1

" settings :: Nvim-R plugin
" ===============================================
"
" Default arguments on start
let R_args = ['--no-save', '--no-restore']

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
let R_rconsole_width = 0

" make sure the console is default of 20 lines high
let R_rconsole_height = 20

" show arguments for functions during omnicompletion
let R_show_args = 1

" Don't expand a dataframe to show columns by default
let R_objbr_opendf = 0

" Maybe allow scrolling?
let R_auto_scroll = 0

" Press the space bar to send lines and selection to R console
vmap <Space> <Plug>RDSendSelection
nmap <Space> <Plug>RDSendLine

" Syntastic Options
" =====================================
let g:syntastic_enable_r_lintr_checker = 1
let g:syntastic_r_checkers = ['lintr']
" warn if line lengths are just too ridiculous
let g:syntastic_r_lintr_linters = "with_defaults(line_length_linter(120))"

" Grep options
:let Grep_Skip_Dirs = '.git .Rproj.user'

" SuperCollider Options
" =====================================
" Highlight the evaluated line
let g:scFlash = 1

" On macOS, open a new terminal with iTerm
if has('mac')
	let g:sclangTerm = "open -n -a iTerm"
endif

