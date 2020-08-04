# modules/desktop/apps/vm.nix

{ config, options, lib, pkgs, ... }:
with lib;
{
  options.modules.desktop.apps.vm = {
    enable = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkIf config.modules.desktop.apps.vm.enable {
    virtualisation.virtualbox.host = {
      enable = true;
    };

    my.user.extraGroups = [ "vboxusers" ];
  };
}
