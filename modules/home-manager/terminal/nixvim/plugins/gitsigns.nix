{ ... }:
{
  programs.nixvim = {
    plugins.gitsigns = {
      enable = true;
      settings = {
        current_line_blame = true;
        current_line_blame_formatter = "    @<author>, <author_time:%Y-%m-%d> <summary> ";
        current_line_blame_formatter_nc = "    <author> ";
        current_line_blame_opts = {
          delay = 1000;
          virt_text = true;
          virt_text_pos = "eol";
        };
        signcolumn = true;
        watch_gitdir = {
          follow_files = true;
        };
      };
    };
    keymaps = [
      {
        action = "<cmd>Gitsigns preview_hunk<CR>";
        key = "<leader>gh";
        options = {
          desc = "Preview Hunk";
        };
      }
      {
        action = "<cmd>Gitsigns stage_hunk<CR>";
        key = "<leader>gsh";
        options = {
          desc = "Stage Hunk";
        };
      }
      {
        action = "<cmd>Gitsigns stage_buffer<CR>";
        key = "<leader>gsb";
        options = {
          desc = "Stage Buffer";
        };
      }
    ];
  };
}
