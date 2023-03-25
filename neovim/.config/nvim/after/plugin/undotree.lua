if vim.fn.exists(':UndotreeToggle') == 0 then return end

vim.keymap.set('n', '<leader><F5>', vim.cmd.UndotreeToggle)
