return {
  'akinsho/bufferline.nvim', 
  version = "*", 
  dependencies = 'nvim-tree/nvim-web-devicons',
  config = function()
    local bufferline = require('bufferline')
    local mocha = require("catppuccin.palettes").get_palette "mocha"

    bufferline.setup({
      options = {
        mode = "buffers",
        style_preset = bufferline.style_preset.default,
        indicator = {
          icon = '▍ ',
          style = 'icon'
        },
        buffer_close_icon = ' 󰅖',
        close_icon = ' ',
        tab_size = 12,
        diagnostics = "nvim_lsp",
        diagnostics_update_in_insert = false,
        diagnostics_indicator = function(count, level, diagnostics_dict, context)
          local s = " "
          for e, n in pairs(diagnostics_dict) do
            local sym = e == "error" and "  "
            or (e == "warning" and "  " or " " )
            s = s .. n .. sym
          end
          return s
        end,
        offsets = {
          {
            filetype = "NvimTree",
            text = "Nvim Tree",
            text_align = "center",
            separator = true
          }
        },
        color_icons = true,
      },
      highlights = require("catppuccin.groups.integrations.bufferline").get {
        styles = { "bold" },
      },
    })
    end
}
