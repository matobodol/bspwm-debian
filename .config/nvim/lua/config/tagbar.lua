
local Plugin = {'preservim/tagbar'}

vim.g.tagbar_autofocus = true
vim.keymap.set('n', '<leader>m', ':TagbarToggle<CR>', {})

return Plugin

