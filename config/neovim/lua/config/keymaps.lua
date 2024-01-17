-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
local cowboy = require("utils.cowboy")

cowboy.cowboy()

local keymap = vim.keymap

-- Allow moving blocks of highlighted code and respects tab formating
keymap.set("v", "<M-j>", ":m '>+1<CR>gv=gv")
keymap.set("v", "<M-k>", ":m '<-2<CR>gv=gv")

-- When using half page jumps keep the cursor in the center of the screen
keymap.set("n", "<C-d>", "<C-d>zz")
keymap.set("n", "<C-u>", "<C-u>zz")

-- Keep search terms in the center of the screen when cycling through them
keymap.set("n", "n", "nzzzv")
keymap.set("n", "N", "Nzzzv")

-- Make `ctrl-c` act as `esc` for consistant visual block edits
keymap.set("n", "<C-c>", "<Esc>")

-- Replace RGB color in Hex represention to HSL
keymap.set("n", "<leader>rx", function()
  require("utils").replace_hex_with_hsl()
end, { desc = "Replace Hex with HSL" })

-- Make the current file executeable
if not _G.IS_WINDOWS then
  keymap.set("n", "<leader>xe", "<cmd>!chmod +x %<CR>", { desc = "Make Executable" })
end
