-- Auto souce nvim config files from project root
vim.opt.exrc = true

-- Keep buffers open in the background
vim.opt.hidden = true

-- Windows colors
vim.opt.termguicolors = true -- True color support
vim.opt.winblend = 0 -- Transparency of floating windows
vim.opt.pumblend = 5 -- Popup menu transparency
vim.opt.wildoptions = 'pum' -- Popup menu for wildmenu

-- Workspace
vim.opt.signcolumn = 'yes:2' -- Always show signcolumn and set width
vim.opt.colorcolumn = '80' -- Show vertical line at 80 characters
vim.opt.cursorline = true -- Highlight the current line
vim.opt.title = true -- Set the terminal title to the current buffer name

-- Spell check
vim.opt.spelllang = 'en_us'

-- Search
vim.opt.ignorecase = true -- Case insensitive search
vim.opt.smartcase = true -- Case sensitive if contains /C or uppercase letters
vim.opt.hlsearch = false -- Disable highlight search
vim.opt.incsearch = true -- Show search results as you type
vim.opt.path:append { '**' } -- Recursively search files in all directories
vim.opt.wildignore:append { '*/node_modules/*' } -- Exclude node_modules

-- Line numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- Tabs
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.smartindent = true

-- Word wrap
vim.opt.wrap = false

-- Undo
vim.opt.undofile = true -- Enable undo file
vim.opt.undodir = vim.fn.stdpath('data') .. '/undo' -- Set undo directory
vim.api.nvim_command('set noswapfile') -- Disable swap files
vim.api.nvim_command('set nobackup') -- Disable backup files

-- Misc
vim.opt.scrolloff = 8 -- Minimum number of lines to keep above/below the cursor
vim.opt.formatoptions:append { 'r' } -- Add asterisks in block comments
vim.g.updatetime = 50
