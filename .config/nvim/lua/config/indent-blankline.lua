local Plugin = {'lukas-reineke/indent-blankline.nvim'}

Plugin.opts = {
vim.cmd [[highlight IndentBlanklineIndent1 guifg=#4B5263 gui=nocombine]],
vim.cmd [[highlight IndentBlanklineIndent2 guifg=#4B5263 gui=nocombine]],
vim.cmd [[highlight IndentBlanklineIndent3 guifg=#4B5263 gui=nocombine]],
vim.cmd [[highlight IndentBlanklineIndent4 guifg=#4B5263 gui=nocombine]],
vim.cmd [[highlight IndentBlanklineIndent5 guifg=#4B5263 gui=nocombine]],
vim.cmd [[highlight IndentBlanklineIndent6 guifg=#4B5263 gui=nocombine]],
    char_highlight_list = {
        "IndentBlanklineIndent1",
        "IndentBlanklineIndent2",
        "IndentBlanklineIndent3",
        "IndentBlanklineIndent4",
        "IndentBlanklineIndent5",
        "IndentBlanklineIndent6",
    },



  enabled = true,
  show_trailing_blankline_indent = false,
  show_first_indent_level = true,
  use_treesitter = true,
  show_current_context = false
}

Plugin.keymap = {
	vim.keymap.set('n', '<leader>ui', '<cmd>IndentBlanklineToggle<cr>')
}

return Plugin

