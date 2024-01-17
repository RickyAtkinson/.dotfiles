return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "astro",
        "cmake",
        -- "comment", -- Comments are slowing down TS bigtime, so disable for now
        "css",
        "gitcommit",
        "gitignore",
        "glsl",
        "graphql",
        "html",
        "http",
        "javascript",
        "nix",
        "php",
        "regex",
        "scss",
        "sql",
        "svelte",
        "vue",
        "wgsl",
        "yaml",
      })
    end,
  },
}
