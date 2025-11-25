{
  lib,
  config,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.modules.terminal.programs.yazi;
in
{
  options.modules.terminal.programs.yazi = {
    enable = mkEnableOption "yazi";
    theme = mkOption {
      type = types.enum [
        "rose-pine"
        "catppuccin"
      ];
      default = "rose-pine";
      description = "Theme to use for yazi";
    };
  };

  config = mkIf cfg.enable {
    programs.yazi = {
      enable = true;
      enableFishIntegration = true;
      enableBashIntegration = true;
      shellWrapperName = "fp";
      flavors = {
        rose-pine = ./rose-pine.yazi;
      };
      theme = {
        flavor = {
          dark = cfg.theme;
          light = cfg.theme;
        };
      };
      plugins = with pkgs.yaziPlugins; {
        dupes = dupes;
        full-border = full-border;
        git = git;
        piper = piper;
        smart-enter = smart-enter;
        smart-filter = smart-filter;
        smart-paste = smart-paste;
      };
      settings = {
        opener = {
          browser-open = [
            {
              run = ''zen-beta "$@"'';
              orphan = true;
              for = "unix";
            }
            {
              run = ''brave "$@"'';
              orphan = true;
              for = "unix";
            }
          ];
          yacreader-open = [
            {
              run = ''YACReader "$@"'';
            }
          ];
          play = [
            {
              run = ''mpv --force-window "$@"'';
              orphan = true;
              for = "unix";
            }
            {
              run = ''vlc "$@"'';
              orphan = true;
              for = "unix";
            }
          ];
        };
        open = {
          prepend_rules = [
            {
              mime = "application/pdf";
              use = [
                "open"
                "browser-open"
                "yacreader-open"
                "reveal"
              ];
            }
            {
              mime = "image/*";
              use = [
                "open"
                "browser-open"
                "reveal"
              ];
            }
          ];
        };
        plugin = {
          prepend_fetchers = [
            {
              id = "git";
              name = "*";
              run = "git";
            }
            {
              id = "git";
              name = "*/";
              run = "git";
            }
          ];
          prepend_previewers = [
            {
              url = "*.tar";
              run = ''piper --format=url -- tar tf "$1"'';
            }
            {
              url = "*.csv";
              run = ''piper -- bat -p --color=always "$1"'';
            }
            {
              url = "*.md";
              run = ''piper -- CLICOLOR_FORCE=1 glow -w=$w -s=dark "$1"'';
            }
            {
              url = "*/";
              run = ''piper -- eza -TL=3 --color=always --icons=always --group-directories-first --no-quotes "$1"'';
            }
          ];
        };
      };
      initLua = ''
        -- Comments with lua
        -- require("full-border"):setup()
        require("git"):setup()
        require("dupes"):setup {
          save_op = false,
          profiles = {
            interactive = {
              args = { "-r" },
            },
            apply = {
              args = { "-r", "-N", "-d" },
              save_op = true,
            },
            shallow = {
              args = {},
            },
          },
        }
      '';
      keymap = {
        mgr = {
          keymap = [
            # Dupes
            {
              on = [
                "A-J"
                "i"
              ];
              run = "plugin dupes interactive";
              desc = "Run dupes interactive";
            }
            {
              on = [
                "A-J"
                "o"
              ];
              run = "plugin dupes override";
              desc = "Run dupes override";
            }
            {
              on = [
                "A-J"
                "d"
              ];
              run = "plugin dupes dry";
              desc = "Run dupes dry";
            }
            {
              on = [
                "A-J"
                "a"
              ];
              run = "plugin dupes apply";
              desc = "Run dupes apply";
            }
            {
              on = [
                "A-J"
                "s"
              ];
              run = "plugin dupes shallow";
              desc = "Run dupes shallow";
            }

            # Smart Enter
            {
              on = [ "i" ];
              run = "plugin smart-enter";
              desc = "Enter the child directory, or open the file";
            }
            {
              on = [ "<Enter>" ];
              run = "plugin smart-enter";
              desc = "Enter the child directory, or open the file";
            }

            # Smart Filter
            {
              on = [ "f" ];
              run = "plugin smart-filter";
              desc = "Smart filter";
            }

            # Smart paste
            {
              on = [ "p" ];
              run = "plugin smart-paste";
              desc = "Paste into the hovered directory or CWD";
            }

            # General
            {
              on = "<Esc>";
              run = "escape";
              desc = "Exit visual mode; clear selection; or cancel
              search";
            }
            {
              on = "<C-[>";
              run = "escape";
              desc = "Exit visual mode; clear selection; or cancel
              search";
            }
            {
              on = "q";
              run = "quit";
              desc = "Quit the process";
            }
            {
              on = "Q";
              run = "quit --no-cwd-file";
              desc = "Quit without outputting cwd-file";
            }
            {
              on = "<C-t>";
              run = "close";
              desc = "Close the current tab; or quit if it's last";
            }
            {
              on = "<C-z>";
              run = "suspend";
              desc = "Suspend the process";
            }

            # Hopping
            {
              on = "e";
              run = "arrow prev";
              desc = "Previous file";
            }
            {
              on = "n";
              run = "arrow next";
              desc = "Next file";
            }

            {
              on = "<Up>";
              run = "arrow prev";
              desc = "Previous file";
            }
            {
              on = "<Down>";
              run = "arrow next";
              desc = "Next file";
            }

            {
              on = "<C-e>";
              run = "arrow -50%";
              desc = "Move cursor up half page";
            }
            {
              on = "<C-n>";
              run = "arrow 50%";
              desc = "Move cursor down half page";
            }

            {
              on = [
                "g"
                "g"
              ];
              run = "arrow top";
              desc = "Go to top";
            }
            {
              on = "G";
              run = "arrow bot";
              desc = "Go to bottom";
            }

            # Navigation
            {
              on = "m";
              run = "leave";
              desc = "Back to the parent directory";
            }
            {
              on = "i";
              run = "enter";
              desc = "Enter the child directory";
            }

            {
              on = "<Left>";
              run = "leave";
              desc = "Back to the parent directory";
            }
            {
              on = "<Right>";
              run = "enter";
              desc = "Enter the child directory";
            }

            {
              on = "M";
              run = "back";
              desc = "Back to previous directory";
            }
            {
              on = "I";
              run = "forward";
              desc = "Forward to next directory";
            }

            # Toggle
            {
              on = "<Space>";
              run = [
                "toggle"
                "arrow next"
              ];
              desc = "Toggle the current selection state";
            }
            {
              on = "<C-a>";
              run = "toggle_all --state=on";
              desc = "Select all files";
            }
            {
              on = "<C-r>";
              run = "toggle_all";
              desc = "Invert selection of all files";
            }

            # Visual mode
            {
              on = "v";
              run = "visual_mode";
              desc = "Enter visual mode (selection mode)";
            }
            {
              on = "V";
              run = "visual_mode --unset";
              desc = "Enter visual mode (unset mode)";
            }

            # Seeking
            {
              on = "E";
              run = "seek -5";
              desc = "Seek up 5 units in the preview";
            }
            {
              on = "N";
              run = "seek 5";
              desc = "Seek down 5 units in the preview";
            }

            # Spotting
            {
              on = "<Tab>";
              run = "spot";
              desc = "Spot hovered file";
            }

            # Operation
            {
              on = "o";
              run = "open";
              desc = "Open selected files";
            }
            {
              on = "O";
              run = "open --interactive";
              desc = "Open selected files interactively";
            }
            {
              on = "y";
              run = "yank";
              desc = "Yank selected files (copy)";
            }
            {
              on = "x";
              run = "yank --cut";
              desc = "Yank selected files (cut)";
            }
            {
              on = "p";
              run = "paste";
              desc = "Paste yanked files";
            }
            {
              on = "P";
              run = "paste --force";
              desc = "Paste yanked files (overwrite if the destination exists)";
            }
            {
              on = "-";
              run = "link";
              desc = "Symlink the absolute path of yanked files";
            }
            {
              on = "_";
              run = "link --relative";
              desc = "Symlink the relative path of yanked files";
            }
            {
              on = "<C-->";
              run = "hardlink";
              desc = "Hardlink yanked files";
            }
            {
              on = "Y";
              run = "unyank";
              desc = "Cancel the yank status";
            }
            {
              on = "X";
              run = "unyank";
              desc = "Cancel the yank status";
            }
            {
              on = "d";
              run = "remove";
              desc = "Trash selected files";
            }
            {
              on = "D";
              run = "remove --permanently";
              desc = "Permanently delete selected files";
            }
            {
              on = "a";
              run = "create";
              desc = "Create a file (ends with / for directories)";
            }
            {
              on = "r";
              run = "rename --cursor=before_ext";
              desc = "Rename selected file(s)";
            }
            {
              on = ";";
              run = "shell --interactive";
              desc = "Run a shell command";
            }
            {
              on = ":";
              run = "shell --block --interactive";
              desc = "Run a shell command (block until finishes)";
            }
            {
              on = ".";
              run = "hidden toggle";
              desc = "Toggle the visibility of hidden files";
            }
            {
              on = "s";
              run = "search --via=fd";
              desc = "Search files by name via fd";
            }
            {
              on = "S";
              run = "search --via=rg";
              desc = "Search files by content via ripgrep";
            }
            {
              on = "<C-s>";
              run = "escape --search";
              desc = "Cancel the ongoing search";
            }
            {
              on = "z";
              run = "plugin fzf";
              desc = "Jump to a file/directory via fzf";
            }
            {
              on = "Z";
              run = "plugin zoxide";
              desc = "Jump to a directory via zoxide";
            }

            # Linemode
            {
              on = [
                "h"
                "s"
              ];
              run = "linemode size";
              desc = "Linemode: size";
            }
            {
              on = [
                "h"
                "p"
              ];
              run = "linemode permissions";
              desc = "Linemode: permissions";
            }
            {
              on = [
                "h"
                "b"
              ];
              run = "linemode btime";
              desc = "Linemode: btime";
            }
            {
              on = [
                "h"
                "m"
              ];
              run = "linemode mtime";
              desc = "Linemode: mtime";
            }
            {
              on = [
                "h"
                "o"
              ];
              run = "linemode owner";
              desc = "Linemode: owner";
            }
            {
              on = [
                "h"
                "n"
              ];
              run = "linemode none";
              desc = "Linemode: none";
            }

            # Copy
            {
              on = [
                "c"
                "c"
              ];
              run = "copy path";
              desc = "Copy the file path";
            }
            {
              on = [
                "c"
                "d"
              ];
              run = "copy dirname";
              desc = "Copy the directory path";
            }
            {
              on = [
                "c"
                "f"
              ];
              run = "copy filename";
              desc = "Copy the filename";
            }
            {
              on = [
                "c"
                "n"
              ];
              run = "copy name_without_ext";
              desc = "Copy the filename without extension";
            }

            # Filter
            {
              on = "f";
              run = "filter --smart";
              desc = "Filter files";
            }

            # Find
            {
              on = "/";
              run = "find --smart";
              desc = "Find next file";
            }
            {
              on = "?";
              run = "find --previous --smart";
              desc = "Find previous file";
            }
            {
              on = "k";
              run = "find_arrow";
              desc = "Next found";
            }
            {
              on = "K";
              run = "find_arrow --previous";
              desc = "Previous found";
            }

            # Sorting
            {
              on = [
                ";"
                "m"
              ];
              run = [
                "sort mtime --reverse=no"
                "linemode mtime"
              ];
              desc = "Sort by modified time";
            }
            {
              on = [
                ";"
                "M"
              ];
              run = [
                "sort mtime --reverse"
                "linemode mtime"
              ];
              desc = "Sort by modified time (reverse)";
            }
            {
              on = [
                ";"
                "b"
              ];
              run = [
                "sort btime --reverse=no"
                "linemode btime"
              ];
              desc = "Sort by birth time";
            }
            {
              on = [
                ";"
                "B"
              ];
              run = [
                "sort btime --reverse"
                "linemode btime"
              ];
              desc = "Sort by birth time (reverse)";
            }
            {
              on = [
                ";"
                "e"
              ];
              run = "sort extension --reverse=no";
              desc = "Sort by extension";
            }
            {
              on = [
                ";"
                "E"
              ];
              run = "sort extension --reverse";
              desc = "Sort by extension (reverse)";
            }
            {
              on = [
                ";"
                "a"
              ];
              run = "sort alphabetical --reverse=no";
              desc = "Sort alphabetically";
            }
            {
              on = [
                ";"
                "A"
              ];
              run = "sort alphabetical --reverse";
              desc = "Sort alphabetically (reverse)";
            }
            {
              on = [
                ";"
                "n"
              ];
              run = "sort natural --reverse=no";
              desc = "Sort naturally";
            }
            {
              on = [
                ";"
                "N"
              ];
              run = "sort natural --reverse";
              desc = "Sort naturally (reverse)";
            }
            {
              on = [
                ";"
                "s"
              ];
              run = [
                "sort size --reverse=no"
                "linemode size"
              ];
              desc = "Sort by size";
            }
            {
              on = [
                ";"
                "S"
              ];
              run = [
                "sort size --reverse"
                "linemode size"
              ];
              desc = "Sort by size (reverse)";
            }
            {
              on = [
                ";"
                "r"
              ];
              run = "sort random --reverse=no";
              desc = "Sort randomly";
            }

            # Goto
            {
              on = [
                "g"
                "h"
              ];
              run = "cd ~";
              desc = "Go home";
            }
            {
              on = [
                "g"
                "c"
              ];
              run = "cd ~/dotfiles";
              desc = "Go dotfiles";
            }
            {
              on = [
                "g"
                "d"
              ];
              run = "cd ~/Downloads";
              desc = "Go downloads";
            }
            {
              on = [
                "g"
                "m"
              ];
              run = "cd /media";
              desc = "Go media";
            }
            {
              on = [
                "g"
                "n"
              ];
              run = "cd /media/Netflix";
              desc = "Go netflix";
            }
            {
              on = [
                "g"
                "<Space>"
              ];
              run = "cd --interactive";
              desc = "Jump interactively";
            }
            {
              on = [
                "g"
                "f"
              ];
              run = "follow";
              desc = "Follow hovered symlink";
            }

            # Tabs
            {
              on = "t";
              run = "tab_create --current";
              desc = "Create a new tab with CWD";
            }

            {
              on = "1";
              run = "tab_switch 0";
              desc = "Switch to first tab";
            }
            {
              on = "2";
              run = "tab_switch 1";
              desc = "Switch to second tab";
            }
            {
              on = "3";
              run = "tab_switch 2";
              desc = "Switch to third tab";
            }
            {
              on = "4";
              run = "tab_switch 3";
              desc = "Switch to fourth tab";
            }
            {
              on = "5";
              run = "tab_switch 4";
              desc = "Switch to fifth tab";
            }
            {
              on = "6";
              run = "tab_switch 5";
              desc = "Switch to sixth tab";
            }
            {
              on = "7";
              run = "tab_switch 6";
              desc = "Switch to seventh tab";
            }
            {
              on = "8";
              run = "tab_switch 7";
              desc = "Switch to eighth tab";
            }
            {
              on = "9";
              run = "tab_switch 8";
              desc = "Switch to ninth tab";
            }

            {
              on = "[";
              run = "tab_switch -1 --relative";
              desc = "Switch to previous tab";
            }
            {
              on = "]";
              run = "tab_switch 1 --relative";
              desc = "Switch to next tab";
            }

            {
              on = "{";
              run = "tab_swap -1";
              desc = "Swap current tab with previous tab";
            }
            {
              on = "}";
              run = "tab_swap 1";
              desc = "Swap current tab with next tab";
            }

            # Tasks
            {
              on = "w";
              run = "tasks:show";
              desc = "Show task manager";
            }

            # Help
            {
              on = "~";
              run = "help";
              desc = "Open help";
            }
            {
              on = "<F1>";
              run = "help";
              desc = "Open help";
            }
          ];
        };
        tasks = {
          prepend_keymap = [
            {
              on = "e";
              run = "arrow prev";
              desc = "Previous task";
            }
            {
              on = "n";
              run = "arrow next";
              desc = "Next task";
            }
            {
              on = "i";
              run = "inspect";
              desc = "Inspect the task";
            }
          ];
        };
        spot = {
          prepend_keymap = [
            {
              on = "e";
              run = "arrow prev";
              desc = "Previous line";
            }
            {
              on = "n";
              run = "arrow next";
              desc = "Next line";
            }
            {
              on = "m";
              run = "swipe prev";
              desc = "Swipe to previous file";
            }
            {
              on = "i";
              run = "swipe next";
              desc = "Swipe to next file";
            }
          ];
        };
        pick = {
          prepend_keymap = [
            {
              on = "e";
              run = "arrow prev";
              desc = "Previous option";
            }
            {
              on = "n";
              run = "arrow next";
              desc = "Next option";
            }
          ];
        };
        input = {
          prepend_keymap = [
            {
              on = "h";
              run = "insert";
              desc = "Enter insert mode";
            }
            {
              on = "H";
              run = [
                "move first-char"
                "insert"
              ];
              desc = "Move to the BOL, and enter insert mode";
            }
            {
              on = "m";
              run = "move -1";
              desc = "Move back a character";
            }
            {
              on = "i";
              run = "move 1";
              desc = "Move forward a character";
            }
            {
              on = "l";
              run = "forward --end-of-word";
              desc = "Move forward to the end of the current or next word";
            }
            {
              on = "L";
              run = "forward --far --end-of-word";
              desc = "Move forward to the end of the current or next WORD";
            }
          ];
        };
        confirm = {
          prepend_keymap = [
            {
              on = "e";
              run = "arrow prev";
              desc = "Previous item";
            }
            {
              on = "n";
              run = "arrow next";
              desc = "Next item";
            }
          ];
        };
        cmp = {
          prepend_keymap = [
            {
              on = "<C-e>";
              run = "arrow prev";
              desc = "Previous item";
            }
            {
              on = "<C-n>";
              run = "arrow next";
              desc = "Next item";
            }
          ];
        };
        help = {
          prepend_keymap = [
            {
              on = "e";
              run = "arrow prev";
              desc = "Previous item";
            }
            {
              on = "n";
              run = "arrow next";
              desc = "Next item";
            }
          ];
        };
      };
    };

    home.packages = with pkgs; [
      bat
      git
      glow
      jdupes
      mediainfo
      wl-clipboard
    ];
  };
}
