local lsp = require('lsp-zero')

lsp.preset('recommended')

lsp.ensure_installed({
    "clangd",
    "lua_ls",
    "rust_analyzer",
    "gopls",
    "tsserver",
    "html",
    "cssls",
    "tailwindcss",
    "sqlls",
    "taplo",
    "yamlls",
    "jsonls",
    "marksman",
    "bashls",
    "dockerls",
    "grammarly"
})

lsp.nvim_workspace()

local cmp = require('cmp')
local cmp_mappings = lsp.defaults.cmp_mappings({
    ["<C-Space>"] = cmp.mapping.complete(),
})
lsp.setup_nvim_cmp({
    mapping = cmp_mappings
})

lsp.set_preferences({
    sign_icons = {
        error = 'E',
        warn = 'W',
        hint = 'H',
        info = 'I'
    }
})

local capabilities = require('cmp_nvim_lsp').default_capabilities()
-- settings for nvim-ufo
-- Tell the server the capability of foldingRange,
-- Neovim hasn't added foldingRange to default capabilities, users must add it manually
capabilities.textDocument.foldingRange = {
    dynamicRegistration = false,
    lineFoldingOnly = true
}
lsp.configure("rust_analyzer", {
    capabilities = capabilities
})

-- lsp.configure('yamlls', {
--     settings = {
--         yaml = {
--             trace = { server = "verbose" },
--             schemas = { kubernetes = "/*.yaml" },
--             schemaDownload = { enable = true },
--             validate = true,
--         }
--     }
-- })

lsp.on_attach(function(client, bufnr)
    local opts = { buffer = bufnr, remap = false }

    -- if vim.bo[bufnr].filetype == "typescriptreact" then
    --     vim.cmd.LspStop('tsserver')
    -- end

    if vim.bo[bufnr].buftype ~= "" or vim.bo[bufnr].filetype == "helm" then
        vim.diagnostic.disable()
    end

    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "gD", vim.lsp.buf.type_definition, opts)
    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
    vim.keymap.set("n", "<leader>f", vim.lsp.buf.format, opts)
    vim.keymap.set("n", "<leader>vws", vim.lsp.buf.workspace_symbol, opts)
    vim.keymap.set("n", "<leader>vd", vim.diagnostic.open_float, opts)
    vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
    vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
    vim.keymap.set("n", "<leader>vca", vim.lsp.buf.code_action, opts)
    vim.keymap.set("n", "<leader>vrr", vim.lsp.buf.references, opts)
    vim.keymap.set("n", "<leader>vrn", vim.lsp.buf.rename, opts)
    vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, opts)

    if client.name == "eslint" then
        vim.keymap.set("n", "<leader>f", vim.cmd.EslintFixAll, opts)
        -- vim.cmd.LspStop('eslint')
        return
    end
end)

lsp.setup()

vim.diagnostic.config({
    virtual_text = true,
})

-- nvim-ufo
-- vim.opt.foldcolumn = '1' -- '0' is not bad
vim.opt.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
vim.opt.foldlevelstart = 99
vim.opt.foldenable = true
-- Using ufo provider need remap `zR` and `zM`. If Neovim is 0.6.1, remap yourself
vim.keymap.set('n', 'zR', require('ufo').openAllFolds)
vim.keymap.set('n', 'zM', require('ufo').closeAllFolds)
require('ufo').setup()
