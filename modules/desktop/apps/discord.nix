{ config, options, lib, pkgs, ... }:
with lib;
{
  options.modules.desktop.apps.discord = {
    enable = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkIf config.modules.desktop.apps.discord.enable {
    nixpkgs.config.allowUnfree = true;
    my.packages = with pkgs; [
      discord
      # ripcord
    ];
  };
}
