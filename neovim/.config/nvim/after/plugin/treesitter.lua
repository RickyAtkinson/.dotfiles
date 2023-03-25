local status, treesitter = pcall(require, 'nvim-treesitter.configs')
if (not status) then return end

treesitter.setup {
  highlight = {
    enable = true,
    disable = {},
  },
  indent = {
    enable = true,
    disable = {},
  },
  ensure_installed = {
    'astro',
    'c',
    'cpp',
    'css',
    'go',
    'html',
    'javascript',
    'json',
    'lua',
    'php',
    'python',
    'regex',
    'rust',
    'scss',
    'svelte',
    'typescript',
    'tsx',
    'vue',
    'yaml',
  },
  autotag = {
    enable = true,
  },
}

local parser_config = require 'nvim-treesitter.parsers'.get_parser_configs()
parser_config.tsx.filetype_to_parsername = { 'javascript', 'typescript.tsx' }
