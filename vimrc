set nocompatible
filetype off

call plug#begin('~/.vim/plugged')
Plug 'nvie/vim-flake8'
Plug 'scrooloose/syntastic'
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
Plug 'vim-airline/vim-airline'
" Plug 'scrooloose/nerdtree'
call plug#end()


filetype plugin indent on

" Skeleton files
au BufNewFile *.py 0r ~/vim_skeleton_files/py.skel | let IndentStyle = "py"

" Use line numbers
set number

" Highlight search results
set hlsearch

"Allow mouse scrolling"
set mouse=a

" Use Syntax
syntax on
color dracula
set cursorline

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

" Navigate buffers
nnoremap <silent> [b :bprevious <CR>
nnoremap <silent> ]b :bnext <CR>
nnoremap <silent> [B :bfirst <CR>
nnoremap <silent> ]B :blast <CR>

" Search highlight
nnoremap <F8> :let @/='\<<C-R>=expand("<cword>")<CR>\>'<CR>:set hls<CR>
nnoremap <CR> :nohlsearch<CR><CR>

" Browsing files shortcuts
nnoremap <silent> <Leader>b :Buffers<CR>
nnoremap <silent> <Leader>f :Files<CR>
nnoremap <silent> <Leader>e :Ex<CR>

" Syntax highlight
nnoremap <F9> :SyntasticToggleMode<CR>


" For auto setting paste/nopaste
let &t_SI .= "\<Esc>[?2004h"
let &t_EI .= "\<Esc>[?2004l"
inoremap <special> <expr> <Esc>[200~ XTermPasteBegin()
function! XTermPasteBegin()
  set pastetoggle=<Esc>[201~
  set paste
  return ""
endfunction


"
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
autocmd FileType python setlocal textwidth=79 shiftwidth=4 tabstop=4 expandtab softtabstop=4 shiftround autoindent   

" Java
autocmd FileType java setlocal omnifunc=javacomplete#Complete shiftwidth=4 tabstop=4 expandtab softtabstop=4 shiftround autoindent

" Scala
"autocmd FileType scala setlocal shiftwidth=2 tabstop=2 expandtab softtabstop=2 shiftround autoindent
"autocmd BufWritePost *.scala silent :EnTypeCheck
let g:syntastic_scala_checkers = ['ensime']
nnoremap <silent> <Leader>t :EnType<CR>
nnoremap <silent> <Leader>s :EnTypeCheck<CR>
nnoremap <silent> <Leader>d :EnDeclaration<CR>


" yaml
autocmd FileType yaml setlocal shiftwidth=4 tabstop=4 expandtab softtabstop=4 shiftround autoindent
