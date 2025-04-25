{ user, ... }:
{
  programs.nixvim = {
    globals = {
      have_nerd_font = true;
    };
    opts = {
      updatetime = 50;
      # Decrease mapped sequence wait time
      # Displays which-key popup sooner
      timeoutlen = 300;

      background = "dark";
      winborder = "rounded";

      # Line numbers
      relativenumber = true;
      number = true;
      hidden = true;
      mouse = "a";
      mousemodel = "extend";

      hlsearch = false;
      incsearch = true;
      inccommand = "split";
      ignorecase = true;
      smartcase = true;
      scrolloff = 8;

      cursorline = true;
      cursorcolumn = false;
      colorcolumn = "80";
      signcolumn = "yes";

      termguicolors = true;
      spell = false;
      nu = true;

      showmode = true;

      # Tabs
      tabstop = 2;
      softtabstop = 2;
      shiftwidth = 2;
      expandtab = true;

      autoindent = true;
      smartindent = true;
      wrap = true;
      linebreak = true;
      breakindent = true;

      swapfile = false;
      backup = false;
      undodir = "/home/${user}/.vim/undodir";
      undofile = true;

      textwidth = 100;

      # Misc
      laststatus = 3;
    };
  };
}
