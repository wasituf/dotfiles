{ ... }:
{
  programs.nixvim = {
    plugins.nvim-ufo = {
      enable = true;
    };
    opts = {
      foldcolumn = "1";
      foldlevel = 99;
      foldlevelstart = 99;
      foldenable = true;
    };
  };
}
