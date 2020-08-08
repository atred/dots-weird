[![Made with Doom Emacs](https://img.shields.io/badge/Made_with-Doom_Emacs-blueviolet.svg?style=flat-square&logo=GNU%20Emacs&logoColor=white)](https://github.com/hlissner/doom-emacs)
[![NixOS 20.03](https://img.shields.io/badge/NixOS-v20.03-blue.svg?style=flat-square&logo=NixOS&logoColor=white)](https://nixos.org)

# My dotfiles

+ **Operating System:** NixOS
+ **Shell:** oh-my-zsh
+ **DM:** lightdm + lightdm-mini-greeter
+ **WM:** bspwm + polybar
+ **Editor:** Doom Emacs (and occasionally neovim)
+ **Terminal:** st
+ **Launcher:** rofi
+ **Browser:** firefox
+ **GTK Theme:** [Ant Dracula](https://github.com/EliverLara/Ant-Dracula)
+ **Icon Theme:** [Paper Mono Dark](https://github.com/snwh/paper-icon-theme)

*Works on my machine* ¯\\\_(ツ)_/¯

## Quick start
You may want to disable screen off, sleep, and screen lock on the installer. It's gonna take awhile.
```
# Assumes your partitions are set up and the target root is mounted to /mnt:
sudo su
nix-env -iA nixos.git nixos.gnumake
git clone https://github.com/atred/dots /mnt/etc/nixos
export PREFIX="/mnt"
make -C /mnt/etc/nixos install
```

### Management

+ `make` = `nixos-rebuild test`
+ `make switch` = `nixos-rebuild switch`
+ `make upgrade` = `nix-channel --update && nixos-rebuild switch`
+ `make install` = `nixos-generate-config --root $PREFIX && nixos-install --root $PREFIX`
+ `make gc` = `nix-collect-garbage -d` (use sudo to clear system profile)

### Partitioning

Here is what I run for 20.03 on my T480 (assuming/dev/sda1 is boot, /dev/sda2 is swap, and /dev/sda3 is root)
```
sudo su
cfdisk
mkfs.fat -F 32 -n boot /dev/sda1
mkswap -L swap /dev/sda2
mkfs.ext4 -L nixos /dev/sda3

mount /dev/sda3 /mnt
mkdir -p /mnt/boot
mount /dev/sda1 /mnt/boot
swapon /dev/sda2
```

#### Note for QMK
To install qmk (once you've booted into your new system),
1. Clone your fork. `~/dev/qmk` is where I like to put it.
2. In the cloned directory, run `nix-shell` and wait for it to build everything it needs.
3. Run `make git-submodule` to pull the rest of the prereqs.
4. Run `sudo make planck/rev6:atred` to test config and `make planck/rev6:atred:flash` to flash.
