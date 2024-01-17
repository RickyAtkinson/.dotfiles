return {
  -- Quick switching between files
  {
    "ThePrimeagen/harpoon",
    requires = { { "nvim-lua/plenary.nvim" } },
    keys = {
      {
        "<leader>hh",
        function()
          require("harpoon.mark").add_file()
        end,
        desc = "Mark File",
      },
      {
        "<leader>hH",
        function()
          require("harpoon.ui").toggle_quick_menu()
        end,
        desc = "Harpoon UI",
      },
      {
        "<leader>ha",
        function()
          require("harpoon.ui").nav_file(1)
        end,
        desc = "Goto File 1",
      },
      {
        "<leader>hs",
        function()
          require("harpoon.ui").nav_file(2)
        end,
        desc = "Goto File 2",
      },
      {
        "<leader>hd",
        function()
          require("harpoon.ui").nav_file(3)
        end,
        desc = "Goto File 3",
      },
      {
        "<leader>hf",
        function()
          require("harpoon.ui").nav_file(4)
        end,
        desc = "Goto File 4",
      },
      {
        "<leader>hca",
        function()
          require("harpoon.ui").rm_file(1)
        end,
        desc = "Unmark File 1",
      },
      {
        "<leader>hcs",
        function()
          require("harpoon.ui").rm_file(2)
        end,
        desc = "Unmark File 2",
      },
      {
        "<leader>hcd",
        function()
          require("harpoon.ui").rm_file(3)
        end,
        desc = "Unmark File 3",
      },
      {
        "<leader>hcf",
        function()
          require("harpoon.ui").rm_file(4)
        end,
        desc = "Unmark File 4",
      },
      {
        "<leader>hcc",
        function()
          require("harpoon.ui").clear_all(4)
        end,
        desc = "Unmark All",
      },
    },
    opts = {},
  },

  {
    "echasnovski/mini.hipatterns",
    event = "BufReadPre",
    opts = {
      highlighters = {
        hsl_color = {
          pattern = "hsl%(%d+,? %d+,? %d+%)",
          group = function(_, match)
            local utils = require("utils")
            local h, s, l = match:match("hsl%((%d+),? (%d+),? (%d+)%)")
            h, s, l = tonumber(h), tonumber(s), tonumber(l)
            local hex_color = utils.hsl_to_hex(h, s, l)
            --- @diagnostic disable-next-line: undefined-global
            return MiniHipatterns.compute_hex_color_group(hex_color, "bg")
          end,
        },
      },
    },
  },

  {
    "telescope.nvim",
    dependencies = {
      {
        "debugloop/telescope-undo.nvim",
        keys = { { "<leader>U", "<cmd>Telescope undo<cr>", desc = "Telescope Undo" } },
        config = function()
          require("telescope").load_extension("undo")
        end,
      },
    },
    opts = {
      defaults = {
        layout_strategy = "horizontal",
        layout_config = {
          horizontal = {
            prompt_position = "top",
            preview_width = 0.5,
          },
          width = 0.8,
          height = 0.8,
          preview_cutoff = 120,
        },
        sorting_strategy = "ascending",
        winblend = 0,
      },
    },
  },

  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      event_handlers = {
        {
          event = "file_opened",
          handler = function(file_path)
            -- auto close
            require("neo-tree.command").execute({ action = "close" })
          end,
        },
      },
    },
  },
}
