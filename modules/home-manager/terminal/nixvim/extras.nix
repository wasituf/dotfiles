{ pkgs, ... }:
{
  programs.nixvim = {
    extraPackages = with pkgs; [
      # vimPlugins.tailwind-tools-nvim

      ripgrep
      fzf
    ];
    extraConfigLua = ''
      vim.cmd [[cabbrev wq execute "Format sync" <bar> wq]]
    '';
  };
}
