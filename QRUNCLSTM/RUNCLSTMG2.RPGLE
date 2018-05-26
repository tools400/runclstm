      * =================================================================== *
      *                                                                     *
      *  Kurzdokumentation :                                                *
      *                                                                     *
      *  Bereich . . . : RUNCLSTM                                           *
      *  Objekt  . . . : RUNCLSTMG2                                         *
      *  Beschreibung  : Tool: RUNCLSTM   (Run CL Statements         )      *
      *  Author  . . . : Thomas Raddatz   <thomas.raddatz@tools400.de>      *
      *  Datum . . . . : 03.08.2000                                         *
      *                                                                     *
      * =================================================================== *
      *
      *===============================================================*
      *  Common used prototypes
      *===============================================================*
      *
     D p_rmvPgmMsg...
     D                 PR                         extpgm('QMHRMVPM')
     D  i_callStackE                 10A   const
     D  i_callStackC                 10I 0 const
     D  i_msgKey                      4A   const
     D  i_msgToRmv                   10A   const
     D  i_errCode                 32767A         options(*varsize)
     D  i_lenCalStkE                 10I 0       options(*nopass)
     D  i_calStkEQual                20A         options(*nopass)
     D  i_rmvExcp                    10A         options(*nopass)
     D  i_calStkeDTyp                10A         options(*nopass)
      *
     D p_testOmit      PR                  extproc('CEETSTA')
     D   isPresent                   10I 0
     D   ArgNumber                   10I 0 const
     D   fc                          12A          options(*OMIT)
      *
     D p_getOpDesc...
     D                 PR                  extproc('CEEDOD')
     D  posNr                        10I 0 const
     D  descType                     10I 0
     D  datatype                     10I 0
     D  descInf1                     10I 0
     D  descInf2                     10I 0
     D  dataLen                      10I 0
     D  fc                           12A          options(*OMIT)
      *
