return {
  "folke/flash.nvim",
  event = "VeryLazy",
  ---@type Flash.Config
  opts = {
    labels = "arstgmneioqwfpbjluyxcdvzkh",
    jump = {
      -- clear highlight after jump
      nohlsearch = true,
    },
    label = {
      -- allow uppercase labels
      uppercase = false,
      -- add a label for the first match in the current window.
      current = false,
    },
    -- You can override the default options for a specific mode.
    modes = {
      -- `f`, `F`, `t`, `T`, `;` and `,` motions
      char = {
        enabled = true,
        -- show jump labels
        jump_labels = true,
        -- When using jump labels, don't use these keys
        -- This allows using those keys directly after the motion
        label = { exclude = "mneiohardcxyp" },
      },
      treesitter = {
        labels = "arstmneioqwfpbjluyxcdvzkh",
        jump = { pos = "range" },
        search = { incremental = false },
        label = { before = true, after = true, style = "inline" },
        highlight = {
          backdrop = false,
          matches = false,
        },
      },
    },
    -- options for the floating window that shows the prompt,
    -- for regular jumps
    prompt = {
      enabled = true,
      prefix = { { "  ", "FlashPromptIcon" } },
      win_config = {
        relative = "editor",
        width = 1, -- when <=1 it's a percentage of the editor width
        height = 1,
        row = -3, -- when negative it's an offset from the bottom
        col = -1, -- when negative it's an offset from the right
        zindex = 1000,
      },
    },
  },
  -- stylua: ignore
  keys = {
    { "<CR>", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
    { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
    { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
    { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
  },
}
