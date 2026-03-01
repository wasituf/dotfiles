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
    "ftplugin/gdscript.lua".text = ''
      vim.opt.tabstop = 4
      vim.opt.shiftwidth = 4
    '';
    "ftplugin/java.lua".text = ''
      vim.opt.tabstop = 4
      vim.opt.shiftwidth = 4
    '';
  };
}
