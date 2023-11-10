return 
  { 
    "catppuccin/nvim", 
    name = "catppuccin", 
    priority = 1000,
    config = function()
      require("catppuccin").setup({
        flavor = "mocha",
        background = {
          light = "latte",
          dark = "mocha",
        },
        transparent_background = true,
        show_end_of_buffer = false,
        styles = {
          comments = { "italic" },
          conditionals = { "italic" },
          keywords = { "italic" },
        },
        integrations = {
          flash = true,
          harpoon = true,
          markdown = true,
          mason = true,
          noice = true,
          cmp = true,
          mini = {
            enabled = true,
            indentscope_color = "surface0", -- catppuccin color (eg. `lavender`) Default: text
          },
          notify = true,
          nvimtree = true,
          telescope = {
            enabled = true,
            style = "astronvim",
          },
          treesitter = true,
          treesitter_context = true,
          window_picker = true,
          lsp_trouble = true,
          ufo = true,
          which_key = true,
          illuminate = {
            enabled = true,
            lsp = true,
          },
          navic = {
            enabled = true,
            custom_bg = "NONE", -- "lualine" will set background to mantle
          },
          highlights = {
            background = {
              bg = '#1e1e2e',
            }
          }
        },
        custom_highlights = function(colors)
          return {
            ColorColumn = { bg = "#181926" },
          }
        end
      })

      vim.cmd.colorscheme "catppuccin"
    end
  }

-- {
--     "kvrohit/mellow.nvim",
--     priority = 1000,
--     config = function()
--         vim.g.mellow_italic_booleans = true
--         vim.g.mellow_italic_keywords = true
--         vim.g.mellow_bold_comments = true
--         vim.g.mellow_bold_keywords = true
--         vim.g.mellow_transparent = true
--         vim.cmd([[colorscheme mellow]])
--     end
-- }
