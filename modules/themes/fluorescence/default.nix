# themes/fluorescence/default.nix --- a regal dracula-inspired theme

{ config, options, lib, pkgs, ... }:
with lib;
let cfg = config.modules; in
{
  options.modules.themes.fluorescence = {
    enable = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkIf cfg.themes.fluorescence.enable {
    modules.theme = {
      name = "fluorescence";
      version = "0.0.1";
      path = ./.;

      wallpaper = {
        filter.options = "-gaussian-blur 0x2 -modulate 70 -level 5%";
      };
    };

    services.picom = {
      fade = true;
      fadeDelta = 1;
      fadeSteps = [ "0.01" "0.012" ];
      shadow = true;
      shadowOffsets = [ (-10) (-10) ];
      shadowOpacity = "0.22";
      # activeOpacity = "1.00";
      # inactiveOpacity = "0.92";
      settings = {
        shadow-radius = 12;
        # blur-background = true;
        # blur-background-frame = true;
        # blur-background-fixed = true;
        blur-kern = "7x7box";
        blur-strength = 320;
      };
    };

    services.xserver.displayManager.lightdm = {
      greeters.mini.extraConfig = ''
        text-color = "#ff79c6"
        password-background-color = "#1E2029"
        window-color = "#181a23"
        border-color = "#181a23"
      '';
    };

    fonts.fonts = [ pkgs.nerdfonts ];
    my.packages = with pkgs; [
      my.ant-dracula
      paper-icon-theme # for rofi
    ];

    my.home = {
      # home.file = mkMerge [
      #   (mkIf cfg.desktop.browsers.firefox.enable {
      #     ".mozilla/firefox/${cfg.desktop.browsers.firefox.profileName}.default/chrome/userChrome.css" = {
      #       source = ./firefox/userChrome.css;
      #     };
      #   })
      # ];

      home.file.".icons/default/index.theme".text = ''
        [icon theme]
        Inherits=Paper
      '';

      xdg.configFile = mkMerge [
        (mkIf config.services.xserver.enable {
          "xtheme/90-theme".source    = ./Xresources;
          # GTK
          "gtk-3.0/settings.ini".text = ''
            [Settings]
            gtk-theme-name=Ant-Dracula
            gtk-icon-theme-name=Paper
            gtk-fallback-icon-theme=gnome
            gtk-application-prefer-dark-theme=true
            gtk-cursor-theme-name=Paper
            gtk-xft-hinting=1
            gtk-xft-hintstyle=hintfull
            gtk-xft-rgba=none
          '';
          # GTK2 global theme (widget and icon theme)
          "gtk-2.0/gtkrc".text = ''
            gtk-theme-name="Ant-Dracula"
            gtk-icon-theme-name="Paper-Mono-Dark"
            gtk-font-name="Sans 10"
          '';
          # QT4/5 global theme
          "Trolltech.conf".text = ''
            [Qt]
            style=Ant-Dracula
          '';
        })
        (mkIf cfg.desktop.bspwm.enable {
          "bspwm/rc.d/polybar".source = ./polybar/run.sh;
          "bspwm/rc.d/theme".source   = ./bspwmrc;
        })
        (mkIf cfg.desktop.apps.rofi.enable {
          "rofi/theme" = { source = ./rofi; recursive = true; };
        })
        (mkIf (cfg.desktop.bspwm.enable) {
          "polybar" = { source = ./polybar; recursive = true; };
          "dunst/dunstrc".source = ./dunstrc;
        })
      ];

    };
  };
}
