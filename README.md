<div align="center" >
	<img width="250" src="https://github.com/NixOS/nixos-artwork/raw/master/logo/nix-snowflake.svg" />
</div>
<div align="center" style="max-width: 100vw">
<h3>🔥 Dotfiles by <a href="https://github.com/wasituf">wasituf</a>
</div>
<div align="center" style="max-width: 100vw">
    <img src="https://img.shields.io/github/stars/wasituf/dotfiles?colorA=363a4f&colorB=b7bdf8&style=for-the-badge" style="max-width: 100%;" />
    <img src="https://img.shields.io/github/issues/catppuccin/github-readme-stats?colorA=363a4f&colorB=f5a97f&style=for-the-badge" style="max-width = 100%;" />
   	<img src="https://img.shields.io/badge/NIXOS-5277C3.svg?style=for-the-badge&logo=NixOS&logoColor=white" style="max-width: 100%;" />
</div>

<br />

# Screenshots

<details>
    <summary><em>Open fold to see...</em></summary>
    <div align="center" style="display: flex;justify-content: space-between;align-items: center;">
        <img src="/assets/screenshot_1.png" alt="screenshot" />
        <img src="/assets/screenshot_2.png" alt="screenshot" />
        <img src="/assets/screenshot_3.png" alt="screenshot" />
    </div>
</details>

# Introduction

