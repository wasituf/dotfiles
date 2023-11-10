return { 
  'echasnovski/mini.nvim',
  version = false,
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    -- Plugins to enable
    -- require('mini.animate').setup()
    require('mini.comment').setup()
    require('mini.cursorword').setup()
    require('mini.indentscope').setup({
      draw = {
        delay = 1,
        -- animation = require('mini.indentscope').gen_animation.quadratic({ easing = 'out', duration = 100, unit = 'total' })
        animation = require('mini.indentscope').gen_animation.none()
      },
      mappings = {
        -- Textobjects
        object_scope = 'hh',
        object_scope_with_border = 'ai',

        -- Motions (jump to respective border line; if not present - body line)
        goto_top = '[h',
        goto_bottom = ']h',
      },
      symbol = '▎',
    })
    require('mini.pairs').setup()
    require('mini.surround').setup()
  end,
} 
