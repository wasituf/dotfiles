return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 
    'nvim-lua/lsp-status.nvim',
    'SmiteshP/nvim-navic',
  },
  config = function()
    local custom_catppuccin = require'lualine.themes.catppuccin'
    local navic = require("nvim-navic")

    custom_catppuccin.normal.a.bg = '#b4befe'
    custom_catppuccin.visual.a.bg = '#f2cdcd'

    custom_catppuccin.normal.b.fg = '#b4befe'
    custom_catppuccin.visual.b.fg = '#f2cdcd'

    custom_catppuccin.normal.b.bg = '#313244'
    custom_catppuccin.visual.b.bg = '#313244'
    custom_catppuccin.insert.b.bg = '#313244'
    custom_catppuccin.replace.b.bg = '#313244'
    custom_catppuccin.command.b.bg = '#313244'

    custom_catppuccin.normal.c.bg = 'NONE'
    custom_catppuccin.normal.c.fg = '#a6adc8'

    require('lualine').setup {
      options = {
        icons_enabled = true,
        theme = custom_catppuccin,
        component_separators = { '' },
        section_separators = { left = '', right = '' },
        disabled_filetypes = {
          statusline = { 'NvimTree', 'Trouble' },
          winbar = { 'NvimTree', 'Trouble' },
        },
        ignore_focus = {},
        always_divide_middle = true,
        globalstatus = false,
        refresh = {
          statusline = 1000,
          tabline = 1000,
          winbar = 1000,
        }
      },
      sections = {
        lualine_a = {{ 'mode', icon = '󰄛', fmt = function(str) 
          if str == 'NORMAL' then
            return 'NRM'
          elseif str == 'COMMAND' then
            return 'CMD'
          else
            return str:sub(1,3) 
          end
        end }},
        lualine_b = {},
        lualine_c = {'branch', 'diff', 'diagnostics'},
        lualine_x = {'filetype'},
        lualine_y = {{'progress', fmt = function(str) return str .. ' ' end, }},
        lualine_z = {{ 'location', }}
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {'filename'},
        lualine_x = {'location'},
        lualine_y = {},
        lualine_z = {}
      },
      tabline = {},
      winbar = {
        lualine_c = {
          {
            "vim.fn.fnamemodify(vim.fn.getcwd(), ':t')", 
            icon = '',
            fmt = function(str) return str .. "  󱦰" end,
          },
          {
            'filename',
            file_status = false,
          },
          {
            "navic",
            color_correction = nil,
            navic_opts = {
              lsp = {
                auto_attach = true,
              },
              highlight = true,
              separator = "  󱦰  ",
              click = true,
            },
            fmt = function(str) return "✦  " .. str end,
          },
        },
        lualine_x = {
          {
            require('auto-session.lib').current_session_name,
          },
          {
            'datetime',
            style = "%B %d, %Y",
          }
        }
      },
      inactive_winbar = {
        lualine_x = {
          {
            'datetime',
            style = "%B %d, %Y",
          }
        }
      },
      extensions = { 'fugitive', 'fzf', 'lazy', 'man', 'mason', 'nvim-dap-ui', 'nvim-tree', 'quickfix', 'symbols-outline', 'trouble' }
    }
  end
}
