## Process this file with automake to generate Makefile.in

AUTOMAKE_OPTIONS = cygnus

SUBDIRS = $(machine_dir)

if HAVE_MACHINE_DIR
MACHLIB = lib.a
endif

noinst_LIBRARIES = $(MACHLIB)

lib.a: $(machine_dir)/lib.a
	rm -f $@
	ln $(machine_dir)/lib.a $@ >/dev/null 2>/dev/null || \
	 cp $(machine_dir)/lib.a $@

$(machine_dir)/lib.a: all-recursive

doc:

ACLOCAL_AMFLAGS = -I ../..
CONFIG_STATUS_DEPENDENCIES = $(newlib_basedir)/configure.host
