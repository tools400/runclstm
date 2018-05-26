/* -------------------------------------------------------------------------- */
/* RUNCLSTM   - SCRIPT MEMBER                                                 */
/* Use commands  xmlgenINC (generate text for install pgm)                    */
/*               xmlgenMBR (to define source members                          */
/*               xmlgenCMD (execute qcmdexc at run time                       */
/* Put &TOLIB where you want user selected lib at run time.                   */
   DCL &TOLIB *CHAR 10
/* -------------------------------------------------------------------------- */
             XMLGENINC  XINCLUDE(*YES)
                                                                      /* RADD */
             XMLGENCND  XMSG('Select language (GER, ENG)') +
                          XVALUES(GER ENG)                            /* RADD */

             XMLGENCMD  XCMD(DLTCMD    CMD(&TOLIB/RUNCLSTM     ))     /* RADD */
             XMLGENCMD  XCMD(DLTCMD    CMD(&TOLIB/RUNCLSTME    ))     /* RADD */
                                                                      /* RADD */
             XMLGENCMD  XCMD(DLTPGM    PGM(&TOLIB/RUNCLSTM     ))     /* RADD */
             XMLGENCMD  XCMD(DLTSRVPGM SRVPGM(&TOLIB/RUNCLSTMS1))     /* RADD */
                                                                      /* RADD */
             XMLGENCMD  XCMD(DLTMSGF   MSGF(&TOLIB/RUNCLSTM    ))     /* RADD */
             XMLGENCMD  XCMD(DLTMSGF   MSGF(&TOLIB/RUNCLSTME   ))     /* RADD */
                                                                      /* RADD */
             XMLGENCMD  XCMD(DLTPNLGRP PNLGRP(&TOLIB/RUNCLSTMP ))     /* RADD */
             XMLGENCMD  XCMD(DLTPNLGRP PNLGRP(&TOLIB/RUNCLSTMPE))     /* RADD */

             XMLGENCMD  XCMD(DLTF      FILE(&TOLIB/XDERRCODE   ))     /* RADD */
             XMLGENCMD  XCMD(DLTF      FILE(&TOLIB/XDMSG       ))     /* RADD */
             XMLGENCMD  XCMD(DLTF      FILE(&TOLIB/XDQOBJ      ))     /* RADD */

             XMLGENCMD  XCMD(CRTMSGF MSGF(&TOLIB/RUNCLSTM ) +
                          TEXT('Tool: RUNCLSTM   (Run CL +
                          Statements  )')) +
                        XCND(GER)                                     /* RADD */
             XMLGENCMD  XCMD(CRTMSGF MSGF(&TOLIB/RUNCLSTME) +
                          TEXT('Tool: RUNCLSTM   (Run CL +
                          Statements  )')) +
                        XCND(ENG)                                     /* RADD */

             XMLGENMBR  XMBR(#MSG_GER) XMBRATR(CLP) +
                          XFROMSRCF(QRUNCLSTM ) XFROMSRCL(UBMSYS) +
                          XTOSRCF(QRUNCLSTM ) XOBJTYPE(*PGM) +
                          XGENCRT(*YES) XPARAM(*BLANK) +
                        XCND(GER)                                     /* RADD */
             XMLGENMBR  XMBR(#MSG_ENG) XMBRATR(CLP) +
                          XFROMSRCF(QRUNCLSTM ) XFROMSRCL(UBMSYS) +
                          XTOSRCF(QRUNCLSTM ) XOBJTYPE(*PGM) +
                          XGENCRT(*YES) XPARAM(*BLANK) +
                        XCND(ENG)                                     /* RADD */

             XMLGENCMD  XCMD(CALL PGM(&TOLIB/#MSG_GER) +
                          PARM('&TOLIB')) +
                        XCND(GER)                                     /* RADD */
             XMLGENCMD  XCMD(CALL PGM(&TOLIB/#MSG_ENG) +
                          PARM('&TOLIB')) +
                        XCND(ENG)                                     /* RADD */

             XMLGENCMD  XCMD(DLTPGM PGM(&TOLIB/#MSG_GER))
             XMLGENCMD  XCMD(DLTPGM PGM(&TOLIB/#MSG_ENG))

             XMLGENMBR  XMBR(XDERRCODE ) XMBRATR(PF      ) +
                          XFROMSRCF(QRUNCLSTM ) XFROMSRCL(UBMSYS ) +
                          XTOSRCF(QRUNCLSTM ) XOBJTYPE(*FILE   ) +
                          XGENCRT(*YES) XPARAM(*BLANK)                /* RADD */

             XMLGENMBR  XMBR(XDMSG     ) XMBRATR(PF      ) +
                          XFROMSRCF(QRUNCLSTM ) XFROMSRCL(UBMSYS ) +
                          XTOSRCF(QRUNCLSTM ) XOBJTYPE(*FILE   ) +
                          XGENCRT(*YES) XPARAM(*BLANK)                /* RADD */

             XMLGENMBR  XMBR(XDQOBJ    ) XMBRATR(PF      ) +
                          XFROMSRCF(QRUNCLSTM ) XFROMSRCL(UBMSYS ) +
                          XTOSRCF(QRUNCLSTM ) XOBJTYPE(*FILE   ) +
                          XGENCRT(*YES) XPARAM(*BLANK)                /* RADD */

             XMLGENMBR  XMBR(COPYRIGHT ) XMBRATR(RPGLE   ) +
                          XFROMSRCF(QRUNCLSTM ) XFROMSRCL(UBMSYS ) +
                          XTOSRCF(QRUNCLSTM ) XOBJTYPE(*PGM    ) +
                          XGENCRT(*NO ) XPARAM(*BLANK)                /* RADD */

             XMLGENMBR  XMBR(RUNCLSTMG1) XMBRATR(RPGLE   ) +
                          XFROMSRCF(QRUNCLSTM ) XFROMSRCL(UBMSYS ) +
                          XTOSRCF(QRUNCLSTM ) XOBJTYPE(*PGM    ) +
                          XGENCRT(*NO ) XPARAM(*BLANK)                /* RADD */

             XMLGENMBR  XMBR(RUNCLSTMG2) XMBRATR(RPGLE   ) +
                          XFROMSRCF(QRUNCLSTM ) XFROMSRCL(UBMSYS ) +
                          XTOSRCF(QRUNCLSTM ) XOBJTYPE(*PGM    ) +
                          XGENCRT(*NO ) XPARAM(*BLANK)                /* RADD */
                                                                      /* RADD */
             XMLGENMBR  XMBR(RUNCLSTMG3) XMBRATR(RPGLE   ) +
                          XFROMSRCF(QRUNCLSTM ) XFROMSRCL(UBMSYS ) +
                          XTOSRCF(QRUNCLSTM ) XOBJTYPE(*PGM    ) +
                          XGENCRT(*NO ) XPARAM(*BLANK)                /* RADD */

             XMLGENMBR  XMBR(RUNCLSTMF ) XMBRATR(BND     ) +
                          XFROMSRCF(QRUNCLSTM ) XFROMSRCL(UBMSYS ) +
                          XTOSRCF(QRUNCLSTM ) XOBJTYPE(*PGM    ) +
                          XGENCRT(*NO ) XPARAM(*BLANK)                /* RADD */

             XMLGENMBR  XMBR(RUNCLSTMP ) XMBRATR(PNLGRP  ) +
                          XFROMSRCF(QRUNCLSTM ) XFROMSRCL(UBMSYS ) +
                          XTOSRCF(QRUNCLSTM ) XOBJTYPE(*PNLGRP ) +
                          XGENCRT(*YES) XPARAM(*BLANK) +
                        XCND(GER)                                     /* RADD */

             XMLGENMBR  XMBR(RUNCLSTMPE) XMBRATR(PNLGRP  ) +
                          XFROMSRCF(QRUNCLSTM ) XFROMSRCL(UBMSYS ) +
                          XTOSRCF(QRUNCLSTM ) XOBJTYPE(*PNLGRP ) +
                          XGENCRT(*YES) XPARAM(*BLANK) +
                        XCND(ENG)                                     /* RADD */

             XMLGENMBR  XMBR(RUNCLSTMR1) XMBRATR(RPGLE   ) +
                          XFROMSRCF(QRUNCLSTM ) XFROMSRCL(UBMSYS ) +
                          XTOSRCF(QRUNCLSTM ) XOBJTYPE(*MODULE ) +
                          XGENCRT(*NO ) XPARAM(*BLANK)                /* RADD */

             XMLGENMBR  XMBR(RUNCLSTMS1) XMBRATR(RPGLE   ) +
                          XFROMSRCF(QRUNCLSTM ) XFROMSRCL(UBMSYS ) +
                          XTOSRCF(QRUNCLSTM ) XOBJTYPE(*MODULE ) +
                          XGENCRT(*NO ) XPARAM(*BLANK)                /* RADD */

             XMLGENMBR  XMBR(RUNCLSTMS2) XMBRATR(RPGLE   ) +
                          XFROMSRCF(QRUNCLSTM ) XFROMSRCL(UBMSYS ) +
                          XTOSRCF(QRUNCLSTM ) XOBJTYPE(*MODULE ) +
                          XGENCRT(*NO ) XPARAM(*BLANK)                /* RADD */
                                                                      /* RADD */
             XMLGENMBR  XMBR(SQLCLI    ) XMBRATR(RPGLE   ) +
                          XFROMSRCF(QRUNCLSTM ) XFROMSRCL(UBMSYS ) +
                          XTOSRCF(QRUNCLSTM ) XOBJTYPE(*MODULE ) +
                          XGENCRT(*NO ) XPARAM(*BLANK)                /* RADD */

             XMLGENMBR  XMBR(USR0001   ) XMBRATR(RPGLE   ) +
                          XFROMSRCF(QRUNCLSTM ) XFROMSRCL(UBMSYS ) +
                          XTOSRCF(QRUNCLSTM ) XOBJTYPE(*PGM    ) +
                          XGENCRT(*NO ) XPARAM(*BLANK)                /* RADD */

             XMLGENMBR  XMBR(USR0002   ) XMBRATR(RPGLE   ) +
                          XFROMSRCF(QRUNCLSTM ) XFROMSRCL(UBMSYS ) +
                          XTOSRCF(QRUNCLSTM ) XOBJTYPE(*PGM    ) +
                          XGENCRT(*NO ) XPARAM(*BLANK)                /* RADD */

             XMLGENMBR  XMBR(USR0003   ) XMBRATR(RPGLE   ) +
                          XFROMSRCF(QRUNCLSTM ) XFROMSRCL(UBMSYS ) +
                          XTOSRCF(QRUNCLSTM ) XOBJTYPE(*PGM    ) +
                          XGENCRT(*NO ) XPARAM(*BLANK)                /* RADD */

             XMLGENMBR  XMBR(USR0004   ) XMBRATR(RPGLE   ) +
                          XFROMSRCF(QRUNCLSTM ) XFROMSRCL(UBMSYS ) +
                          XTOSRCF(QRUNCLSTM ) XOBJTYPE(*PGM    ) +
                          XGENCRT(*NO ) XPARAM(*BLANK)                /* RADD */

             XMLGENCMD  XCMD(CRTRPGMOD  MODULE(&TOLIB/RUNCLSTMS1) +
                                        SRCFILE(&TOLIB/QRUNCLSTM) +
                                        SRCMBR(*MODULE) +
                                        DBGVIEW(*LIST) )              /* RADD */
                                                                      /* RADD */
             XMLGENCMD  XCMD(CRTRPGMOD  MODULE(&TOLIB/RUNCLSTMS2) +
                                        SRCFILE(&TOLIB/QRUNCLSTM) +
                                        SRCMBR(*MODULE) +
                                        DBGVIEW(*LIST) )              /* RADD */

             XMLGENCMD  XCMD(CRTSRVPGM  SRVPGM(&TOLIB/RUNCLSTMS1)  +
                                        MODULE(&TOLIB/RUNCLSTMS1   +
                                               &TOLIB/RUNCLSTMS2 ) +
                                        SRCFILE(&TOLIB/QRUNCLSTM)  +
                                        SRCMBR(RUNCLSTMF )         +
                                        ACTGRP(*CALLER)            +
                                        DETAIL(*BASIC)             +
                 TEXT('Tool: RUNCLSCT   (Run CL Statement   )')    )  /* RADD */

             XMLGENCMD  XCMD(CRTRPGMOD  MODULE(&TOLIB/RUNCLSTMR1)  +
                                        SRCFILE(&TOLIB/QRUNCLSTM)  +
                                        SRCMBR(*MODULE) +
                                        DBGVIEW(*LIST) )              /* RADD */

             XMLGENCMD  XCMD(CRTPGM     PGM(&TOLIB/RUNCLSTM)         +
                                        MODULE(&TOLIB/RUNCLSTMR1)    +
                                        ENTMOD(*FIRST)               +
                                        ACTGRP(*NEW)                 +
                                        BNDSRVPGM(&TOLIB/RUNCLSTMS1) +
                                        BNDDIR(*LIBL/QC2LE)          +
                                        DETAIL(*BASIC))               /* RADD */

             XMLGENMBR  XMBR(RUNCLSTM  ) XMBRATR(CMD   ) +
                          XFROMSRCF(QRUNCLSTM ) XFROMSRCL(UBMSYS ) +
                          XTOSRCF(QRUNCLSTM ) XOBJTYPE(*CMD    ) +
                          XGENCRT(*NO ) XPARAM(*BLANK) +
                        XCND(GER)                                     /* RADD */

             XMLGENMBR  XMBR(RUNCLSTME ) XMBRATR(CMD   ) +
                          XFROMSRCF(QRUNCLSTM ) XFROMSRCL(UBMSYS ) +
                          XTOSRCF(QRUNCLSTM ) XOBJTYPE(*CMD    ) +
                          XGENCRT(*NO ) XPARAM(*BLANK) +
                        XCND(ENG)                                     /* RADD */
                                                                      /* RADD */
             XMLGENCMD  XCMD(CRTCMD       CMD(&TOLIB/RUNCLSTM  ) +
                          SRCFILE(&TOLIB/QRUNCLSTM )             +
                          SRCMBR(*CMD      )                     +
                          PGM(*LIBL/RUNCLSTM  )                  +
                          HLPPNLGRP(*LIBL/RUNCLSTMP )            +
                          HLPID(RUNCLSTM  )                      +
                          PRDLIB(&TOLIB)                         +
                          )                                      +
                        XCND(GER)                                     /* RADD */
                                                                      /* RADD */
             XMLGENCMD  XCMD(CRTCMD       CMD(&TOLIB/RUNCLSTME ) +
                          SRCFILE(&TOLIB/QRUNCLSTM )             +
                          SRCMBR(*CMD      )                     +
                          PGM(*LIBL/RUNCLSTM  )                  +
                          HLPPNLGRP(*LIBL/RUNCLSTMPE)            +
                          HLPID(RUNCLSTM  )                      +
                          PRDLIB(&TOLIB)                         +
                          )                                      +
                        XCND(ENG)                                     /* RADD */
                                                                      /* RADD */
             XMLGENCMD  XCMD(RNMOBJ OBJ(&TOLIB/RUNCLSTME) +
                          OBJTYPE(*CMD) NEWOBJ(RUNCLSTM)) +
                        XCND(ENG)                                     /* RADD */
                                                                      /* RADD */
             XMLGENCMD  XCMD(DLTF      FILE(&TOLIB/XDERRCODE   ))     /* RADD */
             XMLGENCMD  XCMD(DLTF      FILE(&TOLIB/XDMSG       ))     /* RADD */
             XMLGENCMD  XCMD(DLTF      FILE(&TOLIB/XDQOBJ      ))     /* RADD */
                                                                      /* RADD */
             XMLGENCMD  XCMD(DLTMOD    MODULE(&TOLIB/RUNCLSTMR1))     /* RADD */
             XMLGENCMD  XCMD(DLTMOD    MODULE(&TOLIB/RUNCLSTMS1))     /* RADD */
             XMLGENCMD  XCMD(DLTMOD    MODULE(&TOLIB/RUNCLSTMS2))     /* RADD */

