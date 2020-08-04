# default.nix --- the heart of my dotfiles
#
# Author:  Andrew Redinbo <atredinbo@gmail.com>
#          Henrik Lissner <henrik@lissner.net>
# URL:     https://github.com/atred/dots
# License: MIT
#
# This is ground zero, where the absolute essentials go, to be present on all
# systems I use nixos on. Most of which are single user systems (the ones that
# aren't are configured from their hosts/*/default.nix).

device: username:
{ pkgs, options, lib, config, ... }:
{
  networking.hostName = lib.mkDefault device;
  my.username = username;

  imports = [
    ./modules
    "${./hosts}/${device}"
  ];

  ### NixOS
  nix.autoOptimiseStore = true;
  nix.nixPath = options.nix.nixPath.default ++ [
    # So we can use absolute import paths
    "bin=/etc/dots/bin"
    "config=/etc/dots/config"
  ];

  # Add custom packages & unstable channel, so they can be accessed via pkgs.*
  nixpkgs.overlays = import ./packages;

  # These are the things I want installed on all my systems
  environment.systemPackages = with pkgs; [
    # Just the bare essentials
    coreutils
    git
    killall
    unzip
    neovim
    wget
    sshfs
    ripgrep
    gnumake # for makefile
  ];

  environment.shellAliases = {
    nix-shell = ''NIX_PATH="nixpkgs-overlays=/etc/dotfiles/packages/default.nix:$NIX_PATH" nix-shell'';
    nsh = "nix-shell";
    nen = "nix-env";
    dots = "make -C ~/dots"
  };

  # Default settings for primary user account. `my` is defined in
  # modules/default.nix
  my.user = {
    isNormalUser = true;
    uid = 1000;
    extraGroups = [ "wheel" "networkmanager" "video" ];
    shell = pkgs.zsh;
  };

  # Locale and tty settings
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "20.03"; # Did you read the comment?
}
