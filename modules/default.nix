{ config, options, lib, ... }:
with lib;
let mkOptionStr = value: mkOption
  { type = types.str;
    default = value; };
in {
  imports = [
    <home-manager/nixos>

    ./desktop
    ./dev
    ./editors
    ./media
    ./shell
    ./themes
  ];

  options = {
    my = {
      ## Personal details
      username = mkOptionStr "andrew";
      email = mkOptionStr "atredinbo@gmail.com";

      ## Convenience aliases
      home = mkOption { type = options.home-manager.users.type.functor.wrapped; };
      user = mkOption { type = types.submodule; };
      packages = mkOption { type = with types; listOf package; };
    };
  };

  config = {
    ## Convenience aliases
    home-manager.users.${config.my.username} = mkAliasDefinitions options.my.home;
    users.users.${config.my.username} = mkAliasDefinitions options.my.user;
    my.user.packages = config.my.packages;

    ## PATH should always start with its old value
    # my.env.PATH = [ <bin> "$PATH" ];
    environment.extraInit =
      ''
        export XAUTHORITY=/tmp/Xauthority
        [ -e ~/.Xauthority ] && mv -f ~/.Xauthority "$XAUTHORITY"
      '';
  };
}
