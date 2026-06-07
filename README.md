# EXPJRNE - A Tools/400 Utility

EXPJRNE is a utility for exporting journal entries from a journal to
an output file. The utility creates the output file with the meta
data fields of the journal entry and the original fields of the
journaled file. That makes it is easy to analyze the exported data.

## Dependencies

Dependencies:

- [BASICS1](https://github.com/tools400/basics1)
- [RTVFLDA](https://github.com/tools400/rtvflda)

## Installation

Compile members with the following PDM option:

   STRPREPRC USESRCFILE(&L/&F) USESRCMBR(&N) OPTION(*EVENTF) CHGOBJD(*NO)
     LIB(&O) OBJ(&N) SRCLIB(&L) SRCFILE(&F) SRCMBR(&N) USER0(&X)
     USER1(*LIST) USER2(*FULL)

Members of type MAKPGM or BND are used for linking programs (MAKPGM)
and service programs (BND).

## Using A_INSTALL

Follow these steps to compile the EXPJRNE utility:

Compile A_INSTALL with command:
  CRTBNDCL  PGM(QTEMP/A_INSTALL) SRCFILE(library_name/source_file_name)

Call A_INSTALL with the following command:
  CALL   PGM(QTEMP/A_INSTALL) PARM('*CURRENT' '&SF' '&LI' 'ENG')

Use 'ENG' for English and 'GER' for German.

## Using XMLPREVIEW Utility

You can also use the [XMLPREVIEW](https://www.jcrcmds.com/jcrdown2.html#XMLPREVIEW_tag)
utility for installing EXPJRNE. Follow these steps for installing
EXPJRNE with XMLPREVIEW:

XMLPREVIEW UPLOADMBR(BASICS1) UPLOADSRCF(library_name/file_name)

Q: Create sample programs:
A: no
Q: C-Compiler available?:
A: depending on your system "c_yes" or "c_no". Try "c_yes" first.

XMLPREVIEW UPLOADMBR(RTVFLDA) UPLOADSRCF(library_name/file_name)

Q: Create sample programs:
A: no

XMLPREVIEW UPLOADMBR(EXPJRNE) UPLOADSRCF(library_name/file_name)

Q: Select language (GER, ENG):
A: eng (English) or ger (German)

Usually file_name is QXML.

---

2018, Thomas Raddatz
