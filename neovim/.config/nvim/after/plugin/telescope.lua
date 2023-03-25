local status, telescope = pcall(require, 'telescope')
if (not status) then return end

local builtin = require("telescope.builtin")

-- Lists files in your current working directory, respects .gitignore
vim.keymap.set('n', '<leader>pf', builtin.find_files, {})

-- Search through the output of git ls-files command, respects .gitignore
vim.keymap.set('n', '<C-p>', builtin.git_files, {})

-- Search for string inside project files
vim.keymap.set('n', '<leader>ps', function()
  builtin.grep_string({ search = vim.fn.input('Grep > ') })
end)

-- Lists available help tags and opens a new window with the relevant help
vim.keymap.set('n', '<leader>vh', builtin.help_tags, {})
