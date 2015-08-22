#!/bin/bash -e

cd postgresql
cd src

CPPFLAGS="-O2 -Wall -Wmissing-prototypes -Wpointer-arith -Wdeclaration-after-statement -Wendif-labels -Wmissing-format-attribute -Wformat-security -fno-strict-aliasing -fwrapv"

LIBFLAGS="-lm"
if [ `uname` != "Darwin" ]; then
	LIBFLAGS+=" -lrt -ldl"
fi

OBJFILES=`find backend -name '*.o' | egrep -v '(main/main\.o|snowball|libpqwalreceiver|conversion_procs)' | xargs echo`
OBJFILES+=" timezone/localtime.o timezone/strftime.o timezone/pgtz.o"

gcc -c -fPIC $CPPFLAGS -I include ../../queryparser.c -o ../../queryparser.o

ar rcs ../../libqueryparser.a $OBJFILES ../../queryparser.o
