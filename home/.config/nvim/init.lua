vim.pack.add({
'https://github.com/tpope/vim-surround',
'https://github.com/tpope/vim-ragtag',
'https://github.com/junegunn/vim-easy-align',
'https://github.com/junegunn/fzf.vim',
'https://github.com/nvim-treesitter/nvim-treesitter',
'https://github.com/mfussenegger/nvim-lint',
'https://github.com/ggml-org/llama.vim'
})
vim.cmd('packadd nvim-treesitter')

require('lint').linters_by_ft = {
  go = { "golangcilint" }
}

vim.g.llama_config = {
	-- show_info = 0,
	auto_fim = true,
	api_key = 'somekey'
}

--    --Not sure if I need this since lsp is builtin now
--    --{'fatih/vim-go'},
--
--    -- enable golangci-lint through the native lsp client
--    {
--      "mfussenegger/nvim-lint",
--      event = { "BufReadPre", "BufNewFile" },
--      config = function()
--        local lint = require("lint")
--
--        lint.linters_by_ft = {
--          go = { "golangcilint" },
--        }
--
--        vim.api.nvim_create_autocmd({ "BufWritePost", "InsertLeave", "BufReadPost" }, {
--          callback = function()
--            lint.try_lint()
--          end,
--        })
--      end,
--    },
--  },
--  -- automatically check for plugin updates
--  --checker = { enabled = true },
--})

-- fix/start configuration and setup of plugins
--vim.api.nvim_create_autocmd('FileType', {
 -- pattern = { '<filetype>' },
  --callback = function() vim.treesitter.start() end,
--})
--
-- treesitter stuff to get it working
-- Force load the plugin paths right now
vim.cmd('packadd nvim-treesitter')
-- install parsers
require('nvim-treesitter').install({
  "go", "javascript", "typescript", "tsx", "html", 
  "css", "json", "lua", "bash", "yaml", "markdown", 
  "markdown_inline"
})
-- register a custom treesitter file ending that should use gohtml as parser
vim.treesitter.language.register('gohtml', { 'html.tmpl' })

-- 3. ENABLE SYNTAX HIGHLIGHTING (Native Neovim Way)
-- This replaces the old "highlight = { enable = true }" block
--vim.api.nvim_create_autocmd("FileType", {
--  group = vim.api.nvim_create_augroup("TreesitterHighlight", { clear = true }),
--  desc = "Enable Tree-sitter syntax highlighting",
--  pattern = "*", 
--  callback = function()
--    pcall(vim.treesitter.start)
--  end,
--})


vim.opt.rtp:append('~/.fzf')

-- my default settings
vim.opt.encoding=utf8
vim.opt.fileencoding=utf8
vim.opt.shiftwidth  = 2
vim.opt.softtabstop = 2
vim.opt.tabstop     = 2
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.autoindent = true
vim.opt.hlsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.number = true
vim.opt.autoread = true
vim.opt.showmode = true
-- these chars is not word separators
vim.opt.isk:append('_,-')
--vim.opt.backspace=indent,eol,start
-- always show 2 line above cursor
vim.opt.scrolloff=2
vim.opt.sidescrolloff=5
-- forever undo
vim.opt.undofile = true

-- show trailing whitespaces
vim.opt.list = true
vim.opt.listchars = {
  -- eol = "↲",
  tab = "▸ ",
  trail = "·",
}

-- global default variables
vim.g.is_posix=1
vim.cmd([[colorscheme retrobox]])

-- hotkeys

vim.g.mapleader=","
vim.keymap.set('n', '<Leader>t', ':FZF<Cr>')
vim.keymap.set('n', '<Leader>T', ':Buffers<Cr>')

-- trigger plugins
vim.keymap.set('x', 's', '<Plug>VSurround', {noremap = true})
vim.keymap.set('x', 'ga', '<Plug>(EasyAlign)', {noremap = true})
vim.keymap.set('x', '<c-x>', '<Plug>(ragtag)', {noremap = true})

-- remap some defaults
-- jump back
vim.keymap.set('n','<Leader>g', '<c-o>')
-- jump to definition
vim.keymap.set('n','<Leader>d', '<c-]>')

-- show errors inline
vim.diagnostic.config({
  virtual_text = true,
  signs = true,
})
vim.keymap.set('n', '<Leader>E', '<cmd>lua vim.diagnostic.open_float(nil,{})<cr>')

-- lsp settings
vim.lsp.config["gopls"] = {
  filetypes = { 'go', 'gomod', 'gowork', 'gotmpl', },
  cmd = { 'gopls' },
}
vim.lsp.config["ts_ls"] = {
  cmd = { 'typescript-language-server', '--stdio' },
  filetypes = {
    'javascript',
    'javascriptreact',
    'javascript.jsx',
    'typescript',
    'typescriptreact',
    'typescript.tsx',
  },
}
vim.lsp.config["python"] = {
  cmd = { 'pylsp' },
  filetypes = { 'python' },
  root_markers = {
    'pyproject.toml',
    'seutp.py',
    'setup.cfg',
    'requirements.txt',
    'Pipfile',
    '.git',
  },
}
-- enable the servers
vim.lsp.enable("gopls")
vim.lsp.enable("ts_ls")
vim.lsp.enable("python")

-- add some hotkeys for lsp commands
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(event)
    local nkey = function(k,a,e)
      vim.keymap.set('n',"<Leader>"..k,"<cmd>lua vim.lsp.buf."..a.."("..e..")<cr>", {buffer = event.buf})
    end
    nkey('h','hover', '')
    nkey('R','rename', '')
    nkey('f','format', '{async = true}')
    nkey('a','code_action', '')

    local bufmap = function(mode,rhs,action)
      vim.keymap.set(mode,rhs,action, {buffer = event.buf})
    end
    bufmap('n', '<leader>e', vim.diagnostic.goto_next)

  end,
})
-- vim.keymap.set('n', '<Leader>i', "<cmd> lua vim.lsp.buf.code_action({context = { only = { 'source.organizeImports' }, diagnostics = vim.lsp.diagnostic.get_line_diagnostics() }, apply = true, })<cr>")
vim.keymap.set('n', '<Leader>i', "<cmd> lua vim.lsp.buf.code_action({context = { only = { 'source.organizeImports' } }, apply = true, })<cr>")
--v im.keymap.set('n', '<leader>e', '<cmd> lua vim.lsp.util.show_line_diagnostics()<CR>')

-- js has different tabstop etc.
vim.api.nvim_create_autocmd("FileType", {
  pattern = {"javascript", "typescript",},
  callback = function()
    -- no op
  end,
})

-- typescript/js should use prettier formatting
vim.api.nvim_create_autocmd(
  { "BufEnter", "BufRead", "BufNewFile" },
  {
    pattern = { "*.ts", "*.tsx" },
    callback = function()
      vim.keymap.set("n", "<leader>q", function()
        vim.cmd("silent %!prettier --stdin-filepath %")
      end, { buffer = true })
    end,
  }

)

-- python
vim.api.nvim_create_autocmd(
  {"BufEnter", "BufWinEnter"},
  {
    pattern = {".py"},
    callback = function ()
	    vim.o.tabstop=2
    end,
  }
)