This is my personal configuration of [NixOS](https://nixos.org/) along with all other configurations I use everyday. Obviously, this config is made to work for **me** and **my workflow** and might not work for **you**. I haven't done any extensive tests to check for hardware compatibility either. But still, I will actively try to make the config more easily customizable.

This configuration is based on my workflow, which consists of 3 main layers. The first layer is NixOS along with [ bspwm ](https://github.com/baskerville/bspwm). This layer enables a declarative approach to configurations, and also tiling windows 💪. The second layer broadly consists of [ kitty ](https://sw.kovidgoyal.net/kitty/) 🐱 (terminal emulator) and [ tmux ](https://github.com/tmux/tmux/wiki) (terminal multiplexer). This enables tiling in the terminal, and terminal sessions and windows, along with easy switching between them. The final layer is my text editor - [neovim](https://github.com/neovim/neovim) 😎. This philosophy of layers is taken from this [video](https://youtu.be/bdumjiHabhQ?si=F1usS9Mii9wbbcpG) by @theprimeagen (definitely worth a watch).

Before we dive in, I have to warn you this is pretty dense. So, for you employed folks out there, I have a [table of contents](#table-of-contents). Feel free to jump to specific sections and implement the parts of the configuration you're interested in. If a previous section is required, I'll hint it in the subheadings of each section.

# Table of contents

- [Introduction](#introduction)
- [Table of contents](#table-of-contents)
- [Getting Started](#getting-started)
  - [First things first](#first-things-first-)
  - [Implementing configuration.nix](#configurationnix)
  -

# Getting Started

This section will get you up and running with the very basics of this configuration without breaking anything in the process. 🤞

I will assume you have NixOS up and running. If not, check out the [Official NixOS Installation Manual](https://nixos.org/manual/nixos/unstable/). **Note of caution** - This manual is for the unstable version of NixOs. If you don't want secure boot (or other experimental features), you can install the stable version. To learn more about channels in NixOS, check out [Nix Channels](https://nixos.wiki/wiki/Nix_channels).

## First things first 🧨

- First, have to clone into or download this repository on your machine. This can be done in one of two ways - If you have [git](https://git-scm.com/) installed, then from your terminal run:

```bash
git clone https://github.com/wasituf/dotfiles.git ~/
```

- Or download this repository and unzip it in your home directory.
<br />
<div align="center" style="margin-top: 1rem"> <img src="/assets/download-instruction.png" /></div>
<br />

- Next, we will have to enable **[Flakes](https://gcdnb.pbrd.co/images/O4wsqdEwxQRe.png)** in our NixOS install. Although this is an experimental feature, it is considered mostly stable by the community.
  To enable _flakes_, open /etc/nixos/configuration.nix in your text editor and add the following line:

```nix
nix.settings.experimental-features = [ "nix-command" "flakes" ];
```

- Now switch to your new configuration with:

```nix
sudo nixos-rebuild switch && reboot
```

- After rebooting, log in to your user session and copy _symlinks/nixos/flake.nix_ from _~/dotfiles_ to _/etc/nixos_<br>

```bash
sudo cp ~/dotfiles/symlinks/nixos/configuration.nix /etc/nixos
```

- This is probably a good time to say that I use [Lanzaboote](https://github.com/nix-community/lanzaboote) - a wip tool that enables secure boot support in NixOS. Obviously, this is not very stable and might **brick** of your system. So a **note of caution** - unless you strictly need secure boot, comment out/delete the following lines from flake.nix:<br>

```nix
{
    description = "A simple NixOS flake";

    inputs = {
        nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
        home-manager.url = "github:nix-community/home-manager";
        home-manager.inputs.nixpkgs.follows = "nixpkgs";

        # lanzaboote.url = "github:nix-community/lanzaboote";   <-- here
    };

    outputs = {
        self,
        nixpkgs,
        home-manager,
        # lanzaboote,
    } @ inputs: let
    inherit (self) outputs;
    in {
        # NixOS configuration entrypoint
        nixosConfigurations = {
            nixos = nixpkgs.lib.nixosSystem {
                specialArgs = { inherit inputs outputs; };
                modules = [
                    ./configuration.nix
                    # lanzaboote.nixosModules.Lanzaboote    <-- and here
                ];
            };
        };
    };
}
```

> If you absolutely cannot live without secure boot, you can install lanzaboote using the following guide: [Lanzaboote Quick Start Guide](https://github.com/nix-community/lanzaboote/blob/master/docs/QUICK_START.md). If you're interested in learning more about secure boot in NixOS, check out this page from the NixOS wiki: [Secure Boot](https://nixos.wiki/wiki/Secure_Boot).

- Now rebuild NixOS one more time. This should automatically detect the flake.nix file:

```bash
sudo nixos-rebuild switch && reboot
```

- If this doesn't detect the flake file automatically, try this command (replace 'your-username' with your configured username):<br>

```bash
sudo nixos-rebuild switch --flake '/etc/nixos#your-username'
```

## Configuration.nix

After the first steps, you should have the flake installed and the channels configured. The next step is to switch to our new configuration.nix file. This is should be done carefully and incrementally as not to break anything. The most common problem you'll face will be missing files, so lets tackle that first.

By now, you should have this repository cloned/downloaded, the next step is to put the files in the correct paths on your system.

## Neovim

### Plugins

| Name                  | Description                                                                    | ✅  |
| --------------------- | ------------------------------------------------------------------------------ | --- |
| auto-session          | Automatic session management.                                                  | ✅  |
| bufferline.nvim       | GUI-like bufferline tabs.                                                      | ✅  |
| nvim-cmp              | Completion plugin for Neovim.                                                  | ✅  |
| catppuccin/nvim       | Catppuccin colorscheme for Neovim.                                             | ✅  |
| conform.nvim          | Lightweight formatter plugin for Neovim.                                       | ✅  |
| flash.nvim            | Easier code navigation.                                                        | ✅  |
| lsp-zero.nvim         | Easy lsp setup.                                                                | ✅  |
| lualine.nvim          | Fast and easily configurable statusline.                                       | ✅  |
| mason.nvim            | Package manager for LSP servers.                                               | ✅  |
| mini.nvim             | Small and minimal plugins for Neovim.                                          | ✅  |
| nvim-navic            | Plugin for showing code context.                                               | ✅  |
| nvim-tree.lua         | File explorer tree for Neovim.                                                 | ✅  |
| nvim-treesitter       | Incremental parsing library for Neovim.                                        | ✅  |
| nvim-ufo              | Good-looking folds for Neovim.                                                 | ✅  |
| smart-splits.nvim     | Universal pane navigation and resizing.                                        | ✅  |
| telescope.nvim        | Extendable fuzzy finder for Neovim.                                            | ✅  |
| todo-comments.nvim    | Highlight, list and search todo comments.                                      | ✅  |
| trouble.nvim          | Pretty diagnostics list for Neovim.                                            | ✅  |
| undotree              | Undo history visualizer for Neovim.                                            | ✅  |
| web-tools             | Neovim wrapper for [browser-sync](https://github.com/BrowserSync/browser-sync) | ❌  |
| which-key.nvim        | Popup key bindings for Neovim.                                                 | ✅  |
| nvim-autopairs        | Autopairs for Neovim.                                                          | ❌  |
| indent-blankline.nvim | Indent guides for Neovim.                                                      | ❌  |
| vim-illuminate        | Highlight matching words from word under cursor                                | ❌  |
