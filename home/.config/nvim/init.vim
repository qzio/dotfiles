set nocompatible

" custom functions etc -------------------
function! SourceLocal(file)
  if filereadable(expand(a:file))
    exe 'source' a:file
  endif
endfunction

set runtimepath+=$HOME/.cache/dein/repos/github.com/Shougo/dein.vim
if dein#load_state('~/.cache/dein')
  call dein#begin('~/.cache/dein')
  " Let dein manage dein
  call dein#add('~/.cache/dein/repos/github.com/Shougo/dein.vim')

  call dein#add('tpope/vim-surround')
  call dein#add('tpope/vim-ragtag')
  call dein#add('junegunn/fzf.vim')
  call dein#add('junegunn/vim-easy-align')

  call dein#add('fatih/vim-go')

  " typescript syntax highlightning(and more)
  call dein#add('HerringtonDarkholme/yats.vim')

  call dein#add('autozimu/LanguageClient-neovim', {'rev': 'next', 'build': 'bash install.sh'})

  call dein#add('Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins'})


  "call dein#add('neovim/nvim-lspconfig')
  call dein#add('challenger-deep-theme/vim', {'name': 'challenger-deep'})
  " Required:
  call dein#end()
  call dein#save_state()
endif
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
"colorscheme solarized
"
set autoread
" end defaults

" short cut mapptings
let mapleader=","

" FZF configuration
set rtp+=~/.fzf
let $FZF_DEFAULT_COMMAND = 'find . -type f -not -path "*/\.*" -not -path "*/node_modules/*" -not -path "*/vendor/*" -not -iname "*.class" -not -path "*/dist/*"'
let g:fzf_buffers_jump = 1

" ragtag
let g:ragtag_global_maps = 1

" vim-surround
xmap s <Plug>VSurround

" easy align
xmap ga <Plug>(EasyAlign)

" generic indention standard
au BufEnter,BufRead,BufNewFile *.* set shiftwidth=2 softtabstop=2 tabstop=2 expandtab
au BufEnter,BufRead,BufNewFile *.py,*.java,*.erl,*.rs,*.c set shiftwidth=4 softtabstop=4 tabstop=4

" golang
au BufEnter,BufRead,BufNewFile *.got,*.gogo set ft=go
au BufEnter,BufRead,BufNewFile *.gots set ft=gohtmltmpl
" fast :GoImplements using ripgrep
au FileType go nmap <Leader>c :Rg func \(.[^)]*\) <C-r><C-w>\(<Cr>
au BufEnter,BufRead,BufNewFile *.go set noexpandtab tabstop=4 shiftwidth=4

" fzf (rg) grep with nice list
nmap <Leader>r :Rg <C-r><C-w><Cr>
" search/replace in file
nmap <Leader>w :%s/<C-r><C-w>/
" open file search
nmap <Leader>t :FZF<Cr>
nmap <Leader>T :Buffers<Cr>

" remove trailing whitespaces
nmap <Leader>y :%s/\s\+$//g<Cr>
" cd into the directory of the current file
nmap <Leader>p :cd %:p:h<Cr>

nmap <Leader>m :! make<Cr>
nmap <Leader>n :! make test<Cr>
nmap <Leader>j :! make run<Cr>


iabbrev ifer if err != nil {<Cr><Cr>}<Up><Tab>return

" go stuff
nmap <Leader>J :! go run main.go<Cr>
nmap <Leader>J ::GoRun<Cr>
nmap <Leader>N :! go test .<Cr>
let g:go_highlight_build_constraints = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1

let g:go_highlight_function_calls = 0
let g:go_highlight_function_parameters = 0
let g:go_highlight_methods = 0
let g:go_highlight_operators = 0
let g:go_highlight_structs = 0
let g:go_highlight_types = 0

let g:go_highlight_extra_types = 1
let g:go_highlight_operators = 1

let g:go_auto_sameids = 0
let g:go_highlight_chan_whitespace_error = 0
"au FileType go nmap <Leader>f :GoImports<Cr>:GoFmt<Cr>:GoDiagnostics<Cr>:GoBuild<Cr>:GoVet<Cr>
"let g:go_metalinter_enabled = ['vet', 'golint', 'errcheck']

" node/javascript/typescript
au BufEnter,BufRead,BufNewFile *.ts setf typescript
au BufReadPost *.svelte setf html

" language server
let g:LanguageClient_settingsPath=["~/.config/nvim/lsp-settings.json", ".vim/settings.json"]
let g:LanguageClient_serverCommands={
  \ 'go': ['gopls'],
  \ 'javascript': ['typescript-language-server', '--stdio'],
  \ 'typescript': ['typescript-language-server', '--stdio'],
  \ 'typescriptreact': ['typescript-language-server', '--stdio'],
\ }
nmap <Leader>H <Plug>(lcn-menu)
nmap <Leader>h <Plug>(lcn-hover)
nmap <Leader>f <Plug>(lcn-format)<Cr><Plug>(lcn-code-action)
nmap <Leader>F <Plug>(lcn-diagnostics-next)
nmap <Leader>G <Plug>(lcn-format-sync)
nmap <Leader>R <Plug>(lcn-rename)
nmap <Leader>a <Plug>(lcn-code-action)
nmap <Leader>A <Plug>(lcn-code-lens-action)
nmap <Leader>d <Plug>(lcn-definition)
nmap <Leader>D <Plug>(lcn-type-definition)

" jump back
nmap <Leader>g <c-o>

" Use deoplete.
let g:deoplete#enable_at_startup = 1

" use prettier for javascript format
au BufEnter,BufRead,BufNewFile *.ts nmap <Leader>f :silent %!prettier --stdin-filepath %<CR>

" always (maybe) include the local configuration
call SourceLocal('~/.config/nvim/local.vim')

