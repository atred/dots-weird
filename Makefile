USER := andrew
HOST := arrakis
HOME := $(PREFIX)/home/$(USER)

NIXOS_VERSION := 20.03
NIXOS_PREFIX  := $(PREFIX)/etc/nixos
COMMAND       := test
FLAGS         := -I "config=$$(pwd)/config" \
				 -I "modules=$$(pwd)/modules" \
				 -I "bin=$$(pwd)/bin" \
				 $(FLAGS)

# Targets
all: channels
	@sudo nixos-rebuild $(FLAGS) $(COMMAND)

install: channels update config move_to_home
	@sudo nixos-install --no-root-passwd --root "$(PREFIX)" $(FLAGS)
	@sudo nixos-enter -c "sudo -u $(USER) git clone --depth 1 https://github.com/hlissner/doom-emacs $(HOME)/.emacs.d"
	@sudo nixos-enter -c "sudo -u $(USER) git clone https://github.com/atred/.doom.d $(HOME)/.doom.d"
	@sudo nixos-enter -c "sudo -u $(USER) $(HOME)/.emacs.d/bin/doom install"
	@echo "Set the user password!"
	@sudo nixos-enter -c "passwd $(USER)"
	@sudo nixos-enter -c "chown $(USER):users -R /home/$(USER) /etc/nixos"

upgrade: update switch doom

update: channels
	@sudo nix-channel --update

switch:
	@sudo nixos-rebuild $(FLAGS) switch

build:
	@sudo nixos-rebuild $(FLAGS) build

boot:
	@sudo nixos-rebuild $(FLAGS) boot

rollback:
	@sudo nixos-rebuild $(FLAGS) --rollback $(COMMAND)

dry:
	@sudo nixos-rebuild $(FLAGS) dry-build

gc:
	@sudo nix-collect-garbage -d

vm:
	@sudo nixos-rebuild $(FLAGS) build-vm

clean:
	@rm -f result


# Parts
config: $(NIXOS_PREFIX)/configuration.nix
move_to_home: $(HOME)/dots
doom: $(HOME)/.doom.d $(HOME)/.emacs.d
	@sudo -u $(USER) $(HOME)/.emacs.d/bin/doom upgrade

channels:
	@sudo nix-channel --add "https://nixos.org/channels/nixos-${NIXOS_VERSION}" nixos
	@sudo nix-channel --add "https://github.com/nix-community/home-manager/archive/release-${NIXOS_VERSION}.tar.gz" home-manager

$(NIXOS_PREFIX)/configuration.nix:
	# @sudo nixos-generate-config --root "$(PREFIX)"
	@[ -f hosts/$(HOST)/default.nix ] || echo "WARNING: hosts/$(HOST)/default.nix does not exist"

$(HOME)/dots:
	@sudo mkdir -p $(HOME)/{doc/pres,dl,mus,pic/vid,.local/{temp,share},dev/src}
	@[ -e $(HOME)/dots ] || sudo ln -s /etc/nixos $(HOME)/dots
	# @[ -e $(PREFIX)/etc/dots ] || sudo ln -s $(HOME)/dots $(PREFIX)/etc/dots

$(HOME)/.emacs.d:
	@git clone --depth 1 https://github.com/hlissner/doom-emacs $(HOME)/.emacs.d
	@chown -R $(USER):users $(HOME)/.emacs.d

$(HOME)/.doom.d:
	@git clone https://github.com/atred/.doom.d $(HOME)/.doom.d
	@chown -R $(USER):users $(HOME)/.doom.d

# Convenience aliases
i: install
s: switch
up: upgrade


.PHONY: config
