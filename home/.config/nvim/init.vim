set nocompatible
"dein Scripts-----------------------------
set runtimepath+=/home/user/.cache/dein/repos/github.com/Shougo/dein.vim
if dein#load_state('/home/user/.cache/dein')
  call dein#begin('/home/user/.cache/dein')
  " Let dein manage dein
  call dein#add('/home/user/.cache/dein/repos/github.com/Shougo/dein.vim')
  " Add or remove your plugins here like this:
  "call dein#add('Shougo/neosnippet.vim')
  "call dein#add('Shougo/neosnippet-snippets')
  call dein#add('tpope/vim-surround')
  call dein#add('rust-lang/rust.vim')
  call dein#add('racer-rust/vim-racer')
  call dein#add('fatih/vim-go')
  call dein#add('udalov/kotlin-vim')
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

colorscheme solarized
set background=dark

au BufEnter,BufRead,BufNewFile *.inc setf php
au BufEnter,BufRead,BufNewFile *.thor,Rakefile,*.rake,Capfile,Guardfile,*.ru,Vagrantfile setf ruby
au BufEnter,BufRead,BufNewFile *.ts setf typescript
au BufEnter,BufRead,BufNewFile *.less setf css
au BufEnter,BufRead,BufNewFile *.scss setf scss
au BufRead,BufNewFile *.handlebars,*.hbs set ft=html syntax=handlebars
au BufEnter,BufRead,BufNewFile *.py,*.java,*.erl,*.rs set shiftwidth=4 softtabstop=4 tabstop=4
au BufEnter,BufRead,BufNewFile *.go set noexpandtab tabstop=4 shiftwidth=4

" while working with gcloud deployment-manager
au BufRead,BufNewFile *.jinja set ft=yaml

let mapleader=","
nmap <Leader>d <c-]>
nmap <Leader>f <c-o>

" show trailing whitespaces
set listchars=tab:\ \ ,trail:✖
set list

" vim-surround
xmap s   <Plug>VSurround

" rust stuff
set hidden
let g:racer_cmd = "/home/user/.cargo/bin/racer"
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

" fzf configuration
set rtp+=~/.fzf
let $FZF_DEFAULT_COMMAND = 'rg --files .'
nmap <Leader>t :FZF<Cr>

" use deoplete
let g:deoplete#enable_at_startup = 1

" extra escape when esc, or esc mapping is missin
imap <C-L> <Esc>
