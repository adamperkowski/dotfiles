# dwm - dynamic window manager
# See LICENSE file for copyright and license details.

include config.mk

SRC = drw.c dwm.c util.c
OBJ = ${SRC:.c=.o}

all: dwm

.c.o:
	${CC} -c ${CFLAGS} $<

${OBJ}: config.mk

dwm: ${OBJ}
	${CC} -o $@ ${OBJ} ${LDFLAGS}

clean:
	rm -f dwm ${OBJ} dwm-${VERSION}.tar.gz

install: all
	install -Dm755 dwm -t ${DESTDIR}${PREFIX}/bin
	sed "s/VERSION/${VERSION}/g" < dwm.1 > dwm.1.install
	install -Dm644 dwm.1.install -t ${DESTDIR}${MANPREFIX}/man1
	rm -f dwm.1.install

.PHONY: all clean install
