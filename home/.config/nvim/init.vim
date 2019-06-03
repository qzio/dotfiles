set nocompatible
"dein Scripts-----------------------------
set runtimepath+=$HOME/.cache/dein/repos/github.com/Shougo/dein.vim
if dein#load_state('~/.cache/dein')
  call dein#begin('~/.cache/dein')
  " Let dein manage dein
  call dein#add('~/.cache/dein/repos/github.com/Shougo/dein.vim')
  " Add or remove your plugins here like this:
  "call dein#add('Shougo/neosnippet.vim')
  "call dein#add('Shougo/neosnippet-snippets')
  call dein#add('tpope/vim-surround')
  call dein#add('tpope/vim-ragtag')
  call dein#add('posva/vim-vue')
  call dein#add('rust-lang/rust.vim')
  call dein#add('racer-rust/vim-racer')
  call dein#add('fatih/vim-go')

  call dein#add('udalov/kotlin-vim')
  " typescript syntax highlightning
  call dein#add('HerringtonDarkholme/yats.vim')
  "jsonnet highlightning
  call dein#add('google/vim-jsonnet')
  call dein#add('junegunn/fzf.vim')

  call dein#add('Shougo/deoplete.nvim')
  "call dein#add('zchee/deoplete-go', {'build': 'make'})
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
set scrolloff=2
set sidescrolloff=5

set undofile
set undodir=~/.config/nvim/undo

set background=dark
colorscheme solarized
"colorscheme default

au BufEnter,BufRead,BufNewFile *.inc setf php
au BufEnter,BufRead,BufNewFile *.thor,Rakefile,*.rake,Capfile,Guardfile,*.ru,Vagrantfile setf ruby
au BufEnter,BufRead,BufNewFile *.ts setf typescript
au BufEnter,BufRead,BufNewFile *.less setf css
au BufEnter,BufRead,BufNewFile *.scss setf scss
au BufEnter,BufRead,BufNewFile *.handlebars,*.hbs set ft=html syntax=handlebars
au BufEnter,BufRead,BufNewFile *.py,*.java,*.erl,*.rs set shiftwidth=4 softtabstop=4 tabstop=4
au BufEnter,BufRead,BufNewFile *.go set noexpandtab tabstop=4 shiftwidth=4
au BufEnter,BufRead,BufNewFile *.jinja set ft=yaml
au BufEnter,BufRead,BufNewFile *.* set shiftwidth=2 softtabstop=2 tabstop=2

let mapleader=","
" jump to tag
nmap <Leader>d <c-]>
" jump back
nmap <Leader>g <c-o>

nmap <Leader>m :! make<Cr>
nmap <Leader>r :! make run<Cr>
nmap <Leader>n :! make test<Cr>

" show trailing whitespaces
set listchars=tab:\ \ ,trail:✖
set list

" vim-surround
xmap s   <Plug>VSurround

" rust stuff
set hidden
"let g:racer_cmd = "/home/jh/.cargo/bin/racer"
let g:racer_cmd = "racer"
let g:racer_experimental_completer = 1
au FileType rust nmap <Leader>d <Plug>(rust-def)
au FileType rust nmap <Leader>f :RustFmt<Cr>

" golang stuff
au FileType go nmap <Leader>f :GoFmt<Cr>:GoLint .<Cr>
let g:go_highlight_build_constraints = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_operators = 1
let g:go_highlight_structs = 1
let g:go_highlight_types = 1
let g:go_auto_sameids = 1
let g:go_fmt_command = "goimports"

" fzf configuration (fuzzy find files)
set rtp+=~/.fzf
let $FZF_DEFAULT_COMMAND = 'find . -type f -not -path "*/\.*" -not -iname "*.class"'
nmap <Leader>t :FZF<Cr>
" fzf (rg) grep with nice list
nmap <Leader>r :Rg <C-r><C-w><Cr>

nmap <Leader>w :%s/<C-r><C-w>/

nmap <Leader>e iif err != nil {<Cr>}<Esc>O

" use deoplete
let g:deoplete#enable_at_startup = 1
set completeopt-=preview

" extra escape when esc, or esc mapping is missin
imap <C-L> <Esc>
let g:ragtag_global_maps = 1

" test remap to allow backticks on ipad keyboard
imap § `
