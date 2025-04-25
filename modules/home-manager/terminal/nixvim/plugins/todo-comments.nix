{ ... }:
{
  programs.nixvim.plugins.todo-comments = {
    enable = true;
    keymaps = {
      todoFzfLua = {
        key = "<leader>st";
        options.desc = "Todo Comments";
      };
    };
  };
}
