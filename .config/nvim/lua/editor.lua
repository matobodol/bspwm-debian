-- [[ EDITOR SETRINGS ]]
local opt = vim.opt

vim.opt.swapfile = false
vim.opt.backup = false
opt.mouse = ''
opt.wrap = true
opt.cursorline = true

--opt.foldmethod = 'expr'
--opt.foldexpr = 'nvim_treesitter#foldexpr()'

opt.number = true
opt.scrolloff = 4
opt.signcolumn = "no"

-- [[ Filetypes ]]
opt.encoding = 'utf8'
opt.fileencoding = 'utf8'

-- [[ Theme ]]
vim.g.t_Co = 256
vim.g.background = "dark"
opt.syntax = "ON"
opt.termguicolors = true

-- [[ Search ]]
opt.ignorecase = true
opt.smartcase = true
opt.incsearch = true
opt.hlsearch = false

-- [[ Whitespace ]]
opt.expandtab = false
--opt.autoindent = true
--opt.smartindent = true
opt.shiftwidth = 2
opt.tabstop = 2

-- [[ Splits ]]
opt.splitright = true
opt.splitbelow = true
