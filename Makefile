INST_PREFIX = /usr/local
INST_LIBDIR = $(INST_PREFIX)/lib/lua/5.1

all: luaphonenumber

clean:
	rm -f luaphonenumber.so* luaphonenumber.o

luaphonenumber:
	g++ -std=c++11 -Wall -fPIC -c luaphonenumber.cpp
	g++ -shared -Wl,-soname,luaphonenumber.so.1 -o luaphonenumber.so.1.0 luaphonenumber.o -lphonenumber -lgeocoding
	ln -sf luaphonenumber.so.1.0 luaphonenumber.so
	ln -sf luaphonenumber.so.1.0 luaphonenumber.so.1

install:
	cp luaphonenumber.so* $(INST_LIBDIR)
