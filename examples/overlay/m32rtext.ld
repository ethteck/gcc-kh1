OUTPUT_FORMAT("elf32-m32r", "elf32-m32r",
	      "elf32-m32r")
OUTPUT_ARCH(m32r)
ENTRY(_start)
 SEARCH_DIR(/usr/cygnus/m32r-961018/H-sparc-sun-sunos4.1//lib);
/* Do we need any of these for elf?
   __DYNAMIC = 0;    */
SECTIONS
{
    .ovly0 0x300000 : AT (0x400000)                  { foo.o(.text)  }
    .ovly1 0x300000 : AT (0x400000 + SIZEOF(.ovly0)) { bar.o(.text)  }
    .ovly2 0x380000 : AT (0x500000)                  { baz.o(.text)  }
    .ovly3 0x380000 : AT (0x500000 + SIZEOF(.ovly2)) { grbx.o(.text) }

  /* Read-only sections, merged into text segment: */
  . = 0x208000;
  .interp        : { *(.interp) 	}
  .hash          : { *(.hash)		}
  .dynsym        : { *(.dynsym)		}
  .dynstr        : { *(.dynstr)		}
  .rel.text      : { *(.rel.text)	}
  .rela.text     : { *(.rela.text) 	}
  .rel.data      : { *(.rel.data)	}
  .rela.data     : { *(.rela.data) 	}
  .rel.rodata    : { *(.rel.rodata) 	}
  .rela.rodata   : { *(.rela.rodata) 	}
  .rel.got       : { *(.rel.got)	}
  .rela.got      : { *(.rela.got)	}
  .rel.ctors     : { *(.rel.ctors)	}
  .rela.ctors    : { *(.rela.ctors)	}
  .rel.dtors     : { *(.rel.dtors)	}
  .rela.dtors    : { *(.rela.dtors)	}
  .rel.init      : { *(.rel.init)	}
  .rela.init     : { *(.rela.init)	}
  .rel.fini      : { *(.rel.fini)	}
  .rela.fini     : { *(.rela.fini)	}
  .rel.bss       : { *(.rel.bss)	}
  .rela.bss      : { *(.rela.bss)	}
  .rel.plt       : { *(.rel.plt)	}
  .rela.plt      : { *(.rela.plt)	}
  .init          : { *(.init)		} =0
  .plt           : { *(.plt)		}
  .text          :
  {
    *(.text)
    /* .gnu.warning sections are handled specially by elf32.em.  */
    *(.gnu.warning)
    *(.gnu.linkonce.t*)
  } =0
  _etext = .;
  PROVIDE (etext = .);
  .fini          : { *(.fini)		} =0
  .rodata        : { *(.rodata) *(.gnu.linkonce.r*) }
  .rodata1       : { *(.rodata1)	}
  /* Adjust the address for the data segment.  We want to adjust up to
     the same address within the page on the next page up.  */
  . = ALIGN(32) + (ALIGN(8) & (32 - 1));
  .data          :
  {
    *(.data)
    *(.gnu.linkonce.d*)
    _ovly_table = .; 
	LONG(ABSOLUTE(ADDR(.ovly0)));
	LONG(SIZEOF(.ovly0));
	LONG(LOADADDR(.ovly0));
	LONG(0);
	LONG(ABSOLUTE(ADDR(.ovly1)));
	LONG(SIZEOF(.ovly1));
	LONG(LOADADDR(.ovly1));
	LONG(0);
	LONG(ABSOLUTE(ADDR(.ovly2)));
	LONG(SIZEOF(.ovly2));
	LONG(LOADADDR(.ovly2));
	LONG(0);
	LONG(ABSOLUTE(ADDR(.ovly3)));
	LONG(SIZEOF(.ovly3));
	LONG(LOADADDR(.ovly3));
	LONG(0);
    _ovly_region_table = .;
	LONG(ABSOLUTE(ADDR(.ovly0)));
	LONG(SIZEOF(.ovly0));
	LONG(0);
	LONG(ABSOLUTE(ADDR(.ovly2)));
	LONG(SIZEOF(.ovly2));
	LONG(0);
    _novly_regions = .;
	LONG((_novly_regions - _ovly_region_table) / 12);
    _novlys = .;
	LONG((_ovly_region_table - _ovly_table) / 16);

    CONSTRUCTORS
  }
  .data1         : { *(.data1)		}
  .ctors         : { *(.ctors)		}
  .dtors         : { *(.dtors)		}
  .got           : { *(.got.plt) *(.got)}
  .dynamic       : { *(.dynamic)	}
  /* We want the small data sections together, so single-instruction offsets
     can access them all, and initialized data all before uninitialized, so
     we can shorten the on-disk segment size.  */
  .sdata         : { *(.sdata)		}
  _edata  =  .;
  PROVIDE (edata = .);
  __bss_start = .;
  .sbss          : { *(.sbss) *(.scommon) }
  .bss           : { *(.dynbss) *(.bss) *(COMMON) }
  _end = . ;
  PROVIDE (end = .);
  /* Stabs debugging sections.  */
  .stab 0        : { *(.stab)		}
  .stabstr 0     : { *(.stabstr)	}
  .stab.excl 0   : { *(.stab.excl)	}
  .stab.exclstr 0 : { *(.stab.exclstr)	}
  .stab.index 0  : { *(.stab.index)	}
  .stab.indexstr 0 : { *(.stab.indexstr) }
  .comment 0     : { *(.comment)	}
  /* DWARF debug sections.
     Symbols in the .debug DWARF section are relative to the beginning of the
     section so we begin .debug at 0.  It's not clear yet what needs to happen
     for the others.   */
  .debug          0 : { *(.debug) 	  }
  .debug_srcinfo  0 : { *(.debug_srcinfo) }
  .debug_aranges  0 : { *(.debug_aranges) }
  .debug_pubnames 0 : { *(.debug_pubnames) }
  .debug_sfnames  0 : { *(.debug_sfnames) }
  .line           0 : { *(.line)	  }
  .stack   0x5ffffc : { _stack = .; *(.stack) }
  /* These must appear regardless of  .  */
}
