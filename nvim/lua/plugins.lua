-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
-- vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    -- Telescope
    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.0',
        -- or                            , branch = '0.1.x',
        requires = { { 'nvim-lua/plenary.nvim' } }
    }

    -- Colorscheme
    use({
        'rose-pine/neovim',
        as = 'rose-pine',
    })
    -- Monokai colorschemes
    use 'tanvirtin/monokai.nvim'
    -- One Dark colorschemes
    use 'navarasu/onedark.nvim'
    -- Catppuccin colorschemes
    use { "catppuccin/nvim", as = "catppuccin" }

    -- Tree Sitter
    use('nvim-treesitter/nvim-treesitter', { run = ':TSUpdate' })
    use 'nvim-treesitter/playground'
    -- Treesitter-context
    use 'nvim-treesitter/nvim-treesitter-context'

    -- Harpoon
    use 'theprimeagen/harpoon'
    -- UndoTree
    use 'mbbill/undotree'

    -- Git Fugitive
    use 'tpope/vim-fugitive'
    -- Git
    use 'lewis6991/gitsigns.nvim'

    -- LSP
    use {
        'VonHeikemen/lsp-zero.nvim',
        requires = {
            -- LSP Support
            { 'neovim/nvim-lspconfig' },
            { 'williamboman/mason.nvim' },
            { 'williamboman/mason-lspconfig.nvim' },

            -- Autocompletion
            { 'hrsh7th/nvim-cmp' },
            { 'hrsh7th/cmp-buffer' },
            { 'hrsh7th/cmp-path' },
            { 'saadparwaiz1/cmp_luasnip' },
            { 'hrsh7th/cmp-nvim-lsp' },
            { 'hrsh7th/cmp-nvim-lua' },

            -- Snippets
            { 'L3MON4D3/LuaSnip' },
            { 'rafamadriz/friendly-snippets' },
        }
    }

    -- Folding (UFO)
    use { 'kevinhwang91/nvim-ufo', requires = 'kevinhwang91/promise-async' }

    -- Lualine
    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'kyazdani42/nvim-web-devicons', opt = true },
    }

    -- Comment.nvim
    use {
        'numToStr/Comment.nvim',
    }

    -- Helm
    use 'towolf/vim-helm'
end)
