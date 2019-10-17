set nocompatible
"dein Scripts-----------------------------
set runtimepath+=$HOME/.cache/dein/repos/github.com/Shougo/dein.vim
if dein#load_state('~/.cache/dein')
  call dein#begin('~/.cache/dein')
  " Let dein manage dein
  call dein#add('~/.cache/dein/repos/github.com/Shougo/dein.vim')

  call dein#add('tpope/vim-surround')
  call dein#add('tpope/vim-ragtag')
  call dein#add('junegunn/fzf.vim')

  " golang
  call dein#add('fatih/vim-go')

  " typescript
  call dein#add('HerringtonDarkholme/yats.vim')


  " Required:
  call dein#end()
  call dein#save_state()
endif
"End dein Scripts-------------------------

" sane defaults
filetype plugin indent on
syntax enable
set shiftwidth=2 softtabstop=2 tabstop=2
set expandtab
set smartindent
set hlsearch
set encoding=utf8 fileencoding=utf8
set isk+=_,- " those chars is not word separators!
set autoindent
set ignorecase
set smartcase
set number
set backspace=indent,eol,start
" always show 1 line above cursor
set scrolloff=2
set sidescrolloff=5
" forever undo
set undofile
set undodir=~/.config/nvim/undo
" show trailing whitespaces
set listchars=tab:\ \ ,trail:✖
set list

set background=dark
colorscheme solarized
let mapleader=","

" FZF configuration
set rtp+=~/.fzf
let $FZF_DEFAULT_COMMAND = 'find . -type f -not -path "*/\.*" -not -path "*/node_modules/*" -not -path "*/vendor/*" -not -iname "*.class"'
nmap <Leader>t :FZF<Cr>
let g:fzf_buffers_jump = 1

" fzf (rg) grep with nice list
nmap <Leader>r :Rg <C-r><C-w><Cr>

nmap <Leader>w :%s/<C-r><C-w>/

" vim-surround
xmap s <Plug>VSurround

" ragtag
let g:ragtag_global_maps = 1

au BufEnter,BufRead,BufNewFile *.py,*.java,*.erl,*.rs,*.c set shiftwidth=4 softtabstop=4 tabstop=4

" jump to tag
nmap <Leader>d <c-]>
" jump back
nmap <Leader>g <c-o>

nmap <Leader>m :! make<Cr>
nmap <Leader>n :! make test<Cr>


" golang stuff
au FileType go nmap <Leader>f :GoImports<Cr>:GoFmt<Cr>:GoLint .<Cr>
au BufEnter,BufRead,BufNewFile *.go set noexpandtab tabstop=4 shiftwidth=4
let g:go_highlight_build_constraints = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_operators = 1
let g:go_highlight_structs = 1
let g:go_highlight_types = 1
let g:go_auto_sameids = 1
