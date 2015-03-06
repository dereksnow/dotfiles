set nocompatible              " be iMproved, required
filetype off                  " required

" Change mapleader
let mapleader=","

" Note: Skip initialization for vim-tiny or vim-small.
if !1 | finish | endif

if has('vim_starting')
  if &compatible
    set nocompatible               " Be iMproved
  endif

  " Required:
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

" Required:
call neobundle#begin(expand('~/.vim/bundle/'))

" Let NeoBundle manage NeoBundle
" Required:
NeoBundleFetch 'Shougo/neobundle.vim'

" My Bundles here:
" Refer to |:NeoBundle-examples|.
" Note: You don't set neobundle setting in .gvimrc!
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'tpope/vim-commentary'
NeoBundle 'scrooloose/nerdcommenter'
NeoBundle 'maksimr/vim-jsbeautify'
NeoBundle 'altercation/vim-colors-solarized'
NeoBundle 'mattn/emmet-vim'
NeoBundle 'tpope/vim-surround'
NeoBundle 'git-mirror/vim-l9'
NeoBundle 'othree/vim-autocomplpop'
NeoBundle 'valloric/MatchTagAlways'
NeoBundle 'matchit.zip'
NeoBundle 'lilydjwg/colorizer'
NeoBundle 'bling/vim-airline'
NeoBundle 'wavded/vim-stylus'
NeoBundle 'vim-scripts/Smart-Tabs'
NeoBundle 'scrooloose/syntastic'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'terryma/vim-multiple-cursors'
NeoBundle 'Shougo/vimproc.vim', {
\ 'build' : {
\     'windows' : 'tools\\update-dll-mingw',
\     'cygwin' : 'make -f make_cygwin.mak',
\     'mac' : 'make -f make_mac.mak',
\     'linux' : 'make',
\     'unix' : 'gmake',
\    },
\ }

call neobundle#end()

" Required:
filetype plugin indent on

" If there are uninstalled bundles found on startup,
" this will conveniently prompt you to install them.
NeoBundleCheck

syntax enable
set background=dark
colorscheme solarized
set guifont=Menlo\ for\ Powerline
set number
set showcmd
set list

" map clipboard to unnamed register
set clipboard=unnamed

" shortcut to rapidly toggle 'set list'
nmap <leader>l :set list!<cr>

" use special symbols for tabstops and EOLs
set listchars=tab:▸\ ,eol:¬


" Tab width for Indentation
" Smart Tab plugin handles changes tabs to spaces for alignment
set shiftwidth=2
set tabstop=2

" Persistent undo settings
set undodir=~/.vim/undodir
set undofile
set undolevels=1000 "max number of changes that can be undone
set undoreload=10000 "max number lines to save for undo on a buffer reload

" ---- Unite setting ----
let g:unite_source_history_yank_enable = 1
nnoremap <space>y :Unite history/yank<cr>
nnoremap <C-p> :Unite file_rec/async<cr>
nnoremap <space>/ :Unite grep:.<cr>
nnoremap <space>s :Unite -quick-match buffer<cr>

" ---- scrooloose/syntastic settings ----
let g:syntastic_error_symbol = '✘'
let g:syntastic_warning_symbol = "▲"
augroup mySyntastic
  au!
  au FileType tex let b:syntastic_mode = "passive"
augroup END

" ---- airline settings ----
set laststatus=2
let g:airline_powerline_fonts = 1

" Show PASTE if in paste mode
let g:airline_detect_paste=1

" Show airline for tabs too 
let g:airline#extensions#tabline#enabled = 1 

:nnoremap ,cd :cd %:p:h<CR>:pwd<CR>

" HTML , CSS, JS Formatting using maksimr-jsbeutify
map <c-f> :call JsBeautify()<cr>
" or
autocmd FileType javascript noremap <buffer>  <c-f> :call JsBeautify()<cr>
" for html
autocmd FileType html noremap <buffer> <c-f> :call HtmlBeautify()<cr>
" for css or scss
autocmd FileType css noremap <buffer> <c-f> :call CSSBeautify()<cr>
