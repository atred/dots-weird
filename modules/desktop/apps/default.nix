{ config, lib, pkgs, ... }:

{
  imports = [
    ./discord.nix
    ./rofi.nix
    ./vm.nix
  ];
}
