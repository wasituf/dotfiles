return { 
  "lukas-reineke/indent-blankline.nvim", 
  main = "ibl", 
  lazy = true,
  event = { "BufReadPre", "BufNewFile" },
  opts = {},
  config = function()
    require('ibl').setup()
  end
}
