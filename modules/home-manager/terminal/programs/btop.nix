{ config, lib, ... }:
with lib;
let
  cfg = config.modules.terminal.programs.btop;
in
{
  options.modules.terminal.programs.btop = {
    enable = mkEnableOption "btop";
  };

  config = mkIf cfg.enable {
    programs.btop = {
      enable = true;
      settings = {
        color_theme = "kanagawa";
        theme_background = false;
        update_ms = 1000;
        proc_sorting = "memory";
      };
      themes = {
        kanagawa = ''
          theme[main_bg]="#16161D"
          theme[main_fg]="#dcd7ba"
          theme[title]="#dcd7ba"
          theme[hi_fg]="#C34043"
          theme[selected_bg]="#223249"
          theme[selected_fg]="#dca561"
          theme[inactive_fg]="#727169"
          theme[proc_misc]="#7aa89f"
          theme[cpu_box]="#727169"
          theme[mem_box]="#727169"
          theme[net_box]="#727169"
          theme[proc_box]="#727169"
          theme[div_line]="#727169"
          theme[temp_start]="#98BB6C"
          theme[temp_mid]="#DCA561"
          theme[temp_end]="#E82424"
          theme[cpu_start]="#98BB6C"
          theme[cpu_mid]="#DCA561"
          theme[cpu_end]="#E82424"
          theme[free_start]="#E82424"
          theme[free_mid]="#C34043"
          theme[free_end]="#FF5D62"
          theme[cached_start]="#C0A36E"
          theme[cached_mid]="#DCA561"
          theme[cached_end]="#FF9E3B"
          theme[available_start]="#938AA9"
          theme[available_mid]="#957FBB"
          theme[available_end]="#9CABCA"
          theme[used_start]="#658594"
          theme[used_mid]="#7E9CDB"
          theme[used_end]="#7FB4CA"
          theme[download_start]="#7E9CDB"
          theme[download_mid]="#938AA9"
          theme[download_end]="#957FBB"
          theme[upload_start]="#DCA561"
          theme[upload_mid]="#E6C384"
          theme[upload_end]="#E82424"
          theme[process_start]="#98BB6C"
          theme[process_mid]="#DCA561"
          theme[process_end]="#C34043"
        '';
      };
    };
  };
}
