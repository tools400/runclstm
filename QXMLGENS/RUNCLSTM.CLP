/* -------------------------------------------------------------------------- */
/* RUNCLSTM   - SCRIPT MEMBER                                                 */
/* Use commands  xmlgenINC (generate text for install pgm)                    */
/*               xmlgenMBR (to define source members                          */
/*               xmlgenCMD (execute qcmdexc at run time                       */
/* Put &TOLIB where you want user selected lib at run time.                   */
   DCL &TOLIB *CHAR 10
/* -------------------------------------------------------------------------- */
/* >>PRE-COMPILER<<                                                           */
/*   >>CRTCMD<<  XMLGEN  XMLSCRIPT(&SM) SCRIPTSRCF(&SL/&SF);                  */
/*   >>IMPORTANT<<                                                            */
/*     >>PARM<<  SRCTOFILE(&LI/QXML);                                         */
/*     >>PARM<<  XMLMBR(*SCRIPT);                                             */
/*     >>PARM<<  ENCODING('ISO-8859-1');                                      */
/*     >>PARM<<  AUTHOR('Thomas Raddatz');                                    */
/*   >>END-IMPORTANT<<                                                        */
/*   >>EXECUTE<<                                                              */
/* >>END-PRE-COMPILER<<                                                       */
/* -------------------------------------------------------------------------- */
             XMLGENINC  XINCLUDE(*YES)

             XMLGENVRS XSRCFILE(QRUNCLSTM) XSRCLIB(RUNCLSTMD) XSRCMBR(COPYRIGHT)

             XMLGENCND  XMSG('Select language (GER, ENG)') +
                          XVALUES(GER ENG) XVAR(&LANG)

             XMLGENSET  XVAR(&SRCFILE) XVALUE(QRUNCLSTM)

