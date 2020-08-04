# modules/dev/clojure.nix --- https://clojure.org/

{ config, options, lib, pkgs, ... }:
with lib;
{
  options.modules.dev.clojure = {
    enable = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkIf config.modules.dev.clojure.enable {
    my.packages = with pkgs; [
      clojure
      joker
      leiningen
    ];
  };
}
