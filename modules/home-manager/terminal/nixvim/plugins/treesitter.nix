{ ... }:
{
  programs.nixvim.plugins = {
    treesitter = {
      enable = true;
      folding = false;
      settings = {
        highlight.enable = true;
        indent.enable = true;
      };
    };
    ts-autotag = {
      enable = true;
      settings = {
        opts = {
          enable_rename = true;
          enable_close = true;
          enable_close_on_slash = true;
        };
      };
    };
    treesitter-context = {
      enable = true;
      settings = {
        # mode = "topline"; # topline | cursor
        separator = "-";
      };
    };
    ts-context-commentstring = {
      enable = true;
      extraOptions = {
        enable_autocmd = false;
      };
    };
    ts-comments = {
      enable = true;
    };
  };
}
