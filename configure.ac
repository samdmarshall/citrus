#########
# Init
#
AC_INIT([citrus],m4_esyscmd(cat VERSION | tr -d '\n'))
AM_INIT_AUTOMAKE([foreign])

dnl Make sure the local VERSION file matches this configure script
citrus_version_sanity_check=`cat $srcdir/VERSION | tr -d '\n'`
if test "$PACKAGE_VERSION" != "$citrus_version_sanity_check" ; then
AC_MSG_ERROR([configure script is out of date:
 configure \$PACKAGE_VERSION = $PACKAGE_VERSION
 top level VERSION file     = $citrus_version_sanity_check
please regen with autoconf])
fi

#########
# Programs needed
#
AC_PROG_INSTALL
AC_PROG_AWK

#########
# Enable large file support (if special flags are necessary)
#
AC_SYS_LARGEFILE

#########
# Check for needed/wanted data types
AC_CHECK_TYPES([int8_t, int16_t, int32_t, int64_t, intptr_t, uint8_t,
                uint16_t, uint32_t, uint64_t, uintptr_t])

#########
# Check for needed/wanted headers
AC_CHECK_HEADERS([sys/types.h stdlib.h stdint.h inttypes.h malloc.h])

#########
# Set up an appropriate program prefix
#
if test "$program_prefix" = "NONE"; then
  program_prefix=""
fi
AC_SUBST(program_prefix)

VERSION=[`cat $srcdir/VERSION | sed 's/^\([0-9]*\.*[0-9]*\).*/\1/'`]
AC_MSG_NOTICE(Version set to $VERSION)
AC_SUBST(VERSION)
RELEASE=`cat $srcdir/VERSION`
AC_MSG_NOTICE(Release set to $RELEASE)
AC_SUBST(RELEASE)
VERSION_NUMBER=[`cat $srcdir/VERSION \
                           | sed 's/[^0-9]/ /g' \
                | awk '{printf "%d%03d%03d",$1,$2,$3}'`]
AC_MSG_NOTICE(Version number set to $VERSION_NUMBER)
AC_SUBST(VERSION_NUMBER)

#########
# check for debug enabled
AC_ARG_ENABLE(debug, AS_HELP_STRING([--enable-debug],[enable debugging]),
      [use_debug=$enableval],[use_debug=no])
if test "${use_debug}" = "yes" ; then
  TARGET_DEBUG="-DDEBUG=1"
else
  TARGET_DEBUG="-DNDEBUG"
fi
AC_SUBST(TARGET_DEBUG)

#########
# Output the config header
AC_CONFIG_HEADERS(config.h)

#########
# Generate the output files.
#
AC_SUBST(BUILD_CFLAGS)
AC_CONFIG_FILES([
Makefile
citrus.pc
version.h
])
AC_OUTPUT
