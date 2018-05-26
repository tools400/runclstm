      * =================================================================== *
      *                                                                     *
      *  Kurzdokumentation :                                                *
      *                                                                     *
      *  Bereich . . . : RUNCLSTM                                           *
      *  Objekt  . . . : RUNCLSTMR1                                         *
      *  Beschreibung  : Tool: RUNCLSTM   (Run CL Statements         )      *
      *  Author  . . . : Thomas Raddatz   <thomas.raddatz@tools400.de>      *
      *  Datum . . . . : 03.08.2000                                         *
      *                                                                     *
      * =================================================================== *
      *                                                                     *
      *  This software is free software, you can redistribute it and/or     *
      *  modify it under the terms of the GNU General Public License (GPL)  *
      *  as published by the Free Software Foundation.                      *
      *                                                                     *
      *  See GNU General Public License for details.                        *
      *          http://www.opensource.org                                  *
      *          http://www.opensource.org/licenses/gpl-license.html        *
      *                                                                     *
      *=====================================================================*
      *  History:                                                           *
      *                                                                     *
      *  Datum       Name          Änderung                                 *
      *  ----------  ------------  ---------------------------------------  *
      *  12.04.2005  Th.Raddatz    Fixed Problem that variables were not    *
      *                            replaced for MONMSG statements.          *
      *                                                                     *
      * =================================================================== *
      * >>PRE-COMPILER<<                                                    *
      *                                                                     *
      *   >>CRTCMD<< CRTRPGMOD    MODULE(&LI/&OB) +                         *
      *                           SRCFILE(&SL/&SF) +                        *
      *                           SRCMBR(&SM);                              *
      *                                                                     *
      *   >>COMPILE<<                                                       *
      *     >>PARM<< TRUNCNBR(*NO);                                         *
      *     >>PARM<< DBGVIEW(*LIST);                                        *
      *   >>END-COMPILE<<                                                   *
      *                                                                     *
      *   >>EXECUTE<<                                                       *
      *                                                                     *
      * >>END-PRE-COMPILER<<                                                *
      * =================================================================== *
      /COPY QRUNCLSTM,COPYRIGHT
      * =================================================================== *
     FSCRIPT    IF   F32766        DISK    usropn
     F
     F
      *
     D inf1_script     DS
     D  inf1_status           11     15S 0 inz
     D  inf1_msg              46     52A   inz
     D  inf1_file             83     92A   inz
     D  inf1_lib              93    102A   inz
     D  inf1_recLen          125    126I 0 inz
     D  inf1_mbr             129    138A   inz
     D  inf1_recNbr          397    400I 0 inz
      *
     D ds_script       DS
     D  ds_srcSeq                     6S 2 inz
     D  ds_srcDat                     6S 0 inz
     D  ds_srcDta                 32754A   inz
      *
      *===============================================================*
      *  Type Definitions
      *===============================================================*
     D rplVarData_t    DS                  based(pDummy)   qualified
     D  xLib                               like(gi_xLib       )
     D  xObj                               like(gi_xObj       )
     D  xTypeCode                          like(gi_xTypeCode  )
     D  xSrcLib                            like(gi_xSrcLib    )
     D  xSrcFile                           like(gi_xSrcFile   )
     D  xSrcMbr                            like(gi_xSrcMbr    )
     D  xTestLib                           like(gi_xTestLib   )
     D  xTestObj                           like(gi_xTestObj   )
     D  xTgtRls                            like(gi_xTgtRls    )
     D  xFrmSrcLib                         like(gi_xFrmSrcLib )
     D  xFrmSrcFile                        like(gi_xFrmSrcFile)
     D  xFrmSrcMbr                         like(gi_xFrmSrcMbr )
     D  xUser0                             like(gi_xUser0     )
     D  xUser1                             like(gi_xUser1     )
     D  xUser2                             like(gi_xUser2     )
     D  xUser3                             like(gi_xUser3     )
     D  xUser4                             like(gi_xUser4     )
     D  xUser5                             like(gi_xUser5     )
     D  xUser6                             like(gi_xUser6     )
     D  xUser7                             like(gi_xUser6     )
     D  xUser8                             like(gi_xUser6     )
     D  xUser9                             like(gi_xUser6     )
      *
      *===============================================================*
      *  Common Constants
      *===============================================================*
      *
      /COPY QRUNCLSTM,RUNCLSTMG3
      *
      *===============================================================*
      *  Messages
      *===============================================================*
      /COPY QRUNCLSTM,USR0002
      /COPY QRUNCLSTM,USR0003
      /COPY QRUNCLSTM,USR0004
      *
      *===============================================================*
      *  Imported Prototypes
      *===============================================================*
      *
      /COPY QRUNCLSTM,RUNCLSTMG1
      /COPY QRUNCLSTM,RUNCLSTMG2
      *
     D ceertx          PR                         extproc('CEERTX')
     D  i_procedure                    *   const  procptr
     D  i_token                        *   const  options(*omit)
     D  o_fc                         12A          options(*omit)
      *
     D ceeutx          PR                         extproc('CEEUTX')
     D  i_procedure                    *   const  procptr
     D  o_fc                         12A          options(*omit)
      *
      *===============================================================*
      *  Private Prototypes
      *===============================================================*
      *
     D p_main...
     D                 PR
     D  i_qFile                            value like(qObj_t    )
     D  i_mbr                              value like(mbr_t     )
     D  i_strSeq                           value like(srcSeq_t  )
     D  i_endSeq                           value like(srcSeq_t  )
     D  i_xLib                             value like(lib_t     )
     D  i_xObj                             value like(obj_t     )
     D  i_xTypeCode                        value like(typecode_t)
     D  i_xSrcLib                          value like(lib_t     )
     D  i_xSrcFile                         value like(file_t    )
     D  i_xSrcMbr                          value like(mbr_t     )
     D  i_xTestLib                         value like(lib_t     )
     D  i_xTestObj                         value like(obj_t     )
     D  i_xTgtRls                          value like(tgtRls_t  )
     D  i_xFrmSrcLib                       value like(lib_t     )
     D  i_xFrmSrcFile                      value like(file_t    )
     D  i_xFrmSrcMbr                       value like(mbr_t     )
     D  i_xUser0                           value like(userdef_t )
     D  i_xUser1                           value like(userdef_t )
     D  i_xUser2                           value like(userdef_t )
     D  i_xUser3                           value like(userdef_t )
     D  i_xUser4                           value like(userdef_t )
     D  i_xUser5                           value like(userdef_t )
     D  i_xUser6                           value like(userdef_t )
     D  i_xUser7                           value like(userdef_t )
     D  i_xUser8                           value like(userdef_t )
     D  i_xUser9                           value like(userdef_t )
     D  i_msgF                             value like(msg_t_file)
     D  i_naming                           value like(naming_t  )
      *
     D p_abnEndProc    PR
     D  i_token                        *   const
      *
     D f_getCmd...
     D                 PR                        like(bool_t        )
     D  io_cmdString                             like(capcmd_t      )
     D  i_strSeq                           value like(srcSeq_t      )
     D  i_endSeq                           value like(srcSeq_t      )
      *
     D p_replace...
     D                 PR
     D  io_string                                like(capcmd_t  )
     D  i_var                        10A   value
     D  i_value                     256A   value
      *
     D f_monMsg...
     D                 PR                         like(bool_t    )
     D  i_msgID                            value  like(msg_t_id  )
     D  i_strSeq                           value like(srcSeq_t   )
     D  i_endSeq                           value like(srcSeq_t   )
     D  i_rplVarData                       value likeds(rplVarData_t)
      *
     D f_rtvCmdToken...
     D                 PR                         like(bool_t    )
     D  i_cmdString                        value  like(capcmd_t  )
     D  o_cmdToken                                like(cmdToken_t)
      *
     D f_rtvCmdParm...
     D                 PR                         like(bool_t    )
     D  i_cmdString                        value  like(capcmd_t  )
     D  o_cmdParm                                 like(capcmd_t  )
      *
     D f_rtvKeyWrd...
     D                 PR                         like(capcmd_t  )
     D  i_keyWrd                     10A   value
     D  i_cmd                              value  like(capcmd_t  )
      *
     D f_rtvKeyWrdDta...
     D                 PR                         like(capcmd_t  )
     D  i_keyWrd                           value  like(capcmd_t  )
      *
     D f_getToken...
     D                 PR              *                       extproc('strtok')
     D  pString                        *   value options(*string)
     D  pTokenList                     *   value options(*string)
      *
     D f_ucase...
     D                 PR          2048A
     D  i_string                   2048A   value
      *
     D f_rplVars...
     D                 PR                        like(capcmd_t      )
     D  i_cmdString                        value like(capcmd_t      )
     D  i_rplVarData                       value likeds(rplVarData_t)
      *
      *===============================================================*
      *  Global Constants
      *===============================================================*
      *
     D cNONE           C                   const('*NONE')
     D cCLP            C                   const('CLP')
     D cSQL            C                   const('SQL')
     D cBeginSQL       C                   const('/EXEC SQL')
     D cEndSQL         C                   const('/END-EXEC')
      *
      *===============================================================*
      *  Global Fields
      *===============================================================*
     D g_isSqlOpn      S                   like(bool_t    ) inz(cFalse)
      *
      *===============================================================*
      *  Global Input Variables
      *===============================================================*
      *
     D gi_qFile        S                   like(qObj_t    )
     D gi_mbr          S                   like(mbr_t     )
     D gi_strSeq       S                   like(srcSeq_t  )
     D gi_endSeq       S                   like(srcSeq_t  )
     D gi_xLib         S                   like(lib_t     )
     D gi_xObj         S                   like(obj_t     )
     D gi_xTypeCode    S                   like(typecode_t)
     D gi_xSrcLib      S                   like(lib_t     )
     D gi_xSrcFile     S                   like(file_t    )
     D gi_xSrcMbr      S                   like(mbr_t     )
     D gi_xTestLib     S                   like(lib_t     )
     D gi_xTestObj     S                   like(obj_t     )
     D gi_xTgtRls      S                   like(tgtRls_t  )
     D gi_xFrmSrcLib   S                   like(lib_t     )
     D gi_xFrmSrcFile  S                   like(file_t    )
     D gi_xFrmSrcMbr   S                   like(mbr_t     )
     D gi_xUser0       S                   like(userdef_t )
     D gi_xUser1       S                   like(userdef_t )
     D gi_xUser2       S                   like(userdef_t )
     D gi_xUser3       S                   like(userdef_t )
     D gi_xUser4       S                   like(userdef_t )
     D gi_xUser5       S                   like(userdef_t )
     D gi_xUser6       S                   like(userdef_t )
     D gi_xUser7       S                   like(userdef_t )
     D gi_xUser8       S                   like(userdef_t )
     D gi_xUser9       S                   like(userdef_t )
     D gi_xMsgF        S                   like(msg_t_file)
     D gi_xNaming      S                   like(naming_t  )
      *
     D xNaming         S                   like(gi_xNaming)
      *
      *===============================================================*
      *  Main Stream
      *===============================================================*
     C     *ENTRY        Plist
     C                   Parm                    gi_qFile
     C                   Parm                    gi_mbr
     C                   Parm                    gi_strSeq
     C                   Parm                    gi_endSeq
     C                   Parm                    gi_xLib
     C                   Parm                    gi_xObj
     C                   Parm                    gi_xTypeCode
     C                   Parm                    gi_xSrcLib
     C                   Parm                    gi_xSrcFile
     C                   Parm                    gi_xSrcMbr
     C                   Parm                    gi_xTestLib
     C                   Parm                    gi_xTestObj
     C                   Parm                    gi_xTgtRls
     C                   Parm                    gi_xFrmSrcLib
     C                   Parm                    gi_xFrmSrcFile
     C                   Parm                    gi_xFrmSrcMbr
     C                   Parm                    gi_xUser0
     C                   Parm                    gi_xUser1
     C                   Parm                    gi_xUser2
     C                   Parm                    gi_xUser3
     C                   Parm                    gi_xUser4
     C                   Parm                    gi_xUser5
     C                   Parm                    gi_xUser6
     C                   Parm                    gi_xUser7
     C                   Parm                    gi_xUser8
     C                   Parm                    gi_xUser9
     C                   Parm                    gi_xMsgF
     C                   Parm                    gi_xNaming
      *
     C                   If        %addr(gi_xNaming) = *NULL
     C                   Eval      xNaming = '*SYS'
     C                   Else
     C                   Eval      xNaming = gi_xNaming
     C                   Endif
      *
     C                   Callp     CEERTX(%paddr('P_ABNENDPROC') :
     C                                    *null                  :
     C                                    *omit                  )
      *
     C                   Callp     p_main(gi_qFile    : gi_mbr     :
     C                                    gi_strSeq   : gi_endSeq  :
     C                                    gi_xLib     : gi_xObj    :
     C                                    gi_xTypeCode             :
     C                                    gi_xSrcLib  : gi_xSrcFile:
     C                                    gi_xSrcMbr               :
     C                                    gi_xTestLib : gi_xTestObj:
     C                                    gi_xTgtRls               :
     C                                    gi_xFrmSrcLib            :
     C                                    gi_xFrmSrcFile           :
     C                                    gi_xFrmSrcMbr            :
     C                                    gi_xUser0                :
     C                                    gi_xUser1                :
     C                                    gi_xUser2                :
     C                                    gi_xUser3                :
     C                                    gi_xUser4                :
     C                                    gi_xUser5                :
     C                                    gi_xUser6                :
     C                                    gi_xUser7                :
     C                                    gi_xUser8                :
     C                                    gi_xUser9                :
     C                                    gi_xMsgF                 :
     C                                    xNaming                  )
      *
     C                   Callp     CEEUTX(%paddr('P_ABNENDPROC') :
     C                                    *omit                  )
      *
     C                   Eval      *inlr = *on
      *
      *===============================================================*
      *  Main Procedure
      *===============================================================*
     P p_main...
     P                 B
      *
     D p_main...
     D                 PI
     D  i_qFile                            value like(qObj_t    )
     D  i_mbr                              value like(mbr_t     )
     D  i_strSeq                           value like(srcSeq_t  )
     D  i_endSeq                           value like(srcSeq_t  )
     D  i_xLib                             value like(lib_t     )
     D  i_xObj                             value like(obj_t     )
     D  i_xTypeCode                        value like(typecode_t)
     D  i_xSrcLib                          value like(lib_t     )
     D  i_xSrcFile                         value like(file_t    )
     D  i_xSrcMbr                          value like(mbr_t     )
     D  i_xTestLib                         value like(lib_t     )
     D  i_xTestObj                         value like(obj_t     )
     D  i_xTgtRls                          value like(tgtRls_t  )
     D  i_xFrmSrcLib                       value like(lib_t     )
     D  i_xFrmSrcFile                      value like(file_t    )
     D  i_xFrmSrcMbr                       value like(mbr_t     )
     D  i_xUser0                           value like(userdef_t )
     D  i_xUser1                           value like(userdef_t )
     D  i_xUser2                           value like(userdef_t )
     D  i_xUser3                           value like(userdef_t )
     D  i_xUser4                           value like(userdef_t )
     D  i_xUser5                           value like(userdef_t )
     D  i_xUser6                           value like(userdef_t )
     D  i_xUser7                           value like(userdef_t )
     D  i_xUser8                           value like(userdef_t )
     D  i_xUser9                           value like(userdef_t )
     D  i_xMsgF                            value like(msg_t_file)
     D  i_xNaming                          value like(naming_t  )
      *
     D cmdString       S                   like(capcmd_t  )
     D                                     inz
     D errMsg        E DS                  extname(XDMSG     )  inz
     D                                     prefix(errMsg_    )
      *
     D rplVarData      DS                  likeds(rplVarData_t) inz
      *
     D qFile         E DS                  extname(XDQOBJ    )  inz
     D                                     prefix(qFile_     )
     D clCmdString     S            256A
     D diagMsg       E DS                  extname(XDMSG     )  inz
     D                                     prefix(diagMsg_   )
     D mode            S             10A   inz
     D srcSeq          S                   like(srcSeq_t  ) inz
     D cmdToken        S                   like(cmdToken_t)
     D errCode       E DS                  extname(xderrcode )  inz
     D                                     prefix(errCode_   )
      *
      *---------------------------------------------------------------
      *
     C                   Eval      qFile = i_qFile
      *
      *  Laden Werte für Ersatzvariablen
     C                   Eval      rplVarData.xLib        = i_xLib
     C                   Eval      rplVarData.xObj        = i_xObj
     C                   Eval      rplVarData.xTypeCode   = i_xTypeCode
     C                   Eval      rplVarData.xSrcLib     = i_xSrcLib
     C                   Eval      rplVarData.xSrcFile    = i_xSrcFile
     C                   Eval      rplVarData.xSrcMbr     = i_xSrcMbr
     C                   Eval      rplVarData.xTestLib    = i_xTestLib
     C                   Eval      rplVarData.xTestObj    = i_xTestObj
     C                   Eval      rplVarData.xTgtRls     = i_xTgtRls
     C                   Eval      rplVarData.xFrmSrcLib  = i_xFrmSrcLib
     C                   Eval      rplVarData.xFrmSrcFile = i_xFrmSrcFile
     C                   Eval      rplVarData.xFrmSrcMbr  = i_xFrmSrcMbr
     C                   Eval      rplVarData.xUser0      = i_xUser0
     C                   Eval      rplVarData.xUser1      = i_xUser1
     C                   Eval      rplVarData.xUser2      = i_xUser2
     C                   Eval      rplVarData.xUser3      = i_xUser3
     C                   Eval      rplVarData.xUser4      = i_xUser4
     C                   Eval      rplVarData.xUser5      = i_xUser5
     C                   Eval      rplVarData.xUser6      = i_xUser6
     C                   Eval      rplVarData.xUser7      = i_xUser7
     C                   Eval      rplVarData.xUser8      = i_xUser8
     C                   Eval      rplVarData.xUser9      = i_xUser9
      *
      *  Setzen der Nachrichtendatei
     C                   Callp     p_setMsgFile(i_xMsgF: '*LIBL')
      *
      *  Wenn die Bibliothek nicht existiert, ...
     C                   If        (qFile_lib <> '*LIBL  ') and
     C                             (qFile_lib <> '*CURLIB')
     C                   If        not f_exist(qFile_lib  : *omit     :
     C                                         '*LIB'     : *omit     : errMsg)
      *  ... dann
      *      beenden mit Fehlermeldung
     C                   Callp     p_endPgmAbn(errMsg)
     C                   Endif
     C                   Endif
      *
      *  Wenn die Datei nicht existiert, ...
     C                   If        not f_exist(qFile_name : qFile_lib :
     C                                         '*FILE'    : *omit     : errMsg)
      *  ... dann
      *      beenden mit Fehlermeldung
     C                   Callp     p_endPgmAbn(errMsg)
     C                   Endif
      *
      *  Wenn die Teildatei nicht existiert, ...
     C                   If        not f_exist(qFile_name : qFile_lib :
     C                                         '*FILE'   : i_mbr      : errMsg)
      *  ... dann
      *      beenden mit Fehlermeldung
     C                   Callp     p_endPgmAbn(errMsg)
     C                   Endif
      *
      *  Wenn die Datei nicht überschreiben werden kann, ...
     C                   Eval      clCmdString = 'OVRDBF FILE('    +
     C                                           'SCRIPT'          +
     C                                           ') '              +
     C                                           'TOFILE('         +
     C                                           %trim(qFile_lib)  +
     C                                           '/'               +
     C                                           %trim(qFile_name) +
     C                                           ') '              +
     C                                           'MBR('            +
     C                                           %trim(i_mbr)      +
     C                                           ') '              +
     C                                           'OVRSCOPE('       +
     C                                           '*ACTGRPDFN'      +
     C                                           ')'
     C                   If        not f_execute(clCmdString: errMsg)
      *      ... dann
      *          beenden mit Fehlermeldung
     C                   Callp     p_endPgmAbn(errMsg)
     C                   Endif
      *
      *  Setzen Betriebsmodus ...
     C                   Eval      mode = cCLP
      *
      *  Lesen und verarbeiten Skript ...
     C                   Open      SCRIPT
     C                   Eval      errCode = f_newErrCode(cErr_NoMonErr)
     C                   Callp     p_rmvPgmMsg('*': 0: '':'*ALL': errCode)
      *
     C                   DoW       f_getCmd(cmdString: i_strSeq: i_endSeq)
      *
      *  Entfernen Remarks ...
     C                   Eval      cmdString = f_rmvRemCl(cmdString)
     C                   If        %trim(cmdString) = ''
     C                   Iter
     C                   Endif
      *
      *  Überlesen MONMSG ...
     C                   Callp     f_rtvCmdToken(cmdString :
     C                                           cmdToken  )
     C                   If        f_ucase(cmdToken) = 'MONMSG'
     C                   Iter
     C                   Endif
      *
      *  Überlesen PGM ...
     C                   Callp     f_rtvCmdToken(cmdString :
     C                                           cmdToken  )
     C                   If        f_ucase(cmdToken) = 'PGM'
     C                   Iter
     C                   Endif
      *
      *  Überlesen DCL ...
     C                   Callp     f_rtvCmdToken(cmdString :
     C                                           cmdToken  )
     C                   If        f_ucase(cmdToken) = 'DCL'
     C                   Iter
     C                   Endif
      *
      *  Überlesen ENDPGM ...
     C                   Callp     f_rtvCmdToken(cmdString :
     C                                           cmdToken  )
     C                   If        f_ucase(cmdToken) = 'ENDPGM'
     C                   Iter
     C                   Endif
      *
      *  Prüfen Betriebsartenumschaltung auf ...
      *  ... starten SQL
     C                   If        cmdString = cBeginSQL
      *      Wenn die Betriebsart SQL bereits eingestellt ist, ...
     C                   If        mode = cSQL
      *      ... dann
      *          ausgeben Diagnose Nachricht
     C                   Clear                   USR0002
     C                   Eval      USR00021 = ds_srcSeq
     C                   Eval      USR00022 = cmdString
     C                   Eval      diagMsg  = f_newMsg('USR0002'      :
     C                                                 cMsg_TypDiag   :
     C                                                 USR0002        )
     C                   Callp     p_sndPgmMsg(diagMsg       :
     C                                         cMsg_Prv      :
     C                                         cMsg_ToCtlBdy )
      *          beenden mit Fehlermeldung
     C                   Clear                   USR0003
     C                   Eval      USR00031 = cSQL
     C                   Eval      USR00032 = cBeginSQL
     C                   Eval      USR00033 = cEndSQL
     C                   Eval      errMsg   = f_newMsg('USR0003'      :
     C                                                 cMsg_TypEscape :
     C                                                 USR0003        )
     C                   Callp     p_endPgmAbn(errMsg)
     C                   Else
      *      ... sonst
      *          umschalten auf SQL-Modus
     C                   Eval      mode = cSQL
     C                   Iter
     C                   Endif
     C                   Endif
      *
      *  ... beenden SQL
     C                   If        cmdString = cEndSQL
      *      Wenn die Betriebsart CLP bereits eingestellt ist, ...
     C                   If        mode = cCLP
      *      ... dann
      *          ausgeben Diagnose Nachricht
     C                   Clear                   USR0002
     C                   Eval      USR00021 = ds_srcSeq
     C                   Eval      USR00022 = cmdString
     C                   Eval      diagMsg  = f_newMsg('USR0002'      :
     C                                                 cMsg_TypDiag   :
     C                                                 USR0002        )
     C                   Callp     p_sndPgmMsg(diagMsg       :
     C                                         cMsg_Prv      :
     C                                         cMsg_ToCtlBdy )
      *          beenden mit Fehlermeldung
     C                   Clear                   USR0004
     C                   Eval      USR00041 = cCLP
     C                   Eval      USR00042 = cEndSQL
     C                   Eval      USR00043 = cBeginSQL
     C                   Eval      errMsg   = f_newMsg('USR0004'      :
     C                                                 cMsg_TypEscape :
     C                                                 USR0004        )
     C                   Callp     p_endPgmAbn(errMsg)
     C                   Else
      *      ... sonst
      *          umschalten auf SQL-Modus
     C                   Eval      mode = cCLP
     C                   Iter
     C                   Endif
     C                   Endif
      *
      *  Ersetzen Variablen ...
     C                   Eval      cmdString = f_rplVars(cmdString: rplVarData)
      *
      *  Ausführen ...
     C                   Select
      *  ... CL-Befehl
     C                   When      mode = cCLP
     C                   Eval      srcSeq = ds_srcSeq
     C                   If        not f_execute(cmdString: errMsg)  and
     C                             not f_monMsg(errMsg_ID : i_strSeq: i_endSeq:
     C                                          rplVarData)
      *      ... dann
      *          ausgeben Diagnose-Nachricht
     C                   Clear                   USR0002
     C                   Eval      USR00021 = srcSeq
     C                   Eval      USR00022 = cmdString
     C                   Eval      diagMsg  = f_newMsg('USR0002'      :
     C                                                 cMsg_TypDiag   :
     C                                                 USR0002        )
     C                   Callp     p_sndPgmMsg(diagMsg       :
     C                                         cMsg_Prv      :
     C                                         cMsg_ToCtlBdy )
      *          beenden mit Fehlermeldung
     C                   Callp     p_endPgmAbn(errMsg)
     C                   Endif
      *  ... SQL-Anweisung
     C                   When      mode = cSQL
     C                   Eval      srcSeq = ds_srcSeq
     C                   If        not g_isSqlOpn and
     C                             not f_opnSql(i_xNaming: diagMsg)
     C                   Eval      g_isSqlOpn = cFalse
      *          senden Diagnose Nachricht
     C                   Eval      diagMsg  = f_newMsg(diagMsg_ID     :
     C                                                 cMsg_TypDiag   :
     C                                                 diagMsg_data   )
     C                   Callp     p_sndPgmMsg(diagMsg       :
     C                                         cMsg_Prv      :
     C                                         cMsg_ToCtlBdy )
      *          beenden mit Fehlermeldung
     C                   Callp     p_endPgmAbn(errMsg)
     C                   Else
     C                   Eval      g_isSqlOpn = cTrue
     C                   Endif
      *
     C                   If        not f_executeSQL(cmdString: errMsg) and
     C                             not f_monMsg(errMsg_ID   : i_strSeq:i_endSeq:
     C                                          rplVarData)
      *      ... dann
      *          ausgeben Diagnose-Nachricht
     C                   Clear                   USR0002
     C                   Eval      USR00021 = srcSeq
     C                   Eval      USR00022 = cmdString
     C                   Eval      diagMsg  = f_newMsg('USR0002'      :
     C                                                 cMsg_TypDiag   :
     C                                                 USR0002        )
     C                   Callp     p_sndPgmMsg(diagMsg       :
     C                                         cMsg_Prv      :
     C                                         cMsg_ToCtlBdy )
      *          beenden mit Fehlermeldung
     C                   Eval      errMsg = f_newMsg('CPF9898'      :
     C                                               cMsg_TypEscape :
     C                                               errMsg_data    :
     C                                               'QCPFMSG'      :
     C                                               '*LIBL'        )
     C                   Callp     p_endPgmAbn(errMsg)
     C                   Endif
      *  ... ungültiger Modus
     C                   Other
     C                   Endsl
      *
     C                   Enddo
      *
     C                   Close     SCRIPT
      *
     C                   If        g_isSqlOpn
     C                   Callp     p_cloSql
     C                   Eval      g_isSqlOpn = cFalse
     C                   Endif
      *
      *  Wenn die Überschreibungen nicht gelöscht werden können, ...
     C                   Eval      clCmdString = 'DLTOVR FILE(' +
     C                                           'SCRIPT'       +
     C                                           ') '           +
     C                                           'LVL('         +
     C                                           '*ACTGRPDFN'   +
     C                                           ')'
      *
     C                   If        not f_execute(clCmdString: errMsg)
      *  ... dann
      *      beenden mit Fehlermeldung
     C                   Callp     p_endPgmAbn(errMsg)
     C                   Endif
      *
     C                   Return
      *
     P p_main...
     P                 E
      *
      *===============================================================*
      *  Get Command From CL-Script
      *===============================================================*
     P f_getCmd...
     P                 B
      *
     D f_getCmd...
     D                 PI                        like(bool_t        )
     D  io_cmdString                             like(capcmd_t      )
     D  i_strSeq                           value like(srcSeq_t      )
     D  i_endSeq                           value like(srcSeq_t      )
      *
     D concat          S              1A   inz
      *
     D isOK            S                   like(bool_t    ) inz(cFalse)
     D cmdString       S          32767A   varying          inz
      *
      *---------------------------------------------------------------
      *
      *  Initialisierung
     C                   Eval      cmdString = ''
     C                   Eval      concat    = '+'
      *
     C                   Eval      isOK = cTrue
      *
      *  Lesen, bis das Ende des Befehls erreicht wird ...
     C                   Do        *HIVAL
     C                   Read      SCRIPT        ds_script
     C                   If        %eof(SCRIPT)
     C                   Eval      isOK = cFalse
     C                   Leave
     C                   Endif
      *
      *  ... lesen, bis Endezeile erreicht ist
     C                   If        ds_srcSeq > i_endSeq
     C                   Iter
     C                   Endif
      *
      *  ... überlesen, bis Startzeile gefunden ist
     C                   If        ds_srcSeq < i_strSeq
     C                   Iter
     C                   Endif
      *
      *  ... zusammenbauen Befehl
     C                   Select
     C                   When      concat = '+'
     C                   Eval      cmdString = cmdString + %triml(ds_srcDta)
     C                   When      concat = '-'
     C                   Eval      cmdString = cmdString + ds_srcDta
     C                   Other
    R ***
     C                   Endsl
      *
      *  ... prüfen auf Fortsetzungszeile
     C                   Eval      cmdString = %trimr(cmdString)
      *
      *  ... prüfen auf Leerstring
     C                   If        %len(cmdString) = 0
     C                   Iter
     C                   Endif
      *
     C                   Select
     C                   When      f_right(cmdString: 1) = '+'
     C                   Eval      concat = '+'
     C                   When      f_right(cmdString: 1) = '-'
     C                   Eval      concat = '-'
     C                   Other
     C                   Eval      concat = ' '
     C                   Endsl
      *
      *  ... Wenn keine Fortsetzungszeile erwartet wird, ...
     C                   If        concat = ' '
      *      ... dann
      *          beenden Verarbeitung
     C                   Leave
     C                   Else
      *      ... sonst
      *          abschneiden Fortsetzungszeichen
     C                   Eval      cmdString = %subst(cmdString: 1:
     C                                                %len(cmdString) - 1)
     C                   Endif
      *
     C                   Enddo
      *
     C                   Eval      io_cmdString = %triml(cmdString)
      *
     C                   Return    isOK
      *
     P f_getCmd...
     P                 E
      *
      *===============================================================*
      *  Replace variables
      *===============================================================*
     P p_replace...
     P                 B
      *
     D p_replace...
     D                 PI
     D  io_string                                 like(capcmd_t  )
     D  i_var                        10A   value
     D  i_value                     256A   value
      *
     D x               S                   like(int4_t    )
     D                                     inz
      *---------------------------------------------------------------
      *
     C                   Eval      x = 0
      *
     C                   DoU       x = 0
      *
     C                   If        x > 0
     C                   Eval      io_string = %replace(%trim(i_value)    :
     C                                                  io_string         :
     C                                                  x                 :
     C                                                  %len(%trim(i_var)))
     C                   Endif
      *
     C                   Eval      x = %scan(%trim(i_var) :
     C                                       io_string    )
     C                   Enddo
      *
     C                   Return
      *
     P p_replace...
     P                 E
      *
      *===============================================================*
      *  Monitor Message
      *===============================================================*
     P f_monMsg...
     P                 B
      *
     D f_monMsg...
     D                 PI                         like(bool_t    )
     D  i_msgID                            value  like(msg_t_id  )
     D  i_strSeq                           value like(srcSeq_t  )
     D  i_endSeq                           value like(srcSeq_t  )
     D  i_rplVarData                       value likeds(rplVarData_t)
      *
      *  Deklarieren Funktionswert
     D isMonitored     S                   like(bool_t    ) inz(cFalse)
      *
      *  Arbeitsfelder
     D cmdString       S                         like(capcmd_t  )
     D msgIdStr        S                         like(capcmd_t  )
     D cmdToken        S                         like(cmdToken_t)
     D x               S                         like(int4_t    )
     D pToken          S               *   inz
      *---------------------------------------------------------------
      *
      *  Vorbelegen "isMonitored" mit "Nein"
     C                   Eval      isMonitored = cFalse
      *
     C                   DoW       f_getCmd(cmdString: i_strSeq: i_endSeq)
      *
      *  Entfernen Remarks ...
     C                   Eval      cmdString = f_rmvRemCl(cmdString)
     C                   If        %trim(cmdString) = ''
     C                   Iter
     C                   Endif
      *
      *  Ersetzen Variablen
     C                   Eval      cmdString = f_rplVars(cmdString   :
     C                                                   i_rplVarData)
      *
     C                   Eval      cmdString = %trim(cmdString)
      *
     C                   If        (cmdString = cBeginSQL) or
     C                             (cmdString = cEndSQL  )
     C                   Leave
     C                   Endif
      *
     C                   Eval      cmdString = f_fmtCmd(cmdString)
     C                   Callp     f_rtvCmdToken(cmdString: cmdToken)
     C                   If        cmdToken <> 'MONMSG'
     C                   Leave
     C                   Endif
      *
     C                   If        f_rtvCmdParm(cmdString: msgIdStr)
      *
      *  Extrahieren Daten des Schlüsselworts MSGID
     C                   Eval      msgIdStr =
     C                             f_rtvKeyWrdDta(f_rtvKeyWrd('MSGID':msgIdStr))
      *
     C                   If        msgIdStr <> ''
     C                   Eval      pToken = f_getToken(msgIdStr: ' ')
      *
     C                   Dow       (pToken      <> *null )  and
     C                             (isMonitored =  cFalse)
     C                   If        f_cmpMonMsgId(%str(pToken): i_msgId)
     C                   Eval      isMonitored = cTrue
     C                   Endif
     C                   Eval      pToken = f_getToken(*null: ' ')
     C                   Enddo
      *
     C                   Endif
     C                   Endif
      *
     C                   If        isMonitored
     C                   Leave
     C                   Endif
     C                   Enddo
      *
     C                   Return    isMonitored
      *
     P f_monMsg...
     P                 E
      *
      *===============================================================*
      *  Ermitteln Befehls-Token (OS/400 Befehl)
      *===============================================================*
     P f_rtvCmdToken...
     P                 B
      *
     D f_rtvCmdToken...
     D                 PI                         like(bool_t    )
     D  i_cmdString                        value  like(capcmd_t  )
     D  o_cmdToken                                like(cmdToken_t)
      *
      *  Deklarieren Funktionswert
     D isToken         S                   like(bool_t    ) inz
      *
      *  Arbeitsfelder
     D x               S                   like(int4_t    ) inz
     D cmdString       S                   like(capcmd_t  ) inz
     D cmdToken        S                   like(cmdToken_t) inz
      *---------------------------------------------------------------
      *
     C                   Eval      cmdString = %triml(i_cmdString)
      *
     C                   Eval      x = %scan(' ': cmdString)
     C                   Eval      x = x - 1
      *
     C                   If        (x >  %len(cmdToken))  or
     C                             (x <= 0               )
     C                   Eval      isToken = cFalse
     C                   Else
     C                   Eval      cmdToken = %subst(cmdString: 1: x)
     C                   If        f_right(%trimr(cmdToken): 1) = ':'
     C                   Eval      isToken = cFalse
     C                   Else
     C                   Eval      isToken = cTrue
     C                   Endif
     C                   Endif
      *
     C                   If        isToken
     C                   Eval      o_cmdToken = cmdToken
     C                   Else
     C                   Eval      o_cmdToken = ' '
     C                   Endif
      *
     C                   Return    isToken
      *
     P f_rtvCmdToken...
     P                 E
      *
      *===============================================================*
      *  Ermitteln Befehls-Parameter
      *===============================================================*
     P f_rtvCmdParm...
     P                 B
      *
     D f_rtvCmdParm...
     D                 PI                         like(bool_t    )
     D  i_cmdString                        value  like(capcmd_t  )
     D  o_cmdParm                                 like(capcmd_t  )
      *
      *  Deklarieren Funktionswert
     D isParm          S                   like(bool_t    ) inz
      *
      *  Arbeitsfelder
     D x               S                   like(int4_t    ) inz
     D cmdString       S                   like(capcmd_t  ) inz
      *---------------------------------------------------------------
      *
     C                   Eval      cmdString = %triml(i_cmdString)
      *
     C                   Eval      x = %scan(' ': cmdString)
      *
     C                   If        (x >  %len(o_cmdParm))  or
     C                             (x <= 0            )
     C                   Eval      o_cmdParm = ''
     C                   Eval      isParm  = cFalse
     C                   Else
     C                   Eval      o_cmdParm = %triml(%subst(cmdString: x))
     C                   Eval      isParm  = cTrue
     C                   Endif
      *
     C                   Return    isParm
      *
     P f_rtvCmdParm...
     P                 E
      *
      * =============================================================
      *  Extrahieren Befehlsschlüsselwort
      * =============================================================
     P f_rtvKeyWrd...
     P                 B
      *
     D f_rtvKeyWrd...
     D                 PI                         like(capcmd_t  )
     D  i_keyWrd                     10A   value
     D  i_cmd                              value  like(capcmd_t  )
      *
      *  Funktionswert
     D keyWrdStr       S                   like(capcmd_t  ) inz
      *
      *  Arbeitsfelder
     D startPos        S                   like(int4_t    ) inz
     D dataLen         S                   like(int4_t    )  inz
     D x               S                   like(int4_t    )  inz
     D y               S                   like(int4_t    )  inz
     D token           S             11A   varying           inz
     D endPos          S                   like(int4_t    )  inz
     D numBracket      S                   like(int4_t    )  inz
      * - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
      *
     C                   Eval      token = %trim(i_keyWrd) + '('
      *
      *  suchen Schlüsselwort im vorhandenen Befehlstring
     C                   Eval      startPos = %scan(token: i_cmd)
      *
      *  Wenn das Schlüsselwort gefunden werden konnte, ...
     C                   If        startPos > 0
      *  ... dann
      *      ermitteln Länge des Schlüsselwortes ...
     C                   Eval      x          = startPos + %len(token)
     C                   Eval      numBracket = 1
     C                   Eval      dataLen    = %len(token)
     C                   Eval      endPos     = %len(%trimr(i_cmd))
      *
     C     x             Do        endPos        y
      *
     C                   Eval      DataLen = DataLen + 1
      *      ... '('
     C                   If        %subst(i_cmd: y: 1) = '('
     C                   Eval      numBracket = numBracket + 1
     C                   Iter
     C                   Endif
      *      ... ')'
     C                   If        %subst(i_cmd: y: 1) = ')'
     C                   Eval      numBracket = numBracket - 1
     C                   Iter
     C                   Endif
      *      ... gefunden
     C                   If        numBracket <= 0
     C                   Leave
     C                   Endif
      *
     C                   Enddo
      *
      *      Wenn der Klammernzähler <> 0 ist, ...
     C                   If        numBracket <> 0
      *      ... dann
      *          konnte das Ende des Schlüsselwortes
      *          nicht gefunden werden
     C                   Eval      keyWrdStr = ''
     C                   Else
     C                   Eval      keyWrdStr = %subst(i_cmd: startPos: dataLen)
     C                   Endif
      *
     C                   Else
     C                   Eval      keyWrdStr = ''
     C                   Endif
      *
     C                   Return    keyWrdStr
      *
     P f_rtvKeyWrd...
     P                 E
      *
      * =============================================================
      *  Extrahieren Befehlsschlüsselwort Daten
      * =============================================================
     P f_rtvKeyWrdDta...
     P                 B
      *
     D f_rtvKeyWrdDta...
     D                 PI                         like(capcmd_t  )
     D  i_keyWrd                           value  like(capcmd_t  )
      *
      *  Funktionswert
     D keyWrdDta       S                   like(capcmd_t  ) inz
      *
      *  Arbeitsfelder
     D startPos        S                   like(int4_t    ) inz
     D dataLen         S                   like(int4_t    )  inz
     D x               S                   like(int4_t    )  inz
     D y               S                   like(int4_t    )  inz
     D token           S             11A   varying           inz
     D endPos          S                   like(int4_t    )  inz
     D numBracket      S                   like(int4_t    )  inz
      * - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
      *
     C                   Eval      token = '('
      *
      *  suchen Schlüsselwortdaten im vorhandenen Befehlstring
     C                   Eval      startPos = %scan(token: i_keyWrd)
      *
      *  Wenn das Schlüsselwort gefunden werden konnte, ...
     C                   If        (startPos > 0)  and
     C                             (f_right(%trimr(i_keyWrd): 1) = ')')
      *  ... dann
      *      ermitteln Länge des Schlüsselwortes ...
     C                   Eval      startPos   = startPos + %len(token)
     C                   Eval      endPos     = %len(%trimr(i_keyWrd)) - 1
     C                   Eval      dataLen    = endPos - startPos + 1
      *
     C                   Eval      keyWrdDta =
     C                                       %subst(i_keyWrd: startPos: dataLen)
     C                   Else
     C                   Eval      keyWrdDta = ''
     C                   Endif
      *
     C                   Return    keyWrdDta
      *
     P f_rtvKeyWrdDta...
     P                 E
      *
      * =============================================================
      *  Konvertieren in Grossbuchstaben
      * =============================================================
     P f_ucase...
     P                 B
      *
     D f_ucase...
     D                 PI          2048A
     D  i_lower                    2048A   value
      *
      *  Funktionswert
     D upper           S           2048A   inz
      *
      *  Konvertierungstabellen
     D lc              C                   const('abcdefghijklmnopqrstuvwxyz')
     D uc              C                   const('ABCDEFGHIJKLMNOPQRSTUVWXYZ')
      * - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
      *
     C     lc:uc         Xlate     i_lower       upper
      *
     C                   Return    upper
      *
     P f_ucase...
     P                 E
      *
      * =============================================================
      *  Ersetzen Variablen
      * =============================================================
     P f_rplVars...
     P                 B
      *
     D f_rplVars...
     D                 PI                        like(capcmd_t      )
     D  i_cmdString                        value like(capcmd_t      )
     D  i_rplVarData                       value likeds(rplVarData_t)
      *
      *  Funktionswert
     D cmdString       S                   like(capcmd_t  ) inz
      * - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
      *
     C                   Eval      cmdString = i_cmdString
      *
      *  Ersetzen Lib         (&LI)
     C                   If        i_rplVarData.xLib <> cNONE
     C                   Callp     p_replace(cmdString:
     C                                       '&LI': i_rplVarData.xLib)
     C                   Endif
      *
      *  Ersetzen Objekt      (&OB)
     C                   If        i_rplVarData.xObj <> cNONE
     C                   Callp     p_replace(cmdString:
     C                                       '&OB': i_rplVarData.xObj)
     C                   Endif
      *
      *  Ersetzen Type Code   (&TY)
     C                   If        i_rplVarData.xTypeCode <> cNONE
     C                   Callp     p_replace(cmdString:
     C                                       '&TY': i_rplVarData.xTypeCode)
     C                   Endif
      *
      *  Ersetzen Source Lib  (&SL)
     C                   If        i_rplVarData.xSrcLib <> cNONE
     C                   Callp     p_replace(cmdString:
     C                                       '&SL': i_rplVarData.xSrcLib)
     C                   Endif
      *
      *  Ersetzen Source File (&SF)
     C                   If        i_rplVarData.xSrcFile <> cNONE
     C                   Callp     p_replace(cmdString:
     C                                       '&SF': i_rplVarData.xSrcFile)
     C                   Endif
      *
      *  Ersetzen Source Mbr  (&SM)
     C                   If        i_rplVarData.xSrcMbr <> cNONE
     C                   Callp     p_replace(cmdString:
     C                                       '&SM': i_rplVarData.xSrcMbr)
     C                   Endif
      *
      *  Ersetzen Test Lib    (&TL)
     C                   If        i_rplVarData.xTestLib <> cNONE
     C                   Callp     p_replace(cmdString:
     C                                       '&TL': i_rplVarData.xTestLib)
     C                   Endif
      *
      *  Ersetzen Test Object (&TO)
     C                   If        i_rplVarData.xTestObj <> cNONE
     C                   Callp     p_replace(cmdString:
     C                                       '&TO': i_rplVarData.xTestObj)
     C                   Endif
      *
      *  Ersetzen Taget Rel.  (&TO)
     C                   If        i_rplVarData.xTgtRls <> cNONE
     C                   Callp     p_replace(cmdString:
     C                                       '&TR': i_rplVarData.xTgtRls)
     C                   Endif
      *
      *  Ersetzen From Src Lib  (&SL)
     C                   If        i_rplVarData.xFrmSrcLib <> cNONE
     C                   Callp     p_replace(cmdString:
     C                                       '&FL': i_rplVarData.xFrmSrcLib)
     C                   Endif
      *
      *  Ersetzen From Src File (&SF)
     C                   If        i_rplVarData.xFrmSrcFile <> cNONE
     C                   Callp     p_replace(cmdString:
     C                                       '&FF': i_rplVarData.xFrmSrcFile)
     C                   Endif
      *
      *  Ersetzen From Src Mbr  (&SM)
     C                   If        i_rplVarData.xFrmSrcMbr <> cNONE
     C                   Callp     p_replace(cmdString:
     C                                       '&FM': i_rplVarData.xFrmSrcMbr)
     C                   Endif
      *
      *  Ersetzen Parameter  (&USER0)
     C                   If        i_rplVarData.xUser0 <> cNONE
     C                   Callp     p_replace(cmdString:
     C                                       '&U0': i_rplVarData.xUser0)
     C                   Endif
      *
      *  Ersetzen Parameter  (&USER1)
     C                   If        i_rplVarData.xUser1 <> cNONE
     C                   Callp     p_replace(cmdString:
     C                                       '&U1': i_rplVarData.xUser1)
     C                   Endif
      *
      *  Ersetzen Parameter  (&USER2)
     C                   If        i_rplVarData.xUser2 <> cNONE
     C                   Callp     p_replace(cmdString:
     C                                       '&U2': i_rplVarData.xUser2)
     C                   Endif
      *
      *  Ersetzen Parameter  (&USER3)
     C                   If        i_rplVarData.xUser3 <> cNONE
     C                   Callp     p_replace(cmdString:
     C                                       '&U3': i_rplVarData.xUser3)
     C                   Endif
      *
      *  Ersetzen Parameter  (&USER4)
     C                   If        i_rplVarData.xUser4 <> cNONE
     C                   Callp     p_replace(cmdString:
     C                                       '&U4': i_rplVarData.xUser4)
     C                   Endif
      *
      *  Ersetzen Parameter  (&USER5)
     C                   If        i_rplVarData.xUser5 <> cNONE
     C                   Callp     p_replace(cmdString:
     C                                       '&U5': i_rplVarData.xUser5)
     C                   Endif
      *
      *  Ersetzen Parameter  (&USER6)
     C                   If        i_rplVarData.xUser6 <> cNONE
     C                   Callp     p_replace(cmdString:
     C                                       '&U6': i_rplVarData.xUser6)
     C                   Endif
      *
      *  Ersetzen Parameter  (&USER7)
     C                   If        i_rplVarData.xUser7 <> cNONE
     C                   Callp     p_replace(cmdString:
     C                                       '&U7': i_rplVarData.xUser7)
     C                   Endif
      *
      *  Ersetzen Parameter  (&USER8)
     C                   If        i_rplVarData.xUser8 <> cNONE
     C                   Callp     p_replace(cmdString:
     C                                       '&U8': i_rplVarData.xUser8)
     C                   Endif
      *
      *  Ersetzen Parameter  (&USER9)
     C                   If        i_rplVarData.xUser9 <> cNONE
     C                   Callp     p_replace(cmdString:
     C                                       '&U9': i_rplVarData.xUser9)
     C                   Endif
      *
     C                   Return    cmdString
      *
     P f_rplVars...
     P                 E
      *
      * =============================================================
      *  Abnormal End Procedure
      * =============================================================
     P p_abnEndProc...
     P                 B
      *
     D p_abnEndProc...
     D                 PI
     D  i_token                        *   const
      * - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
      *
     C                   If        g_isSqlOpn
     C                   Callp     p_cloSql
     C                   Eval      g_isSqlOpn = cFalse
     C                   Endif
      *
     C                   Return
      *
     P p_abnEndProc...
     P                 E
      *
