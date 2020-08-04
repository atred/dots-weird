[
  (self: super: with super; {
    my = {
      ant-dracula = (callPackage ./ant-dracula.nix {});
    };
  })

  # emacsGit
  (import (builtins.fetchTarball https://github.com/nix-community/emacs-overlay/archive/master.tar.gz))
]
