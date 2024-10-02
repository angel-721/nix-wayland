require("nvim-tree").setup({
  sort = {
    sorter = "case_sensitive",
  },
  view = {
    width = 30,
  },
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = true,
  },
})


local api = require "nvim-tree.api"
vim.keymap.set('n', 'tr', api.tree.open, {})
vim.keymap.set('n', 'ty', api.tree.close, {})
