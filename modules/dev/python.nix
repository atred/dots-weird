# modules/dev/python.nix --- https://godotengine.org/
#
# Python's ecosystem repulses me. The list of environment "managers" exhausts
# me. The Py2->3 transition make trainwrecks jealous. But SciPy, NumPy, iPython
# and Jupyter can have my babies. Every single one.

{ config, options, lib, pkgs, ... }:
with lib;
{
  options.modules.dev.python = {
    enable = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkIf config.modules.dev.python.enable {
    my = {
      packages = with pkgs; [
        python37
        python37Packages.pip
        python37Packages.ipython
        python37Packages.black
        python37Packages.setuptools
        python37Packages.pylint
        python37Packages.poetry
      ];
    };
  };
}
