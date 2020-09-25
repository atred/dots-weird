# modules/dev/markdown.nix --- Markdown

{ config, options, lib, pkgs, ... }:
with lib;
{
  options.modules.dev.markdown = {
    enable = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkIf config.modules.dev.markdown.enable {
    my.packages = with pkgs; [
      pandoc
    ];
  };
}
