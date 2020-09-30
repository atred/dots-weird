[
  (self: super: with super; {
    my = {
      gtk-dracula = (callPackage ./dracula.nix {});
    };
  })

  # emacsGit
  (import (builtins.fetchTarball https://github.com/nix-community/emacs-overlay/archive/master.tar.gz))
]
