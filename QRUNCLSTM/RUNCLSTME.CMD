/* =================================================================== */
/*                                                                     */
/*  Kurzdokumentation :                                                */
/*                                                                     */
/*  Bereich . . . : RUNCLSTM                                           */
/*  Objekt  . . . : RUNCLSTME                                          */
/*  Beschreibung  : Tool: RUNCLSTM   (Run CL Statements         ) Eng  */
/*  Author  . . . : Thomas Raddatz   <thomas.raddatz@tools400.de>      */
/*  Datum . . . . : 03.08.2000                                         */
/*                                                                     */
/* =================================================================== */
/*                                                                     */
/*  This software is free software, you can redistribute it and/or     */
/*  modify it under the terms of the GNU General Public License (GPL)  */
/*  as published by the Free Software Foundation.                      */
/*                                                                     */
/*  See GNU General Public License for details.                        */
/*          http://www.opensource.org                                  */
/*          http://www.opensource.org/licenses/gpl-license.html        */
/*                                                                     */
/* =================================================================== */
/*  History:                                                           */
/*                                                                     */
/*  Datum       Name          Änderung                                 */
/*  ----------  ------------  ---------------------------------------  */
/*                                                                     */
/* =================================================================== */
/* >>PRE-COMPILER<<                                                    */
/*                                                                     */
/*   >>CRTCMD<< CRTCMD       CMD(&LI/&OB) +                            */
/*                           SRCFILE(&SL/&SF) +                        */
/*                           SRCMBR(&SM);                              */
/*                                                                     */
/*   >>COMPILE<<                                                       */
/*     >>PARM<< PGM(*LIBL/RUNCLSTM);                                   */
/*     >>PARM<< HLPPNLGRP(*LIBL/RUNCLSTMPE);                           */
/*     >>PARM<< HLPID(RUNCLSTM);                                       */
/*     >>PARM<< PRDLIB(&LI);                                           */
/*   >>END-COMPILE<<                                                   */
/*                                                                     */
/*   >>EXECUTE<<                                                       */
/*                                                                     */
/* >>END-PRE-COMPILER<<                                                */
/* =================================================================== */

             CMD        PROMPT('Run CL-Statements')

             PARM       KWD(USESRCFILE) TYPE(QUAL1)        +
                        MIN(1)                             +
                        PROMPT('Source file')

             PARM       KWD(USESRCMBR ) TYPE(*CHAR)        +
                          LEN(10)                          +
                          MIN(1)                           +
                          PROMPT('Source member')

             PARM       KWD(STRSEQ    ) TYPE(*DEC )        +
                          LEN(6 2)                         +
                          MIN(0)                           +
                          DFT(*FIRST)                      +
                          SPCVAL((*FIRST 0))               +
                          PROMPT('Start sequence number')

             PARM       KWD(ENDSEQ    ) TYPE(*DEC )        +
                          LEN(6 2)                         +
                          MIN(0)                           +
                          DFT(*LAST)                       +
                          SPCVAL((*LAST  9999,99))         +
                          PROMPT('End sequence number')

             PARM       KWD(LIB       ) TYPE(*CHAR)        +
                          LEN(10)                          +
                          MIN(0)                           +
                          DFT(*NONE)                       +
                          PMTCTL(*PMTRQS)                  +
                          PROMPT('Value for library        (&LI)')

             PARM       KWD(OBJ       ) TYPE(*CHAR)        +
                          LEN(10)                          +
                          MIN(0)                           +
                          DFT(*NONE)                       +
                          SPCVAL((*NONE))                  +
                          PMTCTL(*PMTRQS)                  +
                          PROMPT('Value for object         (&OB)')

             PARM       KWD(TYPECODE  ) TYPE(*CHAR)        +
                          LEN(6)                           +
                          MIN(0)                           +
                          DFT(*NONE)                       +
                          SPCVAL((*NONE))                  +
                          PMTCTL(*PMTRQS)                  +
                          PROMPT('Value for type cde       (&TY)')

             PARM       KWD(SRCLIB    ) TYPE(*CHAR)        +
                          LEN(10)                          +
                          MIN(0)                           +
                          DFT(*NONE)                       +
                          SPCVAL((*NONE))                  +
                          PMTCTL(*PMTRQS)                  +
                          PROMPT('Value for source library (&SL)')

             PARM       KWD(SRCFILE   ) TYPE(*CHAR)        +
                          LEN(10)                          +
                          MIN(0)                           +
                          DFT(*NONE)                       +
                          SPCVAL((*NONE))                  +
                          PMTCTL(*PMTRQS)                  +
                          PROMPT('Value for source file    (&SF)')

             PARM       KWD(SRCMBR    ) TYPE(*CHAR)        +
                          LEN(10)                          +
                          MIN(0)                           +
                          DFT(*NONE)                       +
                          SPCVAL((*NONE))                  +
                          PMTCTL(*PMTRQS)                  +
                          PROMPT('Value for source member  (&SM)')

             PARM       KWD(TESTLIB   ) TYPE(*CHAR)        +
                          LEN(10)                          +
                          MIN(0)                           +
                          DFT(*NONE)                       +
                          SPCVAL((*NONE))                  +
                          PMTCTL(*PMTRQS)                  +
                          PROMPT('Value for test library   (&TL)')

             PARM       KWD(TESTOBJ   ) TYPE(*CHAR)        +
                          LEN(10)                          +
                          MIN(0)                           +
                          DFT(*NONE)                       +
                          SPCVAL((*NONE))                  +
                          PMTCTL(*PMTRQS)                  +
                          PROMPT('Value for test object    (&TO)')

             PARM       KWD(TGTRLS    ) TYPE(*CHAR)        +
                          LEN(10)                          +
                          MIN(0)                           +
                          DFT(*NONE)                       +
                          SPCVAL((*NONE))                  +
                          PMTCTL(*PMTRQS)                  +
                          PROMPT('Value for target release (&TR)')

             PARM       KWD(FRMSRCLIB ) TYPE(*CHAR)        +
                          LEN(10)                          +
                          MIN(0)                           +
                          DFT(*NONE)                       +
                          SPCVAL((*NONE))                  +
                          PMTCTL(*PMTRQS)                  +
                          PROMPT('Value for from src.lib.  (&FL)')

             PARM       KWD(FRMSRCFILE) TYPE(*CHAR)        +
                          LEN(10)                          +
                          MIN(0)                           +
                          DFT(*NONE)                       +
                          SPCVAL((*NONE))                  +
                          PMTCTL(*PMTRQS)                  +
                          PROMPT('Value for from src. file (&FF)')

             PARM       KWD(FRMSRCMBR ) TYPE(*CHAR)        +
                          LEN(10)                          +
                          MIN(0)                           +
                          DFT(*NONE)                       +
                          SPCVAL((*NONE))                  +
                          PMTCTL(*PMTRQS)                  +
                          PROMPT('Value for from src. mbr. (&FM)')

             PARM       KWD(USER0     ) TYPE(*CHAR)        +
                          LEN(30)                          +
                          MIN(0)                           +
                          DFT(*NONE)                       +
                          SPCVAL((*NONE))                  +
                          PMTCTL(*PMTRQS)                  +
                          PROMPT('Value for user-def. par. (&U0)')

             PARM       KWD(USER1     ) TYPE(*CHAR)        +
                          LEN(30)                          +
                          MIN(0)                           +
                          DFT(*NONE)                       +
                          SPCVAL((*NONE))                  +
                          PMTCTL(*PMTRQS)                  +
                          PROMPT('Value for user-def. par. (&U1)')

             PARM       KWD(USER2     ) TYPE(*CHAR)        +
                          LEN(30)                          +
                          MIN(0)                           +
                          DFT(*NONE)                       +
                          SPCVAL((*NONE))                  +
                          PMTCTL(*PMTRQS)                  +
                          PROMPT('Value for user-def. par. (&U2)')

             PARM       KWD(USER3     ) TYPE(*CHAR)        +
                          LEN(30)                          +
                          MIN(0)                           +
                          DFT(*NONE)                       +
                          SPCVAL((*NONE))                  +
                          PMTCTL(*PMTRQS)                  +
                          PROMPT('Value for user-def. par. (&U3)')

             PARM       KWD(USER4     ) TYPE(*CHAR)        +
                          LEN(30)                          +
                          MIN(0)                           +
                          DFT(*NONE)                       +
                          SPCVAL((*NONE))                  +
                          PMTCTL(*PMTRQS)                  +
                          PROMPT('Value for user-def. par. (&U4)')

             PARM       KWD(USER5     ) TYPE(*CHAR)        +
                          LEN(30)                          +
                          MIN(0)                           +
                          DFT(*NONE)                       +
                          SPCVAL((*NONE))                  +
                          PMTCTL(*PMTRQS)                  +
                          PROMPT('Value for user-def. par. (&U5)')

             PARM       KWD(USER6     ) TYPE(*CHAR)        +
                          LEN(30)                          +
                          MIN(0)                           +
                          DFT(*NONE)                       +
                          SPCVAL((*NONE))                  +
                          PMTCTL(*PMTRQS)                  +
                          PROMPT('Value for user-def. par. (&U6)')

             PARM       KWD(USER7     ) TYPE(*CHAR)        +
                          LEN(30)                          +
                          MIN(0)                           +
                          DFT(*NONE)                       +
                          SPCVAL((*NONE))                  +
                          PMTCTL(*PMTRQS)                  +
                          PROMPT('Value for user-def. par. (&U7)')

             PARM       KWD(USER8     ) TYPE(*CHAR)        +
                          LEN(30)                          +
                          MIN(0)                           +
                          DFT(*NONE)                       +
                          SPCVAL((*NONE))                  +
                          PMTCTL(*PMTRQS)                  +
                          PROMPT('Value for user-def. par. (&U8)')

             PARM       KWD(USER9     ) TYPE(*CHAR)        +
                          LEN(30)                          +
                          MIN(0)                           +
                          DFT(*NONE)                       +
                          SPCVAL((*NONE))                  +
                          PMTCTL(*PMTRQS)                  +
                          PROMPT('Value for user-def. par. (&U9)')

             PARM       KWD(MSGF      ) TYPE(*CHAR)        +
                          LEN(10)                          +
                          CONSTANT(RUNCLSTME)

             PARM       KWD(NAMING    ) TYPE(*CHAR)        +
                          LEN(10)                          +
                          MIN(0)                           +
                          DFT(*SYS)                        +
                          RSTD(*YES)                       +
                          SPCVAL((*SYS )                   +
                                 (*SQL ))                  +
                          PMTCTL(*PMTRQS)                  +
                          PROMPT('SQL Naming convention')

 QUAL1:      QUAL       TYPE(*NAME) LEN(10) MIN(1)
             QUAL       TYPE(*NAME) LEN(10) DFT(*LIBL)     +
                          SPCVAL((*LIBL) (*CURLIB))        +
                          PROMPT('Library')

