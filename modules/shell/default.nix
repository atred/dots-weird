{ config, lib, pkgs, ... }:

{
  imports = [
    ./git.nix
    ./zsh.nix
  ];
}
