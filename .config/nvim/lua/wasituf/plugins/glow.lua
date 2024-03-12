return {
  "ellisonleao/glow.nvim", 
  lazy = true,
  config = function()
    require("glow").setup({
      border = "rounded",
      style = "dark",
      width = 100,
      height = 200,
      width_ratio = 0.8,
      height_ratio = 0.8
    })
  end, 
  cmd = "Glow"
}
