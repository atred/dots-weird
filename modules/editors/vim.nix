# When I'm stuck in the terminal or don't have access to Emacs, (neo)vim is my
# go-to. I am a vimmer at heart, after all.

{ config, options, lib, pkgs, ... }:
with lib;
{
  options.modules.editors.vim = {
    enable = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkIf config.modules.editors.vim.enable {
    my = {
      packages = with pkgs; [
        editorconfig-core-c
        neovim
      ];

      home.programs.neovim = {
        enable = true;
        vimAlias = true;
        vimdiffAlias = true;
        extraConfig = builtins.readFile <config/vim/extraConfig.vim>;

        plugins = with pkgs.vimPlugins; [
          vim-nix
          rust-vim
          nord-vim
          lightline-vim
        ];
      };
    };
  };
}
