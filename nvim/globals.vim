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
augroup pandoc_syntax
    au! BufNewFile,BufFilePre,BufRead *.qmd set filetype=markdown.pandoc
    au! BufNewFile,BufFilePre,BufRead *.Rmd set filetype=markdown.pandoc
    au! BufNewFile,BufFilePre,BufRead *.md set filetype=markdown.pandoc
    au! BufNewFile,BufFilePre,BufRead *.markdown set filetype=markdown.pandoc
augroup END

" Copy to clipboard
" https://stackoverflow.com/a/15971506/2752888
if has('mac')
  vnoremap <C-c> :w !pbcopy<CR><CR>
  let g:rust_clip_command = 'pbcopy'
else
  vnoremap <C-C> :w !xclip -i -sel c<CR><CR>
  let g:rust_clip_command = 'xclip -selection clipboard'
endif

" Use Ctrl+Space to do omnicompletion:
if has('nvim') || has('gui_running')
  inoremap <C-Space> <C-x><C-o>
else
  inoremap <Nul> <C-x><C-o>
endif
" https://stackoverflow.com/a/33358103/2752888
set mouse=a

