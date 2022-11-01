-- mappings
vim.g.mapleader = ' '
vim.keymap.set('n', '<leader>w', '<cmd>write<cr>', { desc = 'Save' })
vim.keymap.set('n', '<leader>q', '<cmd>quit<cr>', { desc = 'Quit' })
vim.keymap.set('n', '<C-c>', '<cmd>noh<cr>', { desc = 'Quit' })
vim.keymap.set({ 'n', 'x' }, 'x', '"_x')
