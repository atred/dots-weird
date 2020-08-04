{ config, lib, pkgs, ... }:

{
  imports = [
    ./spotify.nix
    ./mpv.nix
  ];
}
