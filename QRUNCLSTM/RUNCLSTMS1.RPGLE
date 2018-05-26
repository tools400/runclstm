      * =================================================================== *
      *                                                                     *
      *  Kurzdokumentation :                                                *
      *                                                                     *
      *  Bereich . . . : RUNCLSTM                                           *
      *  Objekt  . . . : RUNCLSTMS1                                         *
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
     H NOMAIN
      /COPY QRUNCLSTM,COPYRIGHT
      * =================================================================== *
      *
      /COPY QRUNCLSTM,RUNCLSTMG3
      *
     D cBegClRem       C                   const('/*')
     D cLenBegClRem    C                   const(2)
     D cEndClRem       C                   const('*/')
     D cLenEndClRem    C                   const(2)
      *
     D cBegLit         C                   const('''')
     D cLenBegLit      C                   const(1)
     D cEndLit         C                   const('''')
     D cLenEndLit      C                   const(1)
      *
      *===============================================================*
      *  Nachrichten
      *===============================================================*
      /COPY QRUNCLSTM,USR0001
      *
      *===============================================================*
      *  Public Prototypes
      *===============================================================*
      /COPY QRUNCLSTM,RUNCLSTMG1
      /COPY QRUNCLSTM,RUNCLSTMG2
      *
      *===============================================================*
      *  Private Prototypes
      *===============================================================*
     D f_subst...
     D                 PR         32767A   varying
     D  str                       32767A   value varying
     D  pos                                value like(int4_t    )
     D  lenToken                           value like(int4_t    )
      *
      *  global variables
     D g_msgF          S                   like(msg_t_file)
     D g_msgFLib       S                   like(msg_t_lib )
      *===============================================================*
      *  Get Command From CL-Script
      *===============================================================*
     P f_execute...
     P                 B                   export
      *
     D f_execute...
     D                 PI                  opdesc like(bool_t    )
     D  i_cmd                              const  like(capcmd_t  )
     D                                     options(*varsize)
     D  o_msg                                     like(msg_t     )
     D                                     options(*nopass: *omit)
     D  i_typCmdPrc                        const  like(int4_t    )
     D                                     options(*nopass)
      *
      *  Definieren Funktionswert
     D isOK            S                   like(bool_t    )
     D                                     inz
      *
      *  Definieren Hilfsfelder für optinale Parametergruppe 1
     D  o1_msg         S                   like(msg_t     )
     D                                     inz
      *
      *  Definieren Hilfsfelder für optinale Parametergruppe 2
     D  i2_typCmdPrc   S             10I 0 inz
      *
      *  Definieren Parameter für p_getOpDesc
     D posNr           S                   inz like(int4_t    )
     D descType        S                   inz like(int4_t    )
     D datatype        S                   inz like(int4_t    )
     D descInf1        S                   inz like(int4_t    )
     D descInf2        S                   inz like(int4_t    )
     D dataLen         S                   inz like(int4_t    )
     D feedBack        S                   inz like(fc_t      )
      *
      *  Definitionen für QCAPCMD
     D cmd             S                   like(i_cmd)
     D cmdLen          S             10I 0 inz
     D optCtrl         DS
     D  typCmdPrc              1      4B 0 inz
     D  DBCS_Data              5      5A   inz('0')                             ignore DBCS
     D  prmt_Act               6      6A   inz('2')                             selective prom
     D  cmdStrSntx             7      7A   inz('0')                             AS/400 Syntax
     D  msgRtvKey              8     11A   inz(*BLANKS)                         no retrieve ke
     D  res_01                12     20A   inz(*ALLx'00')
     D optCtrlLen      S             10I 0 inz(%len(OptCtrl))
     D optCtrlFmt      S              8A   inz('CPOP0100')
     D retCmd          S                   like(i_cmd)
     D                                     inz
     D retCmdLenAvl    S             10I 0 inz
     D retCmdLenRtn    S             10I 0 inz
     D errCode         S                   like(errCode_t  )
     D                                     inz
      *
      *  Hilfsfelder für Funktion: p_TestOmit
     D isPresent       S                   like(int4_t      )
     D                                     inz
      *
      *---------------------------------------------------------------
      *
     C                   Callp     p_getOpDesc(1: descType: dataType:
     C                                            descInf1: descInf2:
     C                                            dataLen:  feedBack)
      *
     C                   Eval      cmd          = %subst(i_cmd: 1: dataLen)
     C                   Eval      cmdLen       = %len(cmd)
     C                   Eval      retCmd       = ''
     C                   Eval      retCmdLenAvl = %len(retCmd)
      *
     C                   If        %parms >= 2
     C                   Eval      errCode = f_newErrCode(cErr_MonErr)
     C                   Else
     C                   Eval      errCode = f_newErrCode(cErr_NoMonErr)
     C                   Endif
      *
     C                   Eval      i2_typCmdPrc = 2
      *
     C                   If        %parms >= 3
     C                   CallP     p_TestOmit(isPresent: 3: *omit)
     C                   If        isPresent = 1
     C                   Eval      i2_typCmdPrc = i_typCmdPrc
     C                   Endif
     C                   Endif
      *
     C                   Call  (E) 'QCAPCMD'
     C                   Parm                    cmd
     C                   Parm                    cmdLen
     C                   Parm                    optCtrl
     C                   Parm                    optCtrlLen
     C                   Parm                    optCtrlFmt
     C                   Parm                    retCmd
     C                   Parm                    retCmdLenAvl
     C                   Parm                    retCmdLenRtn
     C                   Parm                    errCode
      *
     C                   Eval      o1_msg = f_getAPIErrMsg(errCode)
      *
      *  eintragen Rückgabeparameter ...
     C                   If        %parms >= 2
     C                   Eval      o_msg = o1_msg
     C                   Endif
      *
      *  füllen Funktionswert ...
     C                   If        f_isAPIErr(errCode)
     C                   Eval      isOK = cFalse
     C                   Else
     C                   Eval      isOK = cTrue
     C                   Endif
      *
     C                   Return    isOK
      *
     P f_execute...
     P                 E
      *
      *===============================================================*
      *  Create New Error Code
      *===============================================================*
     P f_newErrCode...
     P                 B                   export
      *
      *  Definieren Procedure Interface
     D f_newErrCode...
     D                 PI                         like(errCode_t  )
     D  i_monErr                           value  like(bool_t    )
      *
      *  Definieren Funktionswert
     D errCode       E DS                  extname(XDERRCODE )  inz
     D                                     prefix(errCode_   )
      *
      *  Definieren lokale Arbeitsfelder
      *-------------------------------------------------------------------*
      *
     C                   Clear                   errCode
      *
     C                   If        (i_monErr = cTrue)
     C                   Eval      errCode_bytPrv = %size(errCode)
     C                   Else
     C                   Eval      errCode_bytPrv = 0
     C                   Endif
      *
     C                   Return    errCode
      *
     P f_newErrCode...
     P                 E
      *
      *===============================================================*
      *  Prozedur:  f_getAPIErrMsg
      *===============================================================*
     P f_getAPIErrMsg...
     P                 B                   export
      *
      *  Definieren Procedure Interface
     D f_getAPIErrMsg...
     D                 PI                         like(msg_t     )
     D  i_errCode                          value  like(errCode_t )
      *
      *  Definieren Funktionswert
     D apiErrMsg       S                   like(msg_t     )  inz
      *
      *  Definieren lokale Arbeitsfelder
     D errCode       E DS                  extname(XDERRCODE  ) inz
     D                                     prefix(errCode_    )
      *-------------------------------------------------------------------*
      *
      *  ermöglichen Zugriff auf Einzelfelder von i_errCode
     C                   Eval      errCode = i_errCode
      *
     C                   If        f_isAPIErr(errCode)
     C                   Eval      apiErrMsg = f_newMsg(errCode_excID  :
     C                                                  cMsg_TypEscape :
     C                                                  errCode_excDta :
     C                                                  'QCPFMSG'      :
     C                                                  '*LIBL'        )
     C                   Else
     C                   Eval      apiErrMsg = f_newMsg(' ')
     C                   Endif
      *
     C                   Return    apiErrMsg
      *
     P f_getAPIErrMsg...
     P                 E
      *
      *===============================================================*
      *  Test for API error
      *===============================================================*
     P f_isAPIErr...
     P                 B                   export
      *
      *  Definieren Procedure Interface
     D f_isAPIErr...
     D                 PI                         like(bool_t    )
     D  i_errCode                          value  like(errCode_t )
      *
      *  Definieren Funktionswert
     D isAPIErr        S                   like(msg_t     )  inz
      *
      *  Definieren lokale Arbeitsfelder
     D errCode       E DS                  extname(XDERRCODE  )  inz
     D                                     prefix(errCode_    )
      *-------------------------------------------------------------------*
      *
      *  ermöglichen Zugriff auf Einzelfelder von i_errCode
     C                   Eval      errCode = i_errCode
      *
     C                   If        errCode_bytAvl <> 0
     C                   Eval      isAPIErr = cTrue
     C                   Else
     C                   Eval      isAPIErr = cFalse
     C                   Endif
      *
     C                   Return    isAPIErr
      *
     P f_isAPIErr...
     P                 E
      *
      *===============================================================*
      *  Prozedur:  f_newMsg
      *===============================================================*
     P f_newMsg...
     P                 B                   export
      *
     D f_newMsg...
     D                 PI                         like(msg_t     )
     D  i_msgID                            value  like(msg_t_ID  )
      * optionale Parametergruppe 1
     D  i_msgType                          value  like(msg_t_type)
     D                                     options(*NOPASS)
      * optionale Parametergruppe 2
     D  i_msgData                          const like(msg_t_data)
     D                                     options(*NOPASS: *OMIT)
      * optionale Parametergruppe 3
     D  i_msgF                             value like(msg_t_file )
     D                                     options(*NOPASS)
      * optionale Parametergruppe 4
     D  i_msgL                             value like(msg_t_lib  )
     D                                     options(*NOPASS)
      *
      *  Definieren Funktionswert
     D msg           E DS                  extname(XDMSG     )  inz
     D                                     prefix(msg_       )
      *
      *  Hilfsfelder für optionale Parametergruppe 1
     D i1_msgType      S                   like(i_msgType )
     D                                     inz
      *
      *  Hilfsfelder für optionale Parametergruppe 2
     D i2_msgData      S                   like(I_MsgData )
     D                                     inz
      *
      *  Hilfsfelder für optionale Parametergruppe 3
     D i3_msgF         S                   like(I_MsgF    )
     D                                     inz
      *
      *  Hilfsfelder für optionale Parametergruppe 4
     D i4_msgL         S                   like(I_MsgL    )
     D                                     inz
      *
      *  Hilfsfelder für Funktion: p_TestOmit
     D isPresent       S                   like(int4_t    )
     D                                     inz
      *-------------------------------------------------------------------*
      *
      *  ... MsgType
     C                   IF        (%parms < 2)
     C                   Eval      i1_msgType = '*INFO'
     C                   ELSE
     C                   Eval      i1_msgType = i_msgType
     C                   Endif
      *
      *  ... MsgData
      *
     C                   IF        (%parms < 3)
     C                   Eval      I2_MsgData = ' '
     C                   ELSE
     C                   CallP     p_TestOmit(isPresent: 3: *omit)
     C                   IF        (isPresent = 0)
     C                   Eval      I2_MsgData = ' '
     C                   ELSE
     C                   Eval      I2_MsgData = I_MsgData
     C                   Endif
     C                   Endif
      *
      *  ... MsgF
     C                   IF        (%parms < 4)
     C                   Eval      I3_MsgF   = f_getMsgFile
     C                   ELSE
     C                   Eval      I3_MsgF   = I_MsgF
     C                   Endif
      *
      *  ... MsgL
     C                   IF        (%parms < 5)
     C                   Eval      I4_MsgL   = f_getMsgFileLib
     C                   ELSE
     C                   Eval      I4_MsgL   = I_MsgL
     C                   Endif
      *
      *  Erstellen Nachricht ...
     C                   Clear                   msg
      *
     C                   If        i_msgID <> ''
      *  ... MsgID
     C                   Eval      msg_ID   = i_msgID
      *  ... MsgType
     C                   Eval      msg_type = i1_msgType
      *  ... MsgData
     C                   Eval      msg_data = i2_msgData
      *  ... MsgF
     C                   Eval      msg_file = i3_msgF
      *  ... MsgL
     C                   Eval      msg_lib  = i4_msgL
     C                   Endif
      *
     C                   Return    msg
      *
     P f_newMsg...
     P                 E
      *
      *===============================================================*
      *  Extract from the right side of a string
      *===============================================================*
     P f_right...
     P                 B                          export
      *
      *  Definieren Procedure Interface
     D f_right...
     D                 PI         32767A   varying
     D  i_str                     32767A   value
     D                                     varying
     D  i_rLen                             value  like(int4_t)
     D                                     options(*nopass )
      *
      *  Definieren Funktionswert
     D rightStr        S                   like(string_t  )
     D                                     inz
      *
      *  Definieren Hilfsfelder für optinale Parametergruppe 1
     D i1_rLen         S                   like(int4_t    )
     D                                     inz
      *
      *  Lokale Hilfsfelder
     D errMsg        E DS                  extname(xdmsg     )  inz
     D                                     prefix(errMsg_    )
      *-------------------------------------------------------------------*
      *
     C                   If        %parms >= 2
     C                   Eval      i1_rLen = i_rLen
     C                   Else
     C                   Eval      i1_rLen = %len(i_str)
     C                   Endif
      *
     C                   If        %len(i_str) - i1_rLen >= 0
     C                   Eval      rightStr = %subst(i_str:
     C                                             %len(i_str) - i1_rLen + 1)
     C                   Else
     C                   Eval      errMsg = f_newMsg('USR0001'      :
     C                                               cMsg_TypEscape )
     C                   Callp     p_endPgmAbn(errMsg)
     C                   Endif
      *
     C                   Return    rightStr
      *
     P f_right...
     P                 E
      *
      *===============================================================*
      *  Remove Remarks from CL String
      *===============================================================*
     P f_rmvRemCl...
     P                 B                          export
      *
      *  Definieren Procedure Interface
     D f_rmvRemCl...
     D                 PI         32767A          varying
     D  i_clStr                   32767A   value
     D                                     varying
      *
      *  Definieren Funktionswert
     D newClStr        S          32767A   varying
     D                                     inz('')
      *
      *  Lokale Arbeitsfelder
     D testChr         S          32767A   varying
     D                                     inz('')
     D isClRem         S                   like(bool_t    )
     D                                     inz(cFalse)
     D isLiteral       S                   like(bool_t    )
     D                                     inz(cFalse)
     D x               S                   like(int4_t    )
     D                                     inz
      *-------------------------------------------------------------------*
      *
     C                   Eval      x = 1
     C                   Eval      newClStr = %trim(i_clStr)
      *
     C                   DoW       x < %len(newClStr)
      *
      *  Wenn wir uns nicht innerhalb eines Remark befinden, ...
     C                   If        not isClRem
      *  ... dann
      *      Prüfen auf Anfang Literalzeichen
     C                   If        f_subst(newClStr: x: cLenBegLit) = cBegLit
     C                   Eval      isLiteral = cTrue
     C                   Eval      x = x + cLenBegLit
     C                   Iter
     C                   Endif
      *
      *      Prüfen auf Ende Literalzeichen
     C                   If        f_subst(newClStr: x: cLenEndLit) = cEndLit
     C                   Eval      isLiteral = cTrue
     C                   Eval      x = x + cLenEndLit
     C                   Iter
     C                   Endif
     C                   Endif
      *
      *  Wenn wir uns nicht innerhalb eines Literals befinden, ...
     C                   If        not isLiteral
      *  ... dann
      *      Prüfen auf Anfang eines Remarks
     C                   If        f_subst(newClStr: x: cLenBegClRem)= cBegClRem
     C                   If        (x = 1) or
     C                             (%subst(newClStr: x - 1: 1) = ' ')
     C                   Eval      isClRem = cTrue
     C                   Eval      %subst(newClStr: x: cLenBegClRem) = ''
     C                   Eval      x = x + cLenBegClRem
     C                   Iter
     C                   Endif
     C                   Endif
      *
      *      Prüfen auf Ende eines Remarks
     C                   If        f_subst(newClStr: x: cLenEndClRem)= cEndClRem
     C                   If        (x = %len(newClStr) - cLenEndClRem + 1) or
     C                             (%subst(newClStr: x + cLenEndClRem: 1) = ' ')
     C                   Eval      isClRem = cFalse
     C                   Eval      %subst(newClStr: x: cLenEndClRem) = ''
     C                   Eval      x = x + cLenEndClRem
     C                   Iter
     C                   Endif
     C                   Endif
     C                   Endif
      *
      *  ... ausblenden Remarks
     C                   If        isClRem
     C                   Eval      %subst(newClStr: x: 1) = ''
     C                   Endif
      *
     C                   Eval      x = x + 1
     C                   Enddo
      *
     C                   Return    %trim(newClStr)
      *
     P f_rmvRemCl...
     P                 E
      *
      * =============================================================
      *  Formatieren CL Befehl
      * =============================================================
     P f_fmtCmd...
     P                 B                   export
      *
     D f_fmtCmd...
     D                 PI                         like(capcmd_t  )
     D  i_cmd                              value  like(capcmd_t  )
      *
      *  Definitionen für QCAPCMD
     D cmd             S                   like(i_cmd)
     D cmdLen          S             10I 0 inz(%len(cmd))
     D optCtrl         DS
     D  typCmdPrc              1      4B 0 inz(4)                               cl commands
     D  DBCS_Data              5      5A   inz('1')                             handle DBCS
     D  prmt_Act               6      6A   inz('0')                             never prompt
     D  cmdStrSntx             7      7A   inz('0')                             AS/400 Syntax
     D  msgRtvKey              8     11A   inz(*BLANKS)                         no retrieve ke
     D  res_01                12     20A   inz(*ALLx'00')
     D optCtrlLen      S             10I 0 inz(%len(OptCtrl))
     D optCtrlFmt      S              8A   inz('CPOP0100')
     D retCmd          S                   like(i_cmd) inz
     D retCmdLenAvl    S             10I 0 inz(%len(retCmd))
     D retCmdLenRtn    S             10I 0 inz
     D errCode         DS
     D  errBytPrv                    10I 0 inz(%size(errCode))
     D  errBytAvl                    10I 0 inz
     D  errID                         7A   inz
     D  errRes01                      1A   inz
     D  errDta                      256A   inz
      * - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
     C                   Reset                   errCode
      *
     C                   Eval      cmd          = i_cmd
      *
     C                   Call  (E) 'QCAPCMD'
     C                   Parm                    cmd
     C                   Parm                    cmdLen
     C                   Parm                    optCtrl
     C                   Parm                    optCtrlLen
     C                   Parm                    optCtrlFmt
     C                   Parm                    retCmd
     C                   Parm                    retCmdLenAvl
     C                   Parm                    retCmdLenRtn
     C                   Parm                    errCode
      *
      *  Prüfen API-Fehler ...
     C                   If        f_isAPIErr(errCode)
     C                   Eval      retCmd = ''
     C                   Else
      *
      *  Prüfen Länge der Befehlszeichenkette ...
     C                   If        retCmdLenRtn > retCmdLenAvl
     C                   Eval      retCmd = ''
     C                   Endif
     C                   Endif
      *
     C                   Return    retCmd
      *
     P f_fmtCmd...
     P                 E
      *
      *===============================================================*
      *  End Program Abnormal
      *===============================================================*
     P p_endPgmAbn...
     P                 B                          export
      *
      *  Definieren Procedure Interface
     D p_endPgmAbn...
     D                 PI
     D  i_msg                              value  like(msg_t     )
      *-------------------------------------------------------------------*
      *
     C                   Callp     p_sndPgmMsg(i_msg         :
     C                                         cMsg_Prv      :
     C                                         cMsg_ToCtlBdy )
      *
     C                   Return
      *
     P p_endPgmAbn...
     P                 E
      *
      *===============================================================*
      *  Compare generic Message IDs
      *===============================================================*
     P f_cmpMonMsgID...
     P                 B                          export
      *
      *  Definieren Procedure Interface
     D f_cmpMonMsgID...
     D                 PI                         like(bool_t    )
     D  i_msgId                            value  like(msg_t_ID  )
     D  i_monMsgId                         value  like(msg_t_ID  )
      *
      *  Definieren Funktionswert
     D isEqual         S                   like(bool_t    ) inz(cFalse)
      *-------------------------------------------------------------------*
      *
     C                   If        %subst(i_msgId: 6: 2) = '00'
     C                   Eval      %subst(i_monMsgId: 6: 2) = '00'
     C                   If        %subst(i_msgId: 4: 2) = '00'
     C                   Eval      %subst(i_monMsgId: 4: 2) = '00'
     C                   Endif
     C                   Endif
      *
     C                   If        i_monMsgId = i_msgId
     C                   Eval      isEqual = cTrue
     C                   Else
     C                   Eval      isEqual = cFalse
     C                   Endif
      *
     C                   Return    isEqual
      *
     P f_cmpMonMsgID...
     P                 E
      *
      *===============================================================*
      *  Prozedur:  p_sndPgmMsg
      *===============================================================*
     P p_sndPgmMsg...
     P                 B                   export
      *
     D p_sndPgmMsg...
     D                 PI
     D  i_msg                              value  like(msg_t     )
      * optionale Parametergruppe 1
     D  i_toStkC                           value like(int4_t    )
     D                                     options(*NOPASS)
      * optionale Parametergruppe 2
     D  i_toProc                           value like(proc_t    )
     D                                     options(*NOPASS)
      * optionale Parametergruppe 3
     D  i_toMod                            const like(mod_t     )
     D                                     options(*NOPASS: *OMIT)
      * optionale Parametergruppe 4
     D  i_toPgm                            value like(pgm_t     )
     D                                     options(*NOPASS)
      *
      *  Zerlegung Eingangsparameter I_Msg in Einzelfelder
     D msg           E DS                  extname(XDMSG     )  inz
     D                                     prefix(msg_       )
      *
      *  Hilfsfelder für optionale Parametergruppe 1
     D I1_ToStkC       S                   like(I_ToStkC)     INZ(*ZEROS )
      *
      *  Hilfsfelder für optionale Parametergruppe 2
     D I2_ToProc       S                   like(I_ToProc    ) INZ(*BLANKS)
      *
      *  Hilfsfelder für optionale Parametergruppe 3
     D I3_ToMod        S                   like(I_ToMod   )   INZ(*ZEROS )
      *
      *  Hilfsfelder für optionale Parametergruppe 4
     D I4_ToPgm        S                   like(I_ToPgm)      INZ(*BLANKS)
      *
      *  Hilfsfelder für System-API: CEETSTA
     D isPresent       S                   like(int4_t)       INZ(*ZEROS)
      *
      *  Parameterfelder für System-API: QMHSNDPM
     D p1_MsgID        S              7A                      INZ(*BLANKS)
     D p1_DSMsgFObj    DS            20
     D  p1_DSMsgF              1     10A                      INZ(*BLANKS)
     D  p1_DSMsgL             11     20A                      INZ(*BLANKS)
     D p1_MsgData      S                   like(msg_data  )   INZ(*BLANKS)
     D p1_LenMsgData   S                   like(int4_t  )     INZ(*ZEROS )
     D p1_MsgType      S             10A                      INZ(*BLANKS)
     D p1_CallStkE     S                   like(I_ToProc    ) INZ(*BLANKS)
     D p1_CallStkCtr   S                   like(int4_t  )     INZ(*BLANKS)
     D p1_MsgKey       S              4A                      INZ(*BLANKS)
     D p1_ErrCode    E DS                  EXTNAME(XDERRCODE)  PREFIX(p1_) INZ
      * Optional Parameter Group 1
     D p1_LenCallStkE  S                   like(int4_t)       INZ(*ZEROS )
     D p1_CallStkEQ    DS            20
     D  p1_CallStkEQM          1     10A                      INZ(*BLANKS)
     D  p1_CallStkEQP         11     20A                      INZ(*BLANKS)
     D p1_WaitTime     S                   like(int4_t)       INZ(*ZEROS )
      *-------------------------------------------------------------------*
      *
      *  Ermöglichen Zugriff auf Einzelfelder ...
     C                   Eval      msg = i_msg
      *
      *  Einsetzen der Defaultwerte ...
      *  ... Stackcounter
     C                   If        %parms < 2
     C                   Eval      i1_toStkC = cMsg_Same
     C                   Else
     C                   Eval      i1_toStkC = i_toStkC
     C                   Endif
      *
      *  ... an Prozedur
     C                   If        (%parms < 3)
     C                   Eval      i2_toProc     = cMsg_toMySelf
     C                   Else
     C                   Eval      i2_toProc  = i_toProc
     C                   Endif
      *
      *  ... an Modul
     C                   If        %parms < 4
     C                   Eval      i3_toMod   = '*NONE'
     C                   Else
     C                   Callp     p_TestOmit(isPresent: 4 : *omit)
     C                   If        (isPresent = cCEE_isNotPresent)
     C                   Eval      i3_toMod   = '*NONE'
     C                   Else
     C                   Eval      I3_toMod   = i_toMod
     C                   Endif
     C                   Endif
      *
      *  ... an Programm
     C                   IF        %parms < 5
     C                   Eval      i4_toPgm   = '*NONE'
     C                   ELSE
     C                   Eval      i4_toPgm   = i_toPgm
     C                   Endif
      *
      *  Füllen Parameterfelder für System-API ...
      *  Call Stack Counter ...
     C                   Select
      *  ... *EXT
     C                   When      i1_ToStkC     = cMsg_Ext
     C                   Eval      p1_callStkCtr = 0
     C                   Eval      i2_toProc     = '*EXT'
      *  ... *PERVIOUS
     C                   When      i1_toStkC     = cMsg_Prv
     C                   Eval      p1_callStkCtr = 1
      *  ... *SAME
     C                   When      i1_toStkC     = cMsg_Same
     C                   Eval      p1_callStkCtr = 0
      *  ... sonst
     C                   Other
     C                   Eval      p1_callStkCtr = 0
     C                   Endsl
      *
      *  An Prozedur ...
     C                   Select
      *  ... *
     C                   When      i2_toProc     = cMsg_toMySelf
     C                   Eval      p1_callStkE   = '*'
      *      ... eigene Prozedur SndPgmMsg überspringen
     C                   Eval      p1_callStkCtr = p1_callStkCtr + 1
      *  ... *PGMBDY
     C                   When      i2_toProc     = cMsg_ToPgmBdy
     C                   Eval      p1_callStkE   = '*PGMBDY'
      *  ... *CTLBDY
     C                   When      i2_toProc     = cMsg_ToCtlBdy
     C                   Eval      p1_callStkE   = '*CTLBDY'
      *  ... *PGMNAME
     C                   When      i2_toProc     = cMsg_ToPgm
     C                   Eval      p1_callStkE   = '*PGMNAME'
      *  ... *EXT
     C                   When      i2_toProc     = '*EXT'
     C                   Eval      p1_callStkE   = '*EXT'
      *  ... benannte Prozedur
     C                   Other
     C                   Eval      p1_callStkE   = i2_toProc
     C                   Endsl
      *
      *  An Modul ...
     C                   Eval      p1_CallStkEQM = i3_toMod
      *
      *  An Programm ...
     C                   Eval      p1_callStkEQP = i4_toPgm
      *
      *  Nachrichten ...
     C                   Eval      p1_msgID       = msg_ID
     C                   Eval      p1_msgData     = msg_data
     C                   Eval      p1_lenMsgData  = %size(p1_msgData)
      *
     C                   Select
      *  ... Anwendung-Information
     C                   When      msg_type = cMsg_AppInfo
     C                   Eval      p1_msgType     = cMsg_TypInfo
      *  ... Anwendung-Warnung
     C                   When      msg_type = cMsg_AppWarning
     C                   Eval      p1_msgType     = cMsg_TypInfo
      *  ... Anwendung-Fehler
     C                   When      msg_type = cMsg_AppError
     C                   Eval      p1_msgType     = cMsg_TypInfo
     C                   Other
     C                   Eval      p1_msgType     = msg_type
     C                   Endsl
      *
     C                   Eval      p1_DSMsgF      = msg_file
     C                   Eval      p1_DSMsgL      = msg_lib
      *
      *  Nachrichtenschlüssel ...
     C                   Eval      p1_msgKey      = ''
      *  Fehlercode ...
     C                   Eval      p1_errCode     = f_newErrCode(cErr_NoMonErr)
      *
      *  Sonstige Parameter ...
     C                   Eval      p1_lenCallStkE = %size(p1_CallStkE)
     C                   Eval      p1_waitTime    = -1
      *
     C                   Call      'QMHSNDPM'
     C                   Parm                    p1_MsgID
     C                   Parm                    p1_DSMsgFObj
     C                   Parm                    p1_MsgData
     C                   Parm                    p1_LenMsgData
     C                   Parm                    p1_MsgType
     C                   Parm                    p1_CallStkE
     C                   Parm                    p1_CallStkCtr
     C                   Parm                    p1_MsgKey
     C                   Parm                    p1_ErrCode
     C                   Parm                    p1_LenCallStkE
     C                   Parm                    p1_CallStkEQ
     C                   Parm                    p1_WaitTime
      *
     C                   Return
      *
     P p_sndPgmMsg...
     P                 E
      *
      *===============================================================*
      *  test if an object exist
      *===============================================================*
     P f_exist...
     P                 B                          export
      *
      *  Definieren Procedure Interface
     D f_exist...
     D                 PI                         like(bool_t    )
     D  i_obj                              const  like(obj_t     )
     D  i_lib                              const  like(lib_t     )
     D                                     options(*omit)
     D  i_objType                          const  like(objType_t )
     D  i_mbr                              const  like(mbr_t     )
     D                                     options(*omit)
     D  o_msg                                     like(msg_t     )
     D                                     options(*nopass)
      *
      *  Definieren Funktionswert
     D isOK            S                   like(bool_t    )
     D                                     inz
      *
      *  Definieren Hilfsfelder für optinale Parametergruppe 1
     D  i1_lib         S                   like(lib_t     )
     D                                     inz
      *
      *  Definieren Hilfsfelder für optinale Parametergruppe 2
     D  i2_mbr         S                   like(mbr_t     )
     D                                     inz
      *
      *  Hilfsfelder für Funktion: p_TestOmit
     D isPresent       S                   like(int4_t      ) INZ(*ZEROS)
      *
      *  Lokale Arbeitsfelder
     D cmdStr          S            256A   inz
     D errMsg        E DS                  extname(XDMSG     )  inz
     D                                     prefix(errMsg_    )
      *
      *-------------------------------------------------------------------*
      *
     C                   Callp     p_TestOmit(isPresent: 2 : *omit)
     C                   If        (isPresent = cCEE_isNotPresent)
     C                   Eval      i1_lib = '*LIBL'
     C                   Else
     C                   Eval      i1_lib = i_lib
     C                   Endif
      *
     C                   Callp     p_TestOmit(isPresent: 4 : *omit)
     C                   If        (isPresent = cCEE_isNotPresent)
     C                   Eval      i2_mbr = '*NONE'
     C                   Else
     C                   Eval      i2_mbr = i_mbr
     C                   Endif
      *
     C                   Eval      cmdStr    = 'CHKOBJ OBJ('    +
     C                                         %trim(i1_lib)    +
     C                                         '/'              +
     C                                         %trim(i_obj)     +
     C                                         ') '             +
     C                                         'OBJTYPE('       +
     C                                         %trim(i_objtype) +
     C                                         ') '             +
     C                                         'MBR('           +
     C                                         %trim(i2_mbr)    +
     C                                         ') '
      *
     C                   If        not f_execute(cmdStr    :
     C                                           errMsg    )
     C                   Eval      isOK = cFalse
     C                   Else
     C                   Eval      isOK = cTrue
     C                   Endif
      *
     C                   If        %parms >= 5
     C                   Eval      o_msg = errMsg
     C                   Endif
      *
     C                   Return    isOK
      *
     P f_exist...
     P                 E
      *
      *===============================================================*
      *  Set Message file
      *===============================================================*
     P p_setMsgFile...
     P                 B                   export
      *
      *  Definieren Procedure Interface
     D p_setMsgFile...
     D                 PI
     D  i_msgF                             value like(msg_t_file)
     D  i_msgFLib                          value like(msg_t_lib )
      *-------------------------------------------------------------------*
      *
     C                   Eval      g_msgF    = i_msgF
     C                   Eval      g_msgFLib = i_msgFLib
      *
     P p_setMsgFile...
     P                 E
      *
      *===============================================================*
      *  Get Message file
      *===============================================================*
     P f_getMsgFile...
     P                 B                   export
      *
      *  Definieren Procedure Interface
     D f_getMsgFile...
     D                 PI                        like(msg_t_file)
      *
      *  Definieren Funktionswert
     D o_msgF          S                   like(msg_t_file) inz
      *-------------------------------------------------------------------*
      *
     C                   Eval      o_msgF    = g_msgF
      *
     C                   Return    o_msgF
      *
     P f_getMsgFile...
     P                 E
      *
      *===============================================================*
      *  Get Message file library
      *===============================================================*
     P f_getMsgFileLib...
     P                 B                   export
      *
      *  Definieren Procedure Interface
     D f_getMsgFileLib...
     D                 PI                        like(msg_t_lib )
      *
      *  Definieren Funktionswert
     D o_msgFLib       S                   like(msg_t_lib ) inz
      *-------------------------------------------------------------------*
      *
     C                   Eval      o_msgFLib = g_msgFLib
      *
     C                   Return    o_msgFLib
      *
     P f_getMsgFileLib...
     P                 E
      *
      *===============================================================*
      *  Private:
      *  Get token from string
      *===============================================================*
     P f_subst...
     P                 B
      *
      *  Definieren Procedure Interface
     D f_subst...
     D                 PI         32767A   varying
     D  str                       32767A   value varying
     D  pos                                value like(int4_t    )
     D  lenToken                           value like(int4_t    )
      *
      *  Definieren Funktionswert
     D token           S          32767A   varying
     D                                     inz('')
      *-------------------------------------------------------------------*
      *
     C                   If        pos + lenToken - 1 <= %len(str)
     C                   Return    %subst(str: pos: lenToken)
     C                   Else
     C                   Return    ''
     C                   Endif
      *
     P f_subst...
     P                 E
      *
