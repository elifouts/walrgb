PREFIX ?= /usr/local
BINDIR ?= $(PREFIX)/bin
UNITDIR ?= $(PREFIX)/lib/systemd/user
UNITS = walrgb-openrgb.service

install: install-bin install-units

# split so install.sh can sudo the binary into /usr/local and keep the unit in your home
install-bin:
	install -Dm755 walrgb $(DESTDIR)$(BINDIR)/walrgb

install-units:
	install -dm755 $(DESTDIR)$(UNITDIR)
	for u in $(UNITS); do sed 's|@BINDIR@|$(BINDIR)|' systemd/$$u > $(DESTDIR)$(UNITDIR)/$$u; done

uninstall-bin:
	rm -f $(DESTDIR)$(BINDIR)/walrgb

uninstall-units:
	rm -f $(addprefix $(DESTDIR)$(UNITDIR)/,$(UNITS))

uninstall: uninstall-bin uninstall-units

enable:
	systemctl --user daemon-reload
	systemctl --user enable --now $(UNITS)

disable:
	-systemctl --user disable --now $(UNITS)
	-systemctl --user daemon-reload

.PHONY: install install-bin install-units uninstall uninstall-bin uninstall-units enable disable
