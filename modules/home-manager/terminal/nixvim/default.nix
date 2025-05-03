{
  lib,
  config,
  inputs,
  ...
}:
with lib;
let
  cfg = config.modules.terminal.nixvim;
in
{
  imports = [
    inputs.nixvim.homeManagerModules.nixvim

    ./colorschemes.nix
    ./ftplugins.nix
    ./keymaps.nix
    ./options.nix
    ./plugins
  ];

  options.modules.terminal.nixvim = {
    enable = mkEnableOption "nixvim";
    colorscheme = mkOption {
      type = types.enum [
        "catppuccin"
        "rose-pine"
        "kanagawa"
      ];
      default = "kanagawa";
      description = "The colorscheme applied to neovim.";
    };
  };

  config = mkIf cfg.enable {
    programs.nixvim = {
      enable = true;
      defaultEditor = true;
      diagnostic.settings = {
        virtual_lines = {
          current_line = true;
        };
        virtual_text = false;
      };
      colorscheme = cfg.colorscheme;
      clipboard.providers = {
        xclip.enable = true;
        wl-copy.enable = true;
      };
      vimAlias = true;
    };
  };
}
