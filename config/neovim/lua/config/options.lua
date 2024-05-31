-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua

vim.wo.conceallevel = 0
vim.opt.fileformats = { "unix", "mac", "dos" } -- For `/n` line endings
vim.opt.scrolloff = 8
vim.opt.spelllang = "en_us"

-- Make all keymaps silent by default
local keymap_set = vim.keymap.set
---@diagnostic disable-next-line: duplicate-set-field
vim.keymap.set = function(mode, lhs, rhs, opts)
  opts = opts or {}
  opts.silent = opts.silent ~= false
  return keymap_set(mode, lhs, rhs, opts)
end

-- Register Filetypes
vim.cmd("au BufNewFile,BufRead *.astro setf astro")

-- Cursor
vim.opt.guicursor = "n-v-c:block,i-ci-ve:ver25,"
  .. "r-cr:hor20,o:hor50,"
  .. "i:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor,"
  .. "sm:block-blinkwait175-blinkoff150-blinkon175"

-- Fix "cursor switched to block after exit" bug in PowerShell:
-- Reset cursor shape to flashing vertical bar when exiting
-- TODO: This isn't working anymore...
if _G.IS_WINDOWS then
  vim.cmd("autocmd VimLeave * set guicursor=a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor")
end

-- Set a clipboard provider in WSL
if _G.IS_WSL then
  vim.g.clipboard = {
    name = "WslClipboard",
    copy = {
      ["+"] = "clip.exe",
      ["*"] = "clip.exe",
    },
    paste = {
      ["+"] = "powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace('\r', ''))",
      ["*"] = "powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace('\r', ''))",
    },
  }
end
