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
require("conform").setup({
  formatters_by_ft = {
    python = { "ruff_organize_imports", "ruff_format", "ruff_fix" },
    javascript = { { "prettierd", "prettier" } },
    css = { { "prettierd", "prettier" } },
    html = { { "prettierd", "prettier" } },
    astro = { { "prettierd", "prettier" } },
    nix = {"alejandra "},
    cpp = {"clang-format"} ,
	["*"] = { "codespell" },
  },

  format_on_save = {
    lsp_fallback = true,
    timeout_ms = 500,
  },
})

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

local on_attach = function(_, bufnr)

  local bufmap = function(keys, func)
    vim.keymap.set('n', keys, func, { buffer = bufnr })
  end

  bufmap('<leader>r', vim.lsp.buf.rename)
  bufmap('<leader>a', vim.lsp.buf.code_action)

  bufmap('gd', vim.lsp.buf.definition)
  bufmap('gD', vim.lsp.buf.declaration)
  bufmap('gI', vim.lsp.buf.implementation)
  bufmap('<leader>D', vim.lsp.buf.type_definition)

  bufmap('gr', require('telescope.builtin').lsp_references)
  bufmap('<leader>s', require('telescope.builtin').lsp_document_symbols)
  bufmap('<leader>S', require('telescope.builtin').lsp_dynamic_workspace_symbols)

  bufmap('K', vim.lsp.buf.hover)

  vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
    vim.lsp.buf.format()
  end, {})
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

require('neodev').setup()

require('lspconfig').nil_ls.setup {
    on_attach = on_attach,
    capabilities = capabilities,
}

--- Make sure to install the lsp's  via a flake for dev env ---

require('lspconfig').pyright.setup{
    on_attach = on_attach,
    capabilities = capabilities,
}

require('lspconfig').svelte.setup{
    on_attach = on_attach,
    capabilities = capabilities,
}

require('lspconfig').rust.setup{
    on_attach = on_attach,
    capabilities = capabilities,
}

require('lspconfig').zig.setup{
    on_attach = on_attach,
    capabilities = capabilities,
}

require('lspconfig').html.setup {
  on_attach = on_attach,
  capabilities = capabilities,
}

require('lspconfig').tsserver.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  single_file_support = true,
}

require'lspconfig'.clangd.setup{
  on_attach = on_attach,
  capabilities = capabilities,
}

require'lspconfig'.astro.setup{
  on_attach = on_attach,
  capabilities = capabilities,
}

local cmp = require('cmp')
local luasnip = require('luasnip')

require('luasnip.loaders.from_vscode').lazy_load()
luasnip.config.setup {}

cmp.setup {
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
    mapping = cmp.mapping.preset.insert {
        ['<C-n>'] = cmp.mapping.select_next_item(),
        ['<C-p>'] = cmp.mapping.select_prev_item(),
        ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete {},
        ['<CR>'] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
        },
        ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.expand_or_locally_jumpable() then
                luasnip.expand_or_jump()
            else
                fallback()
            end
        end, { 'i', 's' }),
        ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.locally_jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { 'i', 's' }),
    },
    sources = {
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
        { name = 'path' },
        { name = 'git' },
        { name = 'cmdline' },
    },
}

local builtin = require('telescope.builtin')
vim.keymap.set('n', 'ff', builtin.find_files, {})
vim.keymap.set('n', 'fg', builtin.live_grep, {})

require('nvim-treesitter.configs').setup {
    ensure_installed = {},

    auto_install = false,

    highlight = { enable = true },

    indent = { enable = true },
}
