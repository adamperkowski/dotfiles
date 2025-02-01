# st - simple terminal
# See LICENSE file for copyright and license details.
.POSIX:

include config.mk

SRC = st.c x.c hb.c
OBJ = $(SRC:.c=.o)

all: st

.c.o:
	$(CC) $(STCFLAGS) -c $<

st.o: st.h win.h
x.o: arg.h st.h win.h hb.h
hb.o: st.h

$(OBJ): config.mk

st: $(OBJ)
	$(CC) -o $@ $(OBJ) $(STLDFLAGS)

clean:
	rm -f st $(OBJ) st-$(VERSION).tar.gz

install: st
	install -Dm755 st -t $(DESTDIR)$(PREFIX)/bin
	sed "s/VERSION/$(VERSION)/g" < st.1 > st.1.install
	install -Dm644 st.1.install $(DESTDIR)$(MANPREFIX)/man1/st.1
	rm -f st.1.install
	tic -sx st.info

.PHONY: all clean install
