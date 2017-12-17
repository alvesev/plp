DIR_ORIGIN = ../src
DIR_BASE_INSTALL = /opt/plp

all: install

install:
	PS4="CMD:\${0}:pid=\${$}: "
	set -x
	test -d $(DESTDIR)/usr/bin/ || install --directory --owner=root --group=root --mode=755 --verbose   $(DESTDIR)/usr/bin/
	test -d $(DESTDIR)/opt/plp/ || install --directory --owner=root --group=root --mode=755 --verbose   $(DESTDIR)/opt/plp/
	install --owner=root --group=root --mode=755 --verbose $(DIR_ORIGIN)/plp $(DESTDIR)/usr/bin/plp
	install --owner=root --group=root --mode=755 --verbose $(DIR_ORIGIN)/plp-list $(DESTDIR)/usr/bin/plp-list
	install --owner=root --group=root --mode=755 --verbose $(DIR_ORIGIN)/plp-list-to-yaml $(DESTDIR)/usr/bin/plp-list-to-yaml
	install --owner=root --group=root --mode=755 --verbose $(DIR_ORIGIN)/journal.py $(DESTDIR)/opt/plp/journal.py

clean:
	echo "INFO:${0}:pid=${$}: Nothing to be done for cleanup after this DEB package build."
