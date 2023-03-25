-- Set <space> as the leader key
vim.g.mapleader = ' '

-- Open Netrw directory listing
vim.keymap.set('n', '<leader>pv', vim.cmd.Ex)

-- Allow moving blocks of highlighted code and respects tab formating
vim.keymap.set('v', 'J', [[:m '>+1<CR>gv=gv]])
vim.keymap.set('v', 'K', [[:m '<-2<CR>gv=gv]])

-- J will still take the line below and append but without moving the cursor
vim.keymap.set('n', 'J', 'mzJ`z')

-- When using half page jumps keep the cursor in the center of the screen
vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')

-- Keep search terms in the center of the screen when cycling through them
vim.keymap.set('n', 'n', 'nzzzv')
vim.keymap.set('n', 'N', 'Nzzzv')

-- Stops pasting from copying when pasting over highlighted text
vim.keymap.set('x', '<leader>p', [['_dP]])

-- Allows you to yank to the system clipboard
vim.keymap.set({'n', 'v'}, '<leader>y', [['+y]])
vim.keymap.set('n', '<leader>Y', [['+Y]])

vim.keymap.set({'n', 'v'}, '<leader>d', [['_d]])

-- Make Ctrl-c act as escape when doing visual block edits
vim.keymap.set('i', '<C-c>', '<Esc>')

-- Unmap Q
vim.keymap.set('n', 'Q', '<nop>')

-- Format
vim.keymap.set('n', '<leader>f', vim.lsp.buf.format)

-- Quick fix navigation
vim.keymap.set('n', '<C-K>', '<cmd>cnext<CR>zz')
vim.keymap.set('n', '<C-J>', '<cmd>cprev<CR>zz')
vim.keymap.set('n', '<leader>k', '<cmd>lnext<CR>zz')
vim.keymap.set('n', '<leader>j', '<cmd>lprev<CR>zz')

-- Replaces the word your cursor is on throughout the file
vim.keymap.set('n', '<leader>s', [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- Make the current file executeable
vim.keymap.set('n', '<leader>x', '<cmd>!chmod +x %<CR>', { silent = true })

-- Source files
vim.keymap.set('n', '<leader><leader>', function()
    vim.cmd('so')
end)
