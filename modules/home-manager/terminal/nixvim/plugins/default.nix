{ pkgs, ... }:
{
  imports = [
    ./auto-session.nix
    ./cmp.nix
    ./conjure.nix
    ./extra-plugins.nix
    ./fugitive.nix
    ./fzf-lua.nix
    ./gitsigns.nix
    ./hmts.nix
    ./lsp.nix
    ./lualine.nix
    ./lz-n.nix
    ./markview.nix
    ./mini.nix
    ./neo-tree.nix
    ./nvim-ufo.nix
    ./rainbow-delimiters.nix
    # ./render-markdown.nix
    ./smart-splits.nix
    ./snacks.nix
    ./tailwind-tools.nix
    ./todo-comments.nix
    ./treesitter.nix
    ./undotree.nix
    ./vim-be-good.nix
    ./vimtex.nix
    ./which-key.nix
  ];
}
