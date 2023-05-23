local Plugin = {'romgrk/barbar.nvim'}
Plugin.dependencies = {'nvim-tree/nvim-web-devicons'}

Plugin.config = {
  animation = false,
  auto_hide = false,
  tabpages = true,
  clickable = false,
  focus_on_close = 'left',
  hide = {extensions = true, inactive = false},
  highlight_alternate = false,
  highlight_inactive_file_icons = false,
  highlight_visible = true,

  icons = {
    buffer_index = false,
    buffer_number = false,
    button = false, --| '',
    diagnostics = {
      [vim.diagnostic.severity.ERROR] = {enabled = true, icon = 'ﬀ'},
      [vim.diagnostic.severity.WARN] = {enabled = false},
      [vim.diagnostic.severity.INFO] = {enabled = false},
      [vim.diagnostic.severity.HINT] = {enabled = true},
    },
    filetype = {
      custom_colors = false,
      enabled = true,
    },
    separator = {left = '▎', right = ''},
    modified = {button = '●'},
    pinned = {button = '車'},
    alternate = {filetype = {enabled = false}},
    current = {buffer_index = false},
    inactive = {button = false}, --| {button = '×'}
    visible = {modified = false},
  },

  insert_at_end = false,
  insert_at_start = false,
  maximum_padding = 2,
  minimum_padding = 2,
  maximum_length = 30,
  semantic_letters = true,
  letters = 'asdfjkl;ghnmxcvbziowerutyqpASDFJKLGHNMXCVBZIOWERUTYQP',
  no_name_title = nil,
}

	vim.keymap.set('n', '<A-c>', '<Cmd>BufferClose<CR>')
	vim.keymap.set('n', '<A-h>', '<Cmd>BufferPrevious<CR>')
	vim.keymap.set('n', '<A-l>', '<Cmd>BufferNext<CR>')
	--vim.keymap.set('n', '<A-k>', '<Cmd>BufferMovePrevious<CR>')
	--vim.keymap.set('n', '<A-j>', '<Cmd>BufferMoveNext<CR>')

return Plugin
