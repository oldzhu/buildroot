#!/bin/bash
#$1 path to glibc folder

makerules=$1/Makerules

sed -i '/define build-shlib-helper/{n;s/\$(LINK.o) -sh/\$(LINK.o) -Wl,--build-id=sha1 -sh/}' $makerules

