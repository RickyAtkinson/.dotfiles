local status, harpoon = pcall(require, 'harpoon')
if (not status) then return end

harpoon.setup({})

vim.keymap.set('n', '<leader>a', function() require('harpoon.mark').add_file() end, { silent = true })
vim.keymap.set('n', '<leader>e', function() require('harpoon.ui').toggle_quick_menu() end, { silent = true })

vim.keymap.set('n', '<C-j>', function() require('harpoon.ui').nav_file(1) end, { silent = true })
vim.keymap.set('n', '<C-k>', function() require('harpoon.ui').nav_file(2) end, { silent = true })
vim.keymap.set('n', '<C-l>', function() require('harpoon.ui').nav_file(3) end, { silent = true })
vim.keymap.set('n', '<C-;>', function() require('harpoon.ui').nav_file(4) end, { silent = true })
