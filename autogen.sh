#!/bin/bash

LIBTOOLIZE=${LIBTOOLIZE:-$( which libtoolize )}
if [ -z $LIBTOOLIZE ]; then
	LIBTOOLIZE=$( which glibtoolize )
fi
AUTORECONF=${AUTORECONF:-$( which autoreconf )}

${LIBTOOLIZE} --copy --install
${AUTORECONF}

