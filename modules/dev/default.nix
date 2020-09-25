# modules/dev --- common settings for dev modules

{ pkgs, ... }:
{
  imports = [
    ./cc.nix
    ./java.nix
    ./common-lisp.nix
    ./markdown.nix
    ./rust.nix
    ./python.nix
  ];

  options = {};
  config = {};
}
