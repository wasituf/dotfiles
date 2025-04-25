{ ... }:
{
  programs.nixvim = {
    plugins.tailwind-tools = {
      enable = true;
      settings = {
        conceal = {
          enabled = false;
          min_length = 40;
        };
        document_color = {
          enabled = true;
        };
      };
    };
    keymaps = [
      {
        action = "<cmd>TailwindSort<CR>";
        key = "<leader>cs";
        options = {
          desc = "Tailwind Sort";
        };
      }
    ];
  };
}