/* ---------------------------------- */
/*  Deploy source member              */
/* ---------------------------------- */
             XMLGENMBR  XMBR(A_INSTALL) XMBRATR(CLLE) +
                          XFROMSRCF(QRUNCLSTM ) XFROMSRCL(RUNCLSTMD) +
                          XTOSRCF(QRUNCLSTM ) XOBJTYPE(*PGM) +
                          XGENCRT(*NO) XPARAM(*BLANK)

             XMLGENMBR  XMBR(A_MSG_ENG) XMBRATR(CLP) +
                          XFROMSRCF(QRUNCLSTM ) XFROMSRCL(RUNCLSTMD) +
                          XTOSRCF(QRUNCLSTM ) XOBJTYPE(*PGM) +
                          XGENCRT(*NO) XPARAM(*BLANK)

             XMLGENMBR  XMBR(A_MSG_GER) XMBRATR(CLP) +
                          XFROMSRCF(QRUNCLSTM ) XFROMSRCL(RUNCLSTMD) +
                          XTOSRCF(QRUNCLSTM ) XOBJTYPE(*PGM) +
                          XGENCRT(*NO) XPARAM(*BLANK)

             XMLGENMBR  XMBR(COPYRIGHT ) XMBRATR(RPGLE   ) +
                          XFROMSRCF(QRUNCLSTM ) XFROMSRCL(RUNCLSTMD ) +
                          XTOSRCF(QRUNCLSTM ) XOBJTYPE(*PGM    ) +
                          XGENCRT(*NO ) XPARAM(*BLANK)

             XMLGENMBR  XMBR(FDERRCODE ) XMBRATR(RPGLE   ) +
                          XFROMSRCF(QRUNCLSTM ) XFROMSRCL(RUNCLSTMD ) +
                          XTOSRCF(QRUNCLSTM ) XOBJTYPE(*PGM    ) +
                          XGENCRT(*NO ) XPARAM(*BLANK)

             XMLGENMBR  XMBR(FDMSG     ) XMBRATR(RPGLE   ) +
                          XFROMSRCF(QRUNCLSTM ) XFROMSRCL(RUNCLSTMD ) +
                          XTOSRCF(QRUNCLSTM ) XOBJTYPE(*PGM    ) +
                          XGENCRT(*NO ) XPARAM(*BLANK)

             XMLGENMBR  XMBR(FDQOBJ    ) XMBRATR(RPGLE   ) +
                          XFROMSRCF(QRUNCLSTM ) XFROMSRCL(RUNCLSTMD ) +
                          XTOSRCF(QRUNCLSTM ) XOBJTYPE(*PGM    ) +
                          XGENCRT(*NO ) XPARAM(*BLANK)

             XMLGENMBR  XMBR(RUNCLSTM  ) XMBRATR(CMD   ) +
                          XFROMSRCF(QRUNCLSTM ) XFROMSRCL(RUNCLSTMD ) +
                          XTOSRCF(QRUNCLSTM ) XOBJTYPE(*CMD    ) +
                          XGENCRT(*NO ) XPARAM(*BLANK)

             XMLGENMBR  XMBR(RUNCLSTME ) XMBRATR(CMD   ) +
                          XFROMSRCF(QRUNCLSTM ) XFROMSRCL(RUNCLSTMD ) +
                          XTOSRCF(QRUNCLSTM ) XOBJTYPE(*CMD    ) +
                          XGENCRT(*NO ) XPARAM(*BLANK)

             XMLGENMBR  XMBR(RUNCLSTMF ) XMBRATR(BND     ) +
                          XFROMSRCF(QRUNCLSTM ) XFROMSRCL(RUNCLSTMD ) +
                          XTOSRCF(QRUNCLSTM ) XOBJTYPE(*PGM    ) +
                          XGENCRT(*NO ) XPARAM(*BLANK)

             XMLGENMBR  XMBR(RUNCLSTMG1) XMBRATR(RPGLE   ) +
                          XFROMSRCF(QRUNCLSTM ) XFROMSRCL(RUNCLSTMD ) +
                          XTOSRCF(QRUNCLSTM ) XOBJTYPE(*PGM    ) +
                          XGENCRT(*NO ) XPARAM(*BLANK)

             XMLGENMBR  XMBR(RUNCLSTMG2) XMBRATR(RPGLE   ) +
                          XFROMSRCF(QRUNCLSTM ) XFROMSRCL(RUNCLSTMD ) +
                          XTOSRCF(QRUNCLSTM ) XOBJTYPE(*PGM    ) +
                          XGENCRT(*NO ) XPARAM(*BLANK)

             XMLGENMBR  XMBR(RUNCLSTMG3) XMBRATR(RPGLE   ) +
                          XFROMSRCF(QRUNCLSTM ) XFROMSRCL(RUNCLSTMD ) +
                          XTOSRCF(QRUNCLSTM ) XOBJTYPE(*PGM    ) +
                          XGENCRT(*NO ) XPARAM(*BLANK)

             XMLGENMBR  XMBR(RUNCLSTMP ) XMBRATR(PNLGRP  ) +
                          XFROMSRCF(QRUNCLSTM ) XFROMSRCL(RUNCLSTMD ) +
                          XTOSRCF(QRUNCLSTM ) XOBJTYPE(*PNLGRP ) +
                          XGENCRT(*NO ) XPARAM(*BLANK)

             XMLGENMBR  XMBR(RUNCLSTMPE) XMBRATR(PNLGRP  ) +
                          XFROMSRCF(QRUNCLSTM ) XFROMSRCL(RUNCLSTMD ) +
                          XTOSRCF(QRUNCLSTM ) XOBJTYPE(*PNLGRP ) +
                          XGENCRT(*NO ) XPARAM(*BLANK)

             XMLGENMBR  XMBR(RUNCLSTMR1) XMBRATR(RPGLE   ) +
                          XFROMSRCF(QRUNCLSTM ) XFROMSRCL(RUNCLSTMD ) +
                          XTOSRCF(QRUNCLSTM ) XOBJTYPE(*MODULE ) +
                          XGENCRT(*NO ) XPARAM(*BLANK)

             XMLGENMBR  XMBR(RUNCLSTMS1) XMBRATR(RPGLE   ) +
                          XFROMSRCF(QRUNCLSTM ) XFROMSRCL(RUNCLSTMD ) +
                          XTOSRCF(QRUNCLSTM ) XOBJTYPE(*MODULE ) +
                          XGENCRT(*NO ) XPARAM(*BLANK)

             XMLGENMBR  XMBR(RUNCLSTMS2) XMBRATR(RPGLE   ) +
                          XFROMSRCF(QRUNCLSTM ) XFROMSRCL(RUNCLSTMD ) +
                          XTOSRCF(QRUNCLSTM ) XOBJTYPE(*MODULE ) +
                          XGENCRT(*NO ) XPARAM(*BLANK)

             XMLGENMBR  XMBR(SQLCLI    ) XMBRATR(RPGLE   ) +
                          XFROMSRCF(QRUNCLSTM ) XFROMSRCL(RUNCLSTMD ) +
                          XTOSRCF(QRUNCLSTM ) XOBJTYPE(*MODULE ) +
                          XGENCRT(*NO ) XPARAM(*BLANK)

             XMLGENMBR  XMBR(USR0001   ) XMBRATR(RPGLE   ) +
                          XFROMSRCF(QRUNCLSTM ) XFROMSRCL(RUNCLSTMD ) +
                          XTOSRCF(QRUNCLSTM ) XOBJTYPE(*PGM    ) +
                          XGENCRT(*NO ) XPARAM(*BLANK)

             XMLGENMBR  XMBR(USR0002   ) XMBRATR(RPGLE   ) +
                          XFROMSRCF(QRUNCLSTM ) XFROMSRCL(RUNCLSTMD ) +
                          XTOSRCF(QRUNCLSTM ) XOBJTYPE(*PGM    ) +
                          XGENCRT(*NO ) XPARAM(*BLANK)

             XMLGENMBR  XMBR(USR0003   ) XMBRATR(RPGLE   ) +
                          XFROMSRCF(QRUNCLSTM ) XFROMSRCL(RUNCLSTMD ) +
                          XTOSRCF(QRUNCLSTM ) XOBJTYPE(*PGM    ) +
                          XGENCRT(*NO ) XPARAM(*BLANK)

             XMLGENMBR  XMBR(USR0004   ) XMBRATR(RPGLE   ) +
                          XFROMSRCF(QRUNCLSTM ) XFROMSRCL(RUNCLSTMD ) +
                          XTOSRCF(QRUNCLSTM ) XOBJTYPE(*PGM    ) +
                          XGENCRT(*NO ) XPARAM(*BLANK)

/* ---------------------------------- */
/*  Create objects                    */
/* ---------------------------------- */
             XMLGENCMD  XCMD(CRTBNDCL PGM(&TOLIB/A_INSTALL) +
                          SRCFILE(&TOLIB/QRUNCLSTM ) SRCMBR(*PGM) +
                          DFTACTGRP(*NO) ACTGRP(*NEW) +
                          DBGVIEW(*LIST)) XDLTSPLF(A_INSTALL)

             XMLGENCMD  XCMD(CALL PGM(&TOLIB/A_INSTALL) +
                             PARM('&TGTRLS' '&SRCFILE' '&TOLIB' '&LANG'))
             XMLGENCMD  XCMD(DLTPGM PGM(&TOLIB/A_INSTALL))

