{ ... }:
{
  programs.nixvim.extraFiles = {
    "ftplugin/go.lua".text = ''
      vim.opt.tabstop = 4
      vim.opt.shiftwidth = 4
    '';
    "ftplugin/python.lua".text = ''
      vim.opt.tabstop = 4
      vim.opt.shiftwidth = 4
    '';
  };
}
