#
# The build process allows for using a cross-compiler.  But the default
# action is to target the same platform that we are running on.  The
# configure script needs to discover the following properties of the 
# build and target systems:
#
#    srcdir
#
#        The is the name of the directory that contains the
#        "configure" shell script.  All source files are
#        located relative to this directory.
#
#    bindir
#
#        The name of the directory where executables should be
#        written by the "install" target of the makefile.
#
#    program_prefix
#
#        Add this prefix to the names of all executables that run
#        on the target machine.  Default: ""
#
#    TARGET_EXEEXT
#
#        The filename extension for executables on the
#        target platform.  "" for Unix and ".exe" for windows.
#
# This configure.in file is easy to reuse on other projects.  Just
# change the argument to AC_INIT().  And disable any features that
# you don't need (for example BLT) by erasing or commenting out
# the corresponding code.
#
AC_INIT(citrus, m4_esyscmd([cat VERSION | tr -d '\n']))

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
AC_PROG_LIBTOOL
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

###########
# Lots of things are different if we are compiling for Windows using
# the CYGWIN environment.  So check for that special case and handle
# things accordingly.
#
AC_MSG_CHECKING([if executables have the .exe suffix])
if test "$config_BUILD_EXEEXT" = ".exe"; then
  CYGWIN=yes
  AC_MSG_RESULT(yes)
else
  AC_MSG_RESULT(unknown)
fi
if test "$CYGWIN" != "yes"; then
  AC_CYGWIN
fi
if test x"$cross_compiling" = xno; then
  TARGET_EXEEXT=$BUILD_EXEEXT
else
  TARGET_EXEEXT=$config_TARGET_EXEEXT
fi

AC_SUBST(BUILD_EXEEXT)
AC_SUBST(TARGET_EXEEXT)

#########
# check for debug enabled
AC_ARG_ENABLE(debug, AC_HELP_STRING([--enable-debug],[enable debugging]),
      [use_debug=$enableval],[use_debug=no])
if test "${use_debug}" = "yes" ; then
  TARGET_DEBUG="-DCITRUS_DEBUG=1"
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
AC_OUTPUT([
Makefile
citrus.pc
])
