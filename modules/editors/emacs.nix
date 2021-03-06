# Emacs is my main driver.  This module sets it up to meet my
# particular Doomy needs.

{ config, options, lib, pkgs, ... }:
with lib;
{
  options.modules.editors.emacs = {
    enable = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkIf config.modules.editors.emacs.enable {
    my = {
      packages = with pkgs; [
        ## Doom dependencies
        emacsUnstable
        git
        (ripgrep.override {withPCRE2 = true;})
        gnutls              # for TLS connectivity

        ## Optional dependencies
        fd                  # faster projectile indexing
        imagemagick         # for image-dired
        (lib.mkIf (config.programs.gnupg.agent.enable)
          pinentry_emacs)   # in-emacs gnupg prompts
        zstd                # for undo-fu-session/undo-tree compression

        ## Module dependencies
        # :checkers spell
        aspell
        aspellDicts.en
        aspellDicts.en-computers
        aspellDicts.en-science
        # :checkers grammar
        languagetool
        # :tools editorconfig
        editorconfig-core-c # per-project style config
        # :tools lookup & :lang org +roam
        # sqlite
        # :lang cc
        ccls
        glslang
        # :lang javascript
        # nodePackages.javascript-typescript-langserver
        # :lang latex & :lang org (latex previews)
        # texlive.combined.scheme-medium
        # :lang nix
        nixfmt
        # :lang rust
        #rustfmt
        #rls
        # :lang sh
        shellcheck
      ];
    };

    programs.zsh.shellAliases = {
      doom = "~/.emacs.d/bin/doom";
    };

    fonts.fonts = [
      pkgs.emacs-all-the-icons-fonts
    ];
  };
}
