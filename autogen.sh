#!/bin/bash

AUTORECONF=${AUTORECONF:-$( which autoreconf )}

${AUTORECONF} --install -Wall --verbose --force

