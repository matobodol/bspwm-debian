-- [[ KEYMAPS ]]

local map = vim.keymap.set
local opts = {noremap = true, silent = true}
-- Space as leader key
vim.g.mapleader = ' '

-- Shortcuts
-- go to homeline
map({'n', 'x', 'o'}, '<leader>h', '^')
-- goto endline
map({'n', 'x', 'o'}, '<leader>l', 'g_')
-- seleck all text
map('n', '<leader>a', ':keepjumps normal! ggVG<cr>')

-- Basic clipboard interaction
map({'n', 'x'}, 'cp', '"+y')
map({'n', 'x'}, 'cv', '"+p')

-- Delete text
map({'n', 'x'}, 'x', '"_x')

-- Reload config
map('n', '<leader>s', '<cmd>luafile %<cr>')

-- Buffer
map('n', '<leader>w', '<cmd>write<cr>')
map('n', '<leader>q', '<cmd>quit<cr>')
map('n', '<leader>bq', '<cmd>quit!<cr>')
map('n', '<leader>bw', ':w ')
map('n', '<leader>bn', '<cmd>tabnew<cr>')

-- Run current file cpp
map('n', '<leader>bb', '<cmd>w | !g++ -std=c++17 -Wall % -o %:r<cr>', opts)
map('n', '<leader>bc', '<cmd>w | !g++ -c -std=c++17 -Wall % -o %:r.o<cr>', opts)
map('n', '<leader>br', ':split term://bash -c %:r<CR>i')
map('n', '<leader>bs', ':split term://bash -c %<CR>i')
map('n', '<leader>bd', '<cmd>!rm %:r<cr> ')
map('n', '<leader>bD', '<cmd>!rm %:r.o<cr> ')

-- Mouse
map('n', '<leader>bm', ':set mouse=a<CR>')
map('n', '<leader>bM', ':set mouse=<CR>')
