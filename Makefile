<<<<<<< HEAD
CXXFLAGS=-g -O2 -Wall -Wextra -Isrc -DNDEBUG -mno-ms-bitfields $(OPTFLAGS)
=======
CFLAGS=-g -O2 -Wall -Wextra -Isrc -DNDEBUG $(OPTFLAGS)
>>>>>>> parent of b6ed127... Resolving some issues with struct packing on Centos
LIBS=$(OPTLIBS)
PREFIX?=/usr/local
CC=g++

SOURCES=$(wildcard src/**/*.cpp src/*.cpp)
OBJECTS=$(patsubst %.cpp,%.o,$(SOURCES))

TEST_SRC=$(wildcard tests/*_tests.cpp)
TESTS=$(patsubst %.cpp,%,$(TEST_SRC))

TARGET=build/ccmix
SO_TARGET=$(patsubst %.a,%.so,$(TARGET))

# The Target Build
all: $(TARGET)

<<<<<<< HEAD
dev: CXXFLAGS=-g -Wall -Isrc -Wall -Wexta -mno-ms-bitfields $(OPTFLAGS)
=======
dev: CFLAGS=-g -Wall -Isrc -Wall -Wexta $(OPTFLAGS)
>>>>>>> parent of b6ed127... Resolving some issues with struct packing on Centos
dev: all

win32:
	/usr/bin/make -f Makefile.win32 CC=i586-mingw32msvc-g++ \
	CXX=i586-mingw32msvc-g++

	
$(TARGET): build $(OBJECTS)
	$(CC) $(OBJECTS) -o $(TARGET) -mno-ms-bitfields

build:
	@mkdir -p build
	@mkdir -p bin

# The Cleaner
clean:
	rm -rf build $(OBJECTS) $(TESTS)
	rm -f tests/tests.log
	find . -name "*.gc*" -exec rm {} \;
	rm -rf `find . -name "*.dSYM" -print`

# The Install
install: all
	install -d $(DESTDIR)/$(PREFIX)/lib/
	install $(TARGET) $(DESTDIR)/$(PREFIX)/lib/

# The Checker
BADFUNCS='[^_.>a-zA-Z0-9](str(n?cpy|n?cat|xfrm|n?dup|str|pbrk|tok|_)|stpn?cpy|a?sn?printf|byte_)'
check:
	@echo Files with potentially dangerous functions.
	@egrep $(BADFUNCS) $(SOURCES) || true
