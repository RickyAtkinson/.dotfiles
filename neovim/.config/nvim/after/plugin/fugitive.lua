if vim.fn.exists(':Git') == 0 then return end

vim.keymap.set("n", "<leader>gs", vim.cmd.Git)
