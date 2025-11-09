{ ... }:
{
  programs.nixvim.plugins.render-markdown = {
    enable = true;
    settings = {
      pipe_table = {
        preset = "round";
      };
      bullet = {
        icons = [
          " "
          " "
          " "
          " "
        ];
        highlight = "@comment";
      };
      indent = {
        enabled = true;
        skip_heading = true;
        icon = "";
      };
      html = {
        comment = {
          conceal = false;
        };
      };
    };
  };
}
