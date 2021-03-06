" ***************************************************
" Code to have cursor change for iterm and Tmux
" Copied from
" https://github.com/wincent/wincent/blob/eb089884f7d2c884e6d1214abdec35aa3b2adebc/.vim/plugin/term.vim#L23-L35
" Should move into plugin
" ***************************************************
" terminal defines
let s:iterm   = exists('$ITERM_PROFILE') || exists('$ITERM_SESSION_ID') || filereadable(expand("~/.vim/.assume-iterm"))
let s:tmux    = exists('$TMUX')

function! s:EscapeEscapes(string)
  " double each <Esc>
  return substitute(a:string, "\<Esc>", "\<Esc>\<Esc>", "g")
endfunction
 
function! s:TmuxWrap(string)
  if strlen(a:string) == 0
    return ""
  end

  let tmux_begin  = "\<Esc>Ptmux;"
  let tmux_end    = "\<Esc>\\"

  return tmux_begin . s:EscapeEscapes(a:string) . tmux_end
endfunction

" Change cursor shape depending on mode - ITerm2 on OSX support
if s:iterm
  let start_insert  = "\<Esc>]50;CursorShape=1\x7"
  let end_insert    = "\<Esc>]50;CursorShape=0\x7"

  if s:tmux
    let start_insert  = s:TmuxWrap(start_insert)
    let end_insert    = s:TmuxWrap(end_insert)
  endif

  let &t_SI = start_insert
  let &t_EI = end_insert
endif

" ****************************************************************
" End code for cursor change for iterm and Tmux
" ****************************************************************

set nocompatible              " be iMproved, required
filetype off                  " required

" Change mapleader
let mapleader=","

" Configure timeouts to make returning to normal mode faster
set timeoutlen=1000 ttimeoutlen=10


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
NeoBundle 'chriskempson/base16-vim'
NeoBundle 'vim-airline/vim-airline'
NeoBundle 'vim-airline/vim-airline-themes'
NeoBundle 'wavded/vim-stylus'
NeoBundle 'vim-scripts/Smart-Tabs'
NeoBundle 'scrooloose/syntastic'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'terryma/vim-multiple-cursors'
NeoBundle 'Shougo/vimfiler.vim'
NeoBundle 'christoomey/vim-tmux-navigator'
NeoBundle 'rizzatti/dash.vim'
NeoBundle 'kchmck/vim-coffee-script'
NeoBundle 'digitaltoad/vim-pug'
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
colorscheme base16-ocean
set guifont=Menlo\ for\ Powerline
set number
set showcmd
set list

" Set *.md files to use markdown instead of modula2 syntax highlighting
autocmd BufNewFile,BufReadPost *.md set filetype=markdown

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

" Specify location of backup and swap files
set backupdir=~/.vim/backup// 
set directory=~/.vim/swap//

" Persistent undo settings
set undodir=~/.vim/undodir/
set undofile
set undolevels=1000 "max number of changes that can be undone
set undoreload=10000 "max number lines to save for undo on a buffer reload

" ---- Unite settings ----
let g:unite_source_history_yank_enable = 1
nnoremap <space>y :Unite history/yank<cr>
nnoremap <C-p> :Unite file_rec/async<cr>
nnoremap <space>/ :Unite grep:.<cr>
nnoremap <space>s :Unite -quick-match buffer<cr>

" ---- vimfiler settings ----
:let g:vimfiler_as_default_explorer = 1

" ---- dash key bindings ----
:nmap <silent> <leader>d <Plug>DashSearch

" ---- scrooloose/syntastic settings ----
let g:syntastic_error_symbol = '✘'
let g:syntastic_warning_symbol = "▲"
augroup mySyntastic
  au!
  au FileType tex let b:syntastic_mode = "passive"
augroup END

" ---- airline settings ----
:let g:airline_theme='base16_default'
set laststatus=2
let g:airline_powerline_fonts = 1

" Show PASTE if in paste mode
" let g:airline_detect_paste=1

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


" Shortcuts to open file in web browser (Mac mapping"
nnoremap <F12>f :exe ':silent !open -a /Applications/FirefoxDeveloperEdition.app %'<CR>
nnoremap <F12>c :exe ':silent !open -a /Applications/Google\ Chrome.app %'<CR>
nnoremap <F12>g :exe ':silent !open -a /Applications/Google\ Chrome.app %'<CR>
nnoremap <F12>s :exe ':silent !open /Applications/Safari.app %'<CR>
