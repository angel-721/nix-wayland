vim.o.number = true
vim.o.signcolumn = 'yes'
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.updatetime = 300
vim.o.termguicolors = true
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.opt.termguicolors = true
vim.cmd [[colorscheme tokyonight]]


-- key mappings -- 

vim.keymap.set('n', 'vw', 'viw', { noremap = true })

-- key mappings --


-- short plugin configs --

require('nvim-autopairs').setup({
  disable_filetype = { "TelescopePrompt" , "vim" },
})

local cmp_autopairs = require('nvim-autopairs.completion.cmp')
local cmp = require('cmp')
cmp.event:on(
  'confirm_done',
  cmp_autopairs.on_confirm_done()
)

require'alpha'.setup(require'alpha.themes.startify'.config)
require("nvim-surround").setup()
