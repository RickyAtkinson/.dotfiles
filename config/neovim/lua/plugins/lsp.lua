return {
  -- Package manager for LSP servers, DAP servers, linters, and formatters
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "astro-language-server",
        "css-lsp",
        "dprint",
        "luacheck",
        "powershell-editor-services",
        "prettierd",
        "selene",
        "shellcheck",
        "shfmt",
        "stylua",
        "tailwindcss-language-server",
        "typescript-language-server",
      })
    end,
  },

  -- LSP server setup
  {
    "neovim/nvim-lspconfig",
    opts = {
      inlay_hints = { enabled = true },
      servers = {
        ansiblels = {},
        astro = {},
        bashls = {},
        clangd = {},
        -- denols = {},
        cssls = {},
        dockerls = {},
        -- ruff_lsp = {},
        tailwindcss = {
          root_dir = function(...)
            return require("lspconfig.util").root_pattern(".git")(...)
          end,
        },
        tsserver = {
          root_dir = function(...)
            return require("lspconfig.util").root_pattern(".git")(...)
          end,
          single_file_support = false,
          settings = {
            typescript = {
              inlayHints = {
                includeInlayParameterNameHints = "literal",
                includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                includeInlayFunctionParameterTypeHints = true,
                includeInlayVariableTypeHints = false,
                includeInlayPropertyDeclarationTypeHints = true,
                includeInlayFunctionLikeReturnTypeHints = true,
                includeInlayEnumMemberValueHints = true,
              },
            },
            javascript = {
              inlayHints = {
                includeInlayParameterNameHints = "all",
                includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                includeInlayFunctionParameterTypeHints = true,
                includeInlayVariableTypeHints = true,
                includeInlayPropertyDeclarationTypeHints = true,
                includeInlayFunctionLikeReturnTypeHints = true,
                includeInlayEnumMemberValueHints = true,
              },
            },
          },
        },
        -- svelte = {},
        html = {},
        gopls = {},
        marksman = {},
        pyright = {},
        -- rust_analyzer = {},
        yamlls = {
          settings = {
            yaml = {
              keyOrdering = false,
            },
          },
        },
        lua_ls = {
          single_file_support = true,
          settings = {
            Lua = {
              workspace = {
                checkThirdParty = false,
              },
              completion = {
                workspaceWord = true,
                callSnippet = "Both",
              },
              hover = { expandAlias = false },
              hint = {
                enable = true,
                setType = false,
                paramType = true,
                paramName = "Disable",
                semicolon = "Disable",
                arrayIndex = "Disable",
              },
              doc = {
                privateName = { "^_" },
              },
              type = {
                castNumberToInteger = true,
              },
              diagnostics = {
                disable = { "incomplete-signature-doc", "trailing-space" },
                groupSeverity = {
                  strong = "Warning",
                  strict = "Warning",
                },
                groupFileStatus = {
                  ["ambiguity"] = "Opened",
                  ["await"] = "Opened",
                  ["codestyle"] = "None",
                  ["duplicate"] = "Opened",
                  ["global"] = "Opened",
                  ["luadoc"] = "Opened",
                  ["redefined"] = "Opened",
                  ["strict"] = "Opened",
                  ["strong"] = "Opened",
                  ["type-check"] = "Opened",
                  ["unbalanced"] = "Opened",
                  ["unused"] = "Opened",
                },
                unusedLocalExclude = { "_*" },
              },
              format = {
                enable = true,
                defaultConfig = {
                  indent_style = "space",
                  indent_size = "2",
                  continuation_indent_size = "2",
                },
              },
            },
          },
        },
        vimls = {},
      },
      setup = {},
    },
  },

  {
    "neovim/nvim-lspconfig",
    opts = {
      diagnostics = { virtual_text = { prefix = "icons" } },
    },
  },

  {
    "stevearc/conform.nvim",
    optional = true,
    opts = {
      formatters_by_ft = {
        ["javascript"] = { "dprint", { "prettierd", "prettier" } },
        ["javascriptreact"] = { "dprint", { "prettierd", "prettier" } },
        ["typescript"] = { "dprint", { "prettierd", "prettier" } },
        ["typescriptreact"] = { "dprint", { "prettierd", "prettier" } },
        ["vue"] = { { "prettierd", "prettier" } },
        ["css"] = { { "prettierd", "prettier" } },
        ["scss"] = { { "prettierd", "prettier" } },
        ["less"] = { { "prettierd", "prettier" } },
        ["html"] = { { "prettierd", "prettier" } },
        ["json"] = { { "prettierd", "prettier" } },
        ["jsonc"] = { { "prettierd", "prettier" } },
        ["yaml"] = { { "prettierd", "prettier" } },
        ["markdown"] = { { "prettierd", "prettier" } },
        ["markdown.mdx"] = { { "prettierd", "prettier" } },
        ["graphql"] = { { "prettierd", "prettier" } },
        ["handlebars"] = { { "prettierd", "prettier" } },
      },
      formatters = {
        prettier = {
          condition = function(self, ctx)
            return vim.fs.find(
              { ".prettierrc", ".prettierrc.js", "prettier.config.js" },
              { path = ctx.filename, upward = true }
            )[1]
          end,
        },
        prettierd = {
          condition = function(self, ctx)
            return vim.fs.find(
              { ".prettierrc", ".prettierrc.js", "prettier.config.js" },
              { path = ctx.filename, upward = true }
            )[1]
          end,
        },
        dprint = {
          condition = function(self, ctx)
            return vim.fs.find({ "dprint.json" }, { path = ctx.filename, upward = true })[1]
          end,
        },
        shfmt = {
          prepend_args = { "-i", "2", "-ci" },
        },
      },
    },
  },

  {
    "mfussenegger/nvim-lint",
    opts = {
      linters_by_ft = {
        lua = { "selene", "luacheck" },
      },
      linters = {
        selene = {
          condition = function(ctx)
            return vim.fs.find({ "selene.toml" }, { path = ctx.filename, upward = true })[1]
          end,
        },
        luacheck = {
          condition = function(ctx)
            return vim.fs.find({ ".luacheckrc" }, { path = ctx.filename, upward = true })[1]
          end,
        },
      },
    },
  },
}
