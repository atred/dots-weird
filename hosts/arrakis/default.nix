# Arrakis --- my laptop

{ pkgs, ... }:
{
  imports = [
    ../personal.nix   # common settings
    ./hardware-configuration.nix
  ];

  modules = {
    desktop = {
      bspwm.enable = true;

      apps.rofi.enable = true;
      # apps.discord.enable = true;
      # apps.vm.enable = true;

      term.default = "xst";
      term.st.enable = true;

      browsers.default = "firefox";
      browsers.firefox.enable = true;
    };

    editors = {
      default = "nvim";
      emacs.enable = true;
      vim.enable = true;
    };

    dev = {
      # cc.enable = true;
      # common-lisp.enable = true;
      # rust.enable = true;
      # lua.enable = true;
      # lua.love2d.enable = true;
    };

    media = {
      # mpv.enable = true;
      # spotify.enable = true;
    };

    shell = {
      git.enable = true;
      zsh.enable = true;
    };

    # themes.aquanaut.enable = true;
    themes.fluorescence.enable = true;
  };

  programs.ssh.startAgent = true;

  time.timeZone = "America/New_York";

  # Optimize power use
  environment.systemPackages = [ pkgs.acpi ];
  powerManagement.powertop.enable = true;
  # Monitor backlight control
  hardware.acpilight.enable = true;
}
