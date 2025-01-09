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

" Catpuccin
Plug 'catppuccin/nvim', { 'branch': 'main', 'as': 'catppuccin' }

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

" Requirement for bash server
Plug 'prabirshrestha/vim-lsp'
if executable('bash-language-server')
  au User lsp_setup call lsp#register_server({
        \ 'name': 'bash-language-server',
        \ 'cmd': {server_info->['bash-language-server', 'start']},
        \ 'allowlist': ['sh', 'bash'],
        \ })
endif
if executable('rustup')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'rust-analyzer',
        \ 'cmd': {server_info->['rustup', 'run', 'stable', 'rust-analyzer']},
        \ 'allowlist': ['rust'],
        \ })
endif

" rust vim is the official plugin for rust
Plug 'rust-lang/rust.vim'

" webapi connection to help with rust playground
Plug 'mattn/webapi-vim'

" NvimR is the ESS of vim
" Plug 'jalvesaq/Nvim-R' ", {'branch': 'stable'}
" NOTE: 2025-01-09: R.Nvim started breaking today. Reverting to a previous
" commit helped it stop breaking
Plug 'R-Nvim/R.Nvim', {'branch': 'main'}
" Plug 'R-Nvim/R.Nvim', {'commit': '90d9226daa9bbafa33dc6416167a4db969699f20'}
" Plug 'R-Nvim/R.Nvim', {'commit': '75146be5d2c78575cb0aa69705d2ab4dbace3849'}
Plug 'R-nvim/cmp-r', {'branch': 'main'}
Plug 'hrsh7th/nvim-cmp', {'branch': 'main'}
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}


" Plugin to work with Nvim-R that includes devtools
Plug 'mllg/vim-devtools-plugin'

" Pandoc syntax for Rmarkdown
Plug 'vim-pandoc/vim-pandoc-syntax'

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

