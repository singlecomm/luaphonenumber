LUA_VERSION = 5.1
INST_PREFIX = /usr/local
INST_LIBDIR = $(INST_PREFIX)/lib/lua/$(LUA_VERSION)

CXX = g++
CXXFLAGS = -std=c++11 -Wall -fPIC

all: luaphonenumber

clean:
	rm -f luaphonenumber.so* luaphonenumber.o

luaphonenumber:
	$(CXX) $(CXXFLAGS) -c luaphonenumber.cpp
	$(CXX) $(LDFLAGS) -shared -Wl,-soname,luaphonenumber.so.1 -o luaphonenumber.so.1.0 luaphonenumber.o -lphonenumber -lgeocoding
	ln -sf luaphonenumber.so.1.0 luaphonenumber.so
	ln -sf luaphonenumber.so.1.0 luaphonenumber.so.1

install:
	cp luaphonenumber.so* $(INST_LIBDIR)
