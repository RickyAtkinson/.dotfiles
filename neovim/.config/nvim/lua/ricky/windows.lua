-- Fix cursor sticking as block after exit bug in PowerShell:
-- Reset cursor shape to flashing vertical bar when exiting
vim.cmd [[ autocmd VimLeave * set guicursor=a:blinkwait700-blinkon400-blinkoff250-ver25 ]]
