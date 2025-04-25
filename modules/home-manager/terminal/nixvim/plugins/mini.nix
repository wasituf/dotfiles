{ ... }:
{
  programs.nixvim.plugins = {
    mini = {
      enable = true;
      mockDevIcons = true;
      modules = {
        pairs = { };
        comment = {
          custom_commentstring = {
            __raw = ''
              function()
                return require('ts_context_commentstring').calculate_commentstring() or vim.bo.commentstring
              end
            '';
          };
          mappings = {
            comment = "gc";
            comment_line = "gcc";
            comment_visual = "gc";
            textobject = "gc";
          };
        };
        icons = { };
        # indentscope = {
        #   draw = {
        #     delay = 1;
        #     animation = {
        #       __raw = ''require("mini.indentscope").gen_animation.quadratic({ easing = "out", duration = 100, unit = "total" })'';
        #     };
        #   };
        #   mappings = {
        #     # Textobjects
        #     object_scope = "hh";
        #     object_scope_with_border = "ai";
        #
        #     # Motions (jump to respective border line; if not present - body line)
        #     goto_top = "[h";
        #     goto_bottom = "]h";
        #   };
        #   symbol = "▎";
        # };
        surround = {
          mappings = {
            add = "gsa";
            delete = "gsd";
            find = "gsf";
            find_left = "gsF";
            highlight = "gsh";
            replace = "gsr";
            update_n_lines = "gsn";
          };
        };
      };

    };
  };
}
