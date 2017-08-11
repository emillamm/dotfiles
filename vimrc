set nocompatible
filetype off

call plug#begin('~/.vim/plugged')
Plug 'nvie/vim-flake8'
"Plug 'scrooloose/syntastic'
Plug 'Valloric/YouCompleteMe', { 'do': './install.py' }
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'derekwyatt/vim-scala'
Plug 'artur-shaik/vim-javacomplete2'
Plug 'kana/vim-arpeggio'
Plug 'jeffkreeftmeijer/vim-numbertoggle'
Plug 'ensime/ensime-vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'majutsushi/tagbar'
Plug 'craigemery/vim-autotag'
Plug 'tpope/vim-dispatch'
Plug 'skywind3000/asyncrun.vim'
Plug 'junegunn/seoul256.vim'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'
Plug 'vim-airline/vim-airline'
Plug 'milkypostman/vim-togglelist'
"Plug 'scrooloose/nerdtree'
call plug#end()

let vimdir = '$HOME/.vim'
filetype plugin indent on

" YCM
let g:ycm_path_to_python_interpreter="/usr/local/bin/python"

" Skeleton files
au BufNewFile *.py 0r ~/vim_skeleton_files/py.skel | let IndentStyle = "py"

" Use line numbers
set number

" Highlight search results
set hlsearch

"Allow mouse scrolling"
set mouse=a

" Syntax and color
syntax on
"colo paramount
"colo dracula
"set cursorline
colo seoul256
set background=dark

" Enable delete in insert mode
set backspace=indent,eol,start

" No Backup
set noswapfile

" Status line
set laststatus=2

" Window command on fw
call arpeggio#map('n', '', 0, 'fw', '<C-W>')

" Escape on jk
call arpeggio#map('i', '', 0, 'jk', '<Esc>')

" Save on io
call arpeggio#map('n', '', 0, 'io', ':w<CR>')

" Save and compile on io
call arpeggio#map('n', '', 0, 'ui', ':w<CR>:AsyncRun -program=make<CR>')

" Buffers
nnoremap <silent> [b :bprevious <CR>
nnoremap <silent> ]b :bnext <CR>
nnoremap <silent> [B :bfirst <CR>
nnoremap <silent> ]B :blast <CR>

" Quickfix
nnoremap ]q :cnext<cr>
nnoremap [q :cprev<cr>
nnoremap ]l :lnext<cr>
nnoremap [l :lprev<cr>

" Search highlight
nnoremap <F8> :let @/='\<<C-R>=expand("<cword>")<CR>\>'<CR>:set hls<CR>
nnoremap <silent><CR> :nohlsearch<CR><CR>

" Misc leader shortcuts
nnoremap <silent> <Leader>b :Buffers<CR>
nnoremap <silent> <Leader>f :Files<CR>
nnoremap <silent> <Leader>e :Ex<CR>
vnoremap <silent> <Leader>c "*y<CR>
nnoremap <silent> <Leader>q :call ToggleQuickfixList()<CR>
nnoremap <silent> <Leader>l :call ToggleLocationList()<CR>

" Navigational leader shortcuts
nnoremap <silent> <Space>f F
nnoremap <silent> <Space>t T
nnoremap <silent> <Space>d D
nnoremap <silent> <Space>4 $
nnoremap <silent> <Space>5 %
nnoremap <silent> <Space>6 ^
nnoremap <silent> <Space>8 *

" Syntax highlight
nnoremap <F9> :SyntasticToggleMode<CR>

if has('persistent_undo')
  let undodirname = expand(vimdir . '/undo')
  call system('mkdir ' . undodirname)
  let &undodir = undodirname 
  set undofile
  set undolevels=1000
  set undoreload=10000
endif

" For auto setting paste/nopaste
let &t_SI .= "\<Esc>[?2004h"
let &t_EI .= "\<Esc>[?2004l"
inoremap <special> <expr> <Esc>[200~ XTermPasteBegin()
function! XTermPasteBegin()
  set pastetoggle=<Esc>[201~
  set paste
  return ""
endfunction

" FileTypes
" textwidth=79   lines longer than 79 columns will be broken
" shiftwidth=4   operation >> indents 4 columns; << unindents 4 columns
" tabstop=4      a hard TAB displays as 4 columns
" expandtab      insert spaces when hitting TABs
" softtabstop=4  insert/delete 4 spaces when hitting a TAB/BACKSPACE
" shiftround     round indent to multiple of 'shiftwidth'
" autoindent     align the new line indent with the previous line
 
" JavaScript
autocmd FileType javascript setlocal shiftwidth=2 tabstop=2 expandtab softtabstop=2 shiftround autoindent

" JSON
autocmd FileType json setlocal shiftwidth=2 tabstop=2 expandtab softtabstop=2 shiftround autoindent

" JSX (JavaScript)
autocmd FileType javascript.jsx setlocal shiftwidth=2 tabstop=2 expandtab softtabstop=2 shiftround autoindent

" Python (from http://docs.python-guide.org/en/latest/dev/env/)
autocmd FileType python setlocal shiftwidth=4 tabstop=4 expandtab softtabstop=4 shiftround autoindent   

" Java
autocmd FileType java setlocal omnifunc=javacomplete#Complete shiftwidth=4 tabstop=4 expandtab softtabstop=4 shiftround autoindent

"" Scala
"let g:syntastic_scala_checkers = ['ensime']
"nnoremap <silent> <Leader>t :EnType<CR>
"nnoremap <silent> <Leader>s :EnTypeCheck<CR>
"nnoremap <silent> <Leader>d :EnDeclaration<CR>
autocmd FileType scala setlocal makeprg=./.make
autocmd FileType scala setlocal efm=%*[^/]%f:%l:\ %m,%f:%l:\ %m
let g:airline_section_error = airline#section#create_right(['%{g:asyncrun_status}'])

" yaml
autocmd FileType yaml setlocal shiftwidth=4 tabstop=4 expandtab softtabstop=4 shiftround autoindent
