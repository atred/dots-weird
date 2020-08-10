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
	@echo "Set the user password!"
	@sudo nixos-enter -c "passwd $(USER)"
	@sudo nixos-enter -c "chown $(USER):users -R /home/$(USER) /etc/nixos"

upgrade: update switch

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

channels:
	@sudo nix-channel --add "https://nixos.org/channels/nixos-${NIXOS_VERSION}" nixos
	@sudo nix-channel --add "https://github.com/rycee/home-manager/archive/release-${NIXOS_VERSION}.tar.gz" home-manager

$(NIXOS_PREFIX)/configuration.nix:
	# @sudo nixos-generate-config --root "$(PREFIX)"
	@[ -f hosts/$(HOST)/default.nix ] || echo "WARNING: hosts/$(HOST)/default.nix does not exist"

$(HOME)/dots:
	@sudo mkdir -p $(HOME)/{doc/pres,dl,mus,pic/vid,.local/{temp,share},dev/src}
	@[ -e $(HOME)/dots ] || sudo ln -s /etc/nixos $(HOME)/dots
	# @[ -e $(PREFIX)/etc/dots ] || sudo ln -s $(HOME)/dots $(PREFIX)/etc/dots

# Convenience aliases
i: install
s: switch
up: upgrade


.PHONY: config
