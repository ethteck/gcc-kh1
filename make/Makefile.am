# -*-Makefile-*-, or close enough

AUTOMAKE_OPTIONS = 1.3

# CYGNUS LOCAL: build as make-new, install as make, use noinst_PROGRAMS
# instead of bin_PROGRAMS
noinst_PROGRAMS = make-new

# CYGNUS LOCAL: make_new_, not make_
make_new_SOURCES =	main.c commands.c job.c dir.c file.c misc.c read.c remake.c \
		rule.c implicit.c default.c variable.c expand.c function.c \
		vpath.c version.c ar.c arscan.c remote-$(REMOTE).c \
		commands.h dep.h filedef.h job.h make.h rule.h variable.h \
		signame.c signame.h \
		getopt.c getopt1.c getopt.h

# CYGNUS LOCAL: make_new_, not make_
make_new_LDADD =	@LIBOBJS@ @ALLOCA@ glob/libglob.a

info_TEXINFOS =	make.texinfo
man_MANS =	make.1

INCLUDES =	-I$(srcdir)/glob -DLIBDIR=\"$(libdir)\" -DINCLUDEDIR=\"$(includedir)\"

BUILT_SOURCES =	README build.sh.in

EXTRA_DIST = 	$(BUILT_SOURCES) $(man_MANS) README.customs remote-cstms.c\
		make-stds.texi texinfo.tex SCOPTIONS SMakefile\
		README.Amiga Makefile.ami config.ami make.lnk amiga.c amiga.h\
		README.DOS Makefile.DOS configure.bat dosbuild.bat configh.dos\
		README.W32 NMakefile config.h.W32 build_w32.bat subproc.bat\
		readme.vms makefile.vms makefile.com config.h-vms vmsdir.h\
		vmsfunctions.c vmsify.c

SUBDIRS =	glob

MOSTLYCLEANFILES = loadavg.c
CLEANFILES =	loadavg

# --------------- Local INSTALL Section

# If necessary, change the gid of the app and turn on the setgid flag.
#

# Whether or not make needs to be installed setgid.
# The value should be either `true' or `false'.
# On many systems, the getloadavg function (used to implement the `-l'
# switch) will not work unless make is installed setgid kmem.
#
inst_setgid = @NEED_SETGID@

# Install make setgid to this group so it can get the load average.
#
inst_group = @KMEM_GROUP@

# CYGNUS LOCAL: since we're building as make-new, need to add install
# rules here, including mkinstalldirs and installing make-new as make
install-exec-local:
	$(mkinstalldirs) $(DESTDIR)$(bindir)
	$(INSTALL_PROGRAM) make-new$(EXEEXT) $(DESTDIR)$(bindir)/make$(EXEEXT)
	@if $(inst_setgid); then \
	   app=$(DESTDIR)$(bindir)/make$(EXEEXT); \
	   if chgrp $(inst_group) $$app && chmod g+s $$app; then \
	     echo "chgrp $(inst_group) $$app && chmod g+s $$app"; \
	   else \
	     echo "$$app needs to be owned by group $(inst_group) and setgid;"; \
	     echo "otherwise the \`-l' option will probably not work."; \
	     echo "You may need special privileges to complete the installation"; \
	     echo "of $$app."; \
	   fi; \
	 else true; fi

# --------------- Local DIST Section

# Install the w32 subdirectory
#
dist-hook:
	(cd $(srcdir); \
	 w32=`find w32 -follow \( -name CVS -prune \) -o \( -name \*.orig -o -name \*.rej -o -name \*~ -prune \) -o -type f -print`; \
	 tar chf - $$w32) \
	| (cd $(distdir); tar xfBp -)


# --------------- Local CHECK Section

check-local: check-loadavg check-regression
.PHONY: check-loadavg check-regression

# > check-loadavg
#
loadavg: loadavg.c config.h
	@rm -f loadavg
	$(LINK) -I. -I$(srcdir) -DHAVE_CONFIG_H -DTEST $(make_LDFLAGS) loadavg.c $(LIBS)

# We copy getloadavg.c into a different file rather than compiling it
# directly because some compilers clobber getloadavg.o in the process.
#
loadavg.c: getloadavg.c
	ln $(srcdir)/getloadavg.c loadavg.c || \
	  cp $(srcdir)/getloadavg.c loadavg.c

check-loadavg: loadavg
	@echo The system uptime program believes the load average to be:
	-uptime
	@echo The GNU load average checking code believes:
	-./loadavg

# > check-regression
#
# Look for the make test suite, and run it if found.  Look in MAKE_TEST if
# specified, or else in the srcdir or the distdir, their parents, and _their_
# parents.
#
MAKETESTFLAGS =

check-regression: all
	@here=`pwd`; testdir=""; \
	  case "$(MAKE_TEST)" in "") \
	    for d1 in $$here $(srcdir); do \
	      for d2 in ../.. .. .; do \
		all=`echo $$d1/$$d2/make-test-[0-9]*/run_make_tests`; \
		case "$$all" in \
		  "$$d1/$$d2/make-test-[0-9]*/run_make_tests") : ;; \
		  *) try=`for x in $$all; do echo $$x; done | sort | tail -1`;\
		     testdir=`dirname $$try` ;; esac; \
            done; done ;; \
	    *) testdir="$(MAKE_TEST)" ;; \
	  esac; \
	  case "$$testdir" in \
	    "") echo "Couldn't find make-test-* regression test suite."; exit 0;; \
	  esac; \
	  echo "cd $$testdir && ./run_make_tests -make $$here/make $(MAKETESTFLAGS)"; \
	  cd $$testdir && ./run_make_tests -make $$here/make $(MAKETESTFLAGS)


# --------------- Maintainer's Section

# CYGNUS LOCAL: don't automatically enable maintainer mode
# if MAINT_MAKEFILE
# Note this requires GNU make.  Not to worry, since it will only be included
# in the Makefile if we're in the maintainer's environment.
# include $(srcdir)/maintMakefile
# endif
