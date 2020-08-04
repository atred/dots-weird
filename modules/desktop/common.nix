{ config, lib, pkgs, ... }:
{
  my.packages = with pkgs; [
    xfce.thunar
    xfce.tumbler # for thumbnails
    evince    # pdf reader
    feh       # image viewer
    mpv       # video player
    zathura   # vi-like pdf reader
    xclip
    xdotool
    scrot
    wmname
    xorg.xbacklight
    unclutter
    pavucontrol
  ];

  ## Misc config files without another home
  my.home.xdg.configFile = {
    "user-dirs.dirs".source = <config/user-dirs.dirs>;
  };

  ## Sound
  sound.enable = true;
  hardware.pulseaudio.enable = true;
  networking.networkmanager.enable = true;

  ## Fonts
  fonts = {
    enableFontDir = true;
    enableGhostscriptFonts = true;
    fonts = with pkgs; [
      dejavu_fonts
      fira-code
      fira-code-symbols
      symbola
      noto-fonts
      noto-fonts-cjk
      font-awesome-ttf
    ];
    fontconfig.defaultFonts = {
      sansSerif = ["DejaVu Sans"];
      monospace = ["Fira Code"];
    };
  };

  ## Apps/Services
  services.xserver = {
    displayManager.lightdm.greeters.mini.user = config.my.username;
    layout = "us";
    xkbOptions = "caps:escape";
  };

  services.picom = {
    backend = "glx";
    vSync = false; # TODO change this on desktop
    opacityRules = [
      # "100:class_g = 'Firefox'"
      # "100:class_g = 'Vivaldi-stable'"
      "100:class_g = 'VirtualBox Machine'"
      # Art/image programs where we need fidelity
      "100:class_g = 'feh'"
      "100:class_g = 'mpv'"
      "100:class_g = 'Rofi'"
      "100:class_g = 'Peek'"
      # "99:_NET_WM_STATE@:32a = '_NET_WM_STATE_FULLSCREEN'"
    ];
    shadowExclude = [
      # Put shadows on notifications, the scratch popup and rofi only
      "! name~='(rofi|scratch|Dunst)$'"
    ];
    settings.blur-background-exclude = [
      "window_type = 'dock'"
      "window_type = 'desktop'"
      "class_g = 'Rofi'"
      "_GTK_FRAME_EXTENTS@:c"
    ];
  };

  # Try really hard to get QT to respect my GTK theme.
  # my.env.GTK_DATA_PREFIX = [ "${config.system.path}" ];
  # my.env.QT_QPA_PLATFORMTHEME = "gtk2";
  qt5 = { style = "gtk2"; platformTheme = "gtk2"; };
  services.xserver.displayManager.sessionCommands = ''
    export GTK2_RC_FILES="$XDG_CONFIG_HOME/gtk-2.0/gtkrc"
    source "$XDG_CONFIG_HOME"/xsession/*.sh
    xrdb -merge "$XDG_CONFIG_HOME"/xtheme/*
  '';
}
