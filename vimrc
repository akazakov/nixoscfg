" UI {{{
set directory=$HOME/.vim_swap/
" Allow editing multiple buffers wihtout saving
set hidden
set colorcolumn=80
set modelines=10
set modeline
syntax enable
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab
set showcmd " Show command
"set cursorline
filetype indent on
set wildmenu " Visual autocomplete for command menu
set wildmode=longest:full,full
set lazyredraw " redraw only when necessary
set showmatch " Highlight matching parenthesis
" highlight last inserted text
nnoremap gV `[v`]
map Q :qa<CR>

" Always display the status line, even if only one window is displayed
set laststatus=2

" Use visual bell instead of beeping when doing something wrong
set visualbell

" Use <F11> to toggle between 'paste' and 'nopaste'
set pastetoggle=<F11>
" }}}
" SEARHCHING  {{{
set hlsearch
set incsearch
" turn off search highlight
nnoremap <leader><space> :nohlsearch<CR>
" }}}
" FOLDING {{{
set foldenable          " enable folding
set foldlevelstart=10   " open most folds by default
set foldnestmax=10      " 10 nested fold max
" space open/closes folds
nnoremap <space> za
set foldmethod=indent   " fold based on indent level
" }}}
" MOVING {{{
" move vertically by visual line
nnoremap j gj
nnoremap k gk
" }}}
" Laungage specific {{{
augroup configgroup
    autocmd!
    autocmd VimEnter * highlight clear SignColumn
    autocmd FileType java setlocal noexpandtab
    autocmd FileType java setlocal list
    autocmd FileType java setlocal listchars=tab:+\ ,eol:-
    autocmd FileType java setlocal formatprg=par\ -w80\ -T4
    autocmd FileType php setlocal expandtab
    autocmd FileType php setlocal list
    autocmd FileType php setlocal listchars=tab:+\ ,eol:-
    autocmd FileType php setlocal formatprg=par\ -w80\ -T4
    autocmd FileType ruby setlocal tabstop=2
    autocmd FileType ruby setlocal shiftwidth=2
    autocmd FileType ruby setlocal softtabstop=2
    autocmd FileType ruby setlocal commentstring=#\ %s
    autocmd FileType python setlocal commentstring=#\ %s
    autocmd FileType python setlocal tabstop=4
    autocmd FileType python setlocal softtabstop=4
    autocmd FileType python setlocal shiftwidth=4
    autocmd BufEnter *.cls setlocal filetype=java
    autocmd BufEnter *.zsh-theme setlocal filetype=zsh
    autocmd BufEnter Makefile setlocal noexpandtab
    autocmd BufEnter *.sh setlocal tabstop=2
    autocmd BufEnter *.sh setlocal shiftwidth=2
    autocmd BufEnter *.sh setlocal softtabstop=2
augroup END
" }}}

" Auto cmd {{{
"
" Remove all trailing space
autocmd BufWritePre * :%s/\s\+$//e
"autocmd FileType modula autocmd BufWritePre
set autoindent
set colorcolumn=80
au BufRead,BufNewFile *.md setlocal textwidth=80
" }}}


" Prevent opening a doc window when autocompleting
set completeopt=menu

"let g:solarized_visibility = "high"
"let g:solarized_contrast = "high"
"let g:solarized_termcolors = 256
"let g:solarized_termtrans = 1

set background=light
set backspace=2 " make backspace work like most other programs
colorscheme solarized
let g:vim_markdown_new_list_item_indent = 0
