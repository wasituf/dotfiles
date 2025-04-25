{ ... }:
{
  programs.nixvim = {
    plugins.conjure.enable = true;

    keymaps = [
      {
        action = "<cmd>ConjureEval<CR>";
        key = "<leader>ee";
        options = {
          desc = "Eval current form";
        };
        mode = [ "n" ];
      }
      {
        action = "<cmd>ConjureEvalVisual<CR>";
        key = "<leader>ee";
        options = {
          desc = "Eval selection";
        };
        mode = [ "x" ];
      }
      {
        action = "<cmd>ConjureEvalBuf<CR>";
        key = "<leader>eb";
        options = {
          desc = "Eval current buffer";
        };
        mode = [
          "n"
          "x"
        ];
      }
      {
        action = "<cmd>ConjureEvalCommentCurrentForm<CR>";
        key = "<leader>ece";
        options = {
          desc = "Eval current form w/ comment";
        };
        mode = [
          "n"
        ];
      }
      {
        action = "<cmd>ConjureEvalRootForm<CR>";
        key = "<leader>er";
        options = {
          desc = "Eval root form";
        };
        mode = [
          "n"
        ];
      }
      {
        action = "<cmd>ConjureEvalCommentRootForm<CR>";
        key = "<leader>ecr";
        options = {
          desc = "Eval root form w/ comment";
        };
        mode = [
          "n"
        ];
      }
      {
        action = "<cmd>ConjureEvalWord<CR>";
        key = "<leader>ew";
        options = {
          desc = "Eval word under cursor";
        };
        mode = [
          "n"
        ];
      }
      {
        action = "<cmd>ConjureEvalCommentWord<CR>";
        key = "<leader>ecw";
        options = {
          desc = "Eval word under cursor w/ comment";
        };
        mode = [
          "n"
        ];
      }
      {
        action = "<cmd>ConjureEvalReplaceForm<CR>";
        key = "<leader>e!";
        options = {
          desc = "Eval replace current form";
        };
        mode = [
          "n"
        ];
      }
    ];
  };
}
