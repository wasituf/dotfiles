{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.modules.emacs;
in
{
  options.modules.emacs = {
    enable = mkEnableOption "emacs";
    enableDaemon = mkEnableOption "Enable the emacs daemon.";
    colorscheme = mkOption {
      type = types.enum [
        "kanagawa-wave"
        "catppuccin"
        "rose-pine"
      ];
      default = "kanagawa-wave";
      description = "Theme for emacs";
      example = "catppuccin";
    };
  };

  config = mkIf cfg.enable {
    services.emacs = {
      enable = cfg.enableDaemon;
      client.enable = true;
      startWithUserSession = true;
    };

    programs.emacs = {
      enable = true;
      package = pkgs.emacs-gtk;
      extraPackages = (
        epkgs: with epkgs; [
          # Core
          use-package

          # Main packages
          evil
          format-all
          lsp-mode
          magit
          org

          # Util packages
          all-the-icons
          autothemer
          doom-modeline
          drag-stuff
          general
          literate-elisp
          org-modern
          scroll-on-jump
          toc-org
          vertico
          which-key
          yasnippet
          yasnippet-snippets

          # Theme packages
          catppuccin-theme
          kanagawa-themes
        ]
      );
    };

    home.packages = with pkgs; [
      fd
      ripgrep
      git
    ];

    home.file = {
      ".config/emacs/config.org".source = ./config.org;
      ".config/emacs/themes/rose-pine-theme.el".source = ./rose-pine-theme.el;
      ".config/emacs/init.el".text = ''
        ; (load "~/.config/emacs/themes/rose-pine-theme.el")
        (load-theme '${cfg.colorscheme} t)

        ;; Enable org-mode 
        (use-package org)
        (require 'org)

        (use-package literate-elisp)
        (literate-elisp-load "~/.config/emacs/config.org")
      '';
    };
  };
}
