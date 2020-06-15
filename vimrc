set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'tpope/vim-sensible'
Plugin 'vimwiki/vimwiki'
Plugin 'junegunn/fzf'
Plugin 'junegunn/fzf.vim'
Plugin 'michal-h21/vim-zettel'
Plugin 'altercation/vim-colors-solarized'


" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
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
set termguicolors
colorscheme solarized

set tags=tags


" Settings for Vimwiki
let g:vimwiki_list = [{'path':'~/scratchbox/vimwiki/markdown/','ext':'.md','syntax':'markdown'}, {"path":"~/scratchbox/vimwiki/wiki/"}]

" Filename format. The filename is created using strftime() function
let g:zettel_format = "%y%m%d-%H%M-%title"
" command used for VimwikiSearch
" default value is "ag". To use other command, like ripgrep, pass the
" command line and options:
let g:zettel_fzf_command = "rg --column --line-number --ignore-case --no-heading --color=always "
" Disable default keymappings
let g:zettel_default_mappings = 0
" This is basically the same as the default configuration
augroup filetype_vimwiki
  autocmd!
  autocmd FileType vimwiki imap <silent> [[ [[<esc><Plug>ZettelSearchMap
  autocmd FileType vimwiki nmap T <Plug>ZettelYankNameMap
  autocmd FileType vimwiki xmap z <Plug>ZettelNewSelectedMap
  autocmd FileType vimwiki nmap gZ <Plug>ZettelReplaceFileWithLink
augroup END

" Set template and custom header variable for the second Wiki
let g:zettel_options = [{},{"front_matter" : {"tags" : ""}, "template" :  "~/.mytemplate.tpl"}]
