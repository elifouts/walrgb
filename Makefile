PREFIX ?= /usr/local
BINDIR ?= $(PREFIX)/bin
UNITDIR ?= $(PREFIX)/lib/systemd/user
DOCDIR ?= $(PREFIX)/share/doc/walrgb
UNITS = walrgb.path walrgb.service walrgb-openrgb.service

install:
	install -Dm755 walrgb $(DESTDIR)$(BINDIR)/walrgb
	install -dm755 $(DESTDIR)$(UNITDIR)
	for u in $(UNITS); do sed 's|@BINDIR@|$(BINDIR)|' systemd/$$u > $(DESTDIR)$(UNITDIR)/$$u; done
	install -Dm644 README.md $(DESTDIR)$(DOCDIR)/README.md

uninstall:
	rm -f $(DESTDIR)$(BINDIR)/walrgb $(addprefix $(DESTDIR)$(UNITDIR)/,$(UNITS))
	rm -rf $(DESTDIR)$(DOCDIR)

enable:
	systemctl --user daemon-reload
	systemctl --user enable --now walrgb.path

disable:
	-systemctl --user disable --now $(UNITS)
	-systemctl --user daemon-reload

.PHONY: install uninstall enable disable
