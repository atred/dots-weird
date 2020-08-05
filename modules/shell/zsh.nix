# modules/shell/zsh.nix --- ...

{ config, options, pkgs, lib, ... }:
with lib;
{
  options.modules.shell.zsh = {
    enable = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkIf config.modules.shell.zsh.enable {
    my = {
      packages = with pkgs; [
        zsh
        oh-my-zsh
        nix-zsh-completions
        fd
        fzf
        htop
        gotop
        tldr
        tree
      ];

      home.home.file.".zshrc".source = <config/zsh/rc>;
    };

    programs.zsh = {
      enable = true;
      shellAliases = {
        gs = "git status";
      };
      ohMyZsh = {
        enable = true;
        theme = "frisk";
        plugins = [ "git" ];
      };
    };
  };
}
