
local Plugin = {'nvim-tree/nvim-tree.lua'}
Plugin.dependencies = {'nvim-tree/nvim-web-devicons'}


Plugin.config = {

  sort_by = "case_sensitive",
  view = {
		width = 25,
  },
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = true,
  },

}

Plugin.keys = {
	{'<leader>n', '<cmd>NvimTreeToggle<cr>'}
}

return Plugin
