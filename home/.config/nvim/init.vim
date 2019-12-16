set nocompatible

" custom functions etc -------------------
function! SourceLocal(file)
  if filereadable(expand(a:file))
    exe 'source' a:file
  endif
endfunction

" dein Scripts-----------------------------
set runtimepath+=$HOME/.cache/dein/repos/github.com/Shougo/dein.vim
if dein#load_state('~/.cache/dein')
  call dein#begin('~/.cache/dein')
  " Let dein manage dein
  call dein#add('~/.cache/dein/repos/github.com/Shougo/dein.vim')

  call dein#add('tpope/vim-surround')
  call dein#add('tpope/vim-ragtag')
  call dein#add('junegunn/fzf.vim')
  call dein#add('cespare/vim-toml')

  " golang
  call dein#add('fatih/vim-go')

  " javascript
  call dein#add('othree/yajs.vim')
  " typescript
  call dein#add('HerringtonDarkholme/yats.vim')
  call dein#add('mhartington/nvim-typescript', {'build': './install.sh'})

  " lsp
  call dein#add('dense-analysis/ale')

  " auto completion
  "call dein#add('Shougo/deoplete.vim')

  call dein#add('challenger-deep-theme/vim', {'name': 'challenger-deep'})

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
colorscheme challenger_deep

" FZF configuration
set rtp+=~/.fzf
let $FZF_DEFAULT_COMMAND = 'find . -type f -not -path "*/\.*" -not -path "*/node_modules/*" -not -path "*/vendor/*" -not -iname "*.class"'
let g:fzf_buffers_jump = 1

" deoplete
let g:deoplete#enable_at_startup = 0

" ragtag
let g:ragtag_global_maps = 1

" ale
let g:ale_completion_enabled = 1
let g:ale_virtualtext_cursor = 1
let g:ale_virtualtext_delay = 400
let g:ale_sign_error = '✖'
let g:ale_sign_warning = '⚠'
let g:ale_go_bingo_executable = 'gopls'

" vim-go
let g:go_def_mode='gopls'
let g:go_info_mode='gopls'

" vim-surround
xmap s <Plug>VSurround

" short cut mapptings
let mapleader=","

" fzf (rg) grep with nice list
nmap <Leader>r :Rg <C-r><C-w><Cr>
" search/replace in file
nmap <Leader>w :%s/<C-r><C-w>/
" open file search
nmap <Leader>t :FZF<Cr>


" jump to tag
nmap <Leader>d <c-]>
" jump back
nmap <Leader>g <c-o>

nmap <Leader>m :! make<Cr>
nmap <Leader>n :! make test<Cr>
nmap <Leader>j :! make run<Cr>


" generic indention standard
au BufEnter,BufRead,BufNewFile *.* set shiftwidth=2 softtabstop=2 tabstop=2 expandtab
au BufEnter,BufRead,BufNewFile *.py,*.java,*.erl,*.rs,*.c set shiftwidth=4 softtabstop=4 tabstop=4

" golang
au FileType go nmap <Leader>f :GoImports<Cr>:GoFmt<Cr>:GoLint .<Cr>
au FileType go nmap <Leader>b :GoBuild<Cr>
au FileType go nmap <Leader>v :GoTest<Cr>
" faster :GoImplements using ripgrep
au FileType go nmap <Leader>c :Rg func \(.[^)]*\) <C-r><C-w>\(<Cr>
au BufEnter,BufRead,BufNewFile *.go set noexpandtab tabstop=4 shiftwidth=4
let g:go_highlight_build_constraints = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_operators = 1
let g:go_highlight_structs = 1
let g:go_highlight_types = 1
let g:go_auto_sameids = 0

" node/javascript/typescript
au BufEnter,BufRead,BufNewFile *.ts setf typescript
au BufReadPost *.svelte setf html
au FileType typescript,typescriptreact nmap <Leader>d :ALEGoToDefinition<Cr>
au FileType typescript nmap <Leader>f :ALEFix<Cr>
let g:ale_linters = {'typescript': ['tsserver', 'tslint']}
let g:ale_fixers = {'typescript': ['tslint', 'prettier'], 'javascript': ['eslint', 'prettier']}
let g:ale_fixers['*'] = ['remove_trailing_lines', 'trim_whitespace']


" always (maybe) include the local configuration
call SourceLocal('~/.config/nvim/local.vim')

