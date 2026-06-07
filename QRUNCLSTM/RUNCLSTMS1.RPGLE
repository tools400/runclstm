**free
// =================================================================== *
//                                                                     *
//  Kurzdokumentation :                                                *
//                                                                     *
//  Bereich . . . : RUNCLSTM                                           *
//  Objekt  . . . : RUNCLSTMS1                                         *
//  Beschreibung  : Tool: RUNCLSTM   (Run CL Statements         )      *
//  Author  . . . : Thomas Raddatz   <thomas.raddatz@tools400.de>      *
//  Datum . . . . : 03.08.2000                                         *
//                                                                     *
// =================================================================== *
//                                                                     *
//  This software is free software, you can redistribute it and/or     *
//  modify it under the terms of the GNU General Public License (GPL)  *
//  as published by the Free Software Foundation.                      *
//                                                                     *
//  See GNU General Public License for details.                        *
//          http://www.opensource.org                                  *
//          http://www.opensource.org/licenses/gpl-license.html        *
//                                                                     *
//=====================================================================*
//  History:                                                           *
//                                                                     *
//  Datum       Name          Änderung                                 *
//  ----------  ------------  ---------------------------------------  *
//                                                                     *
// =================================================================== *
// >>PRE-COMPILER<<                                                    *
//                                                                     *
//   >>CRTCMD<< CRTRPGMOD    MODULE(&LI/&OB) +                         *
//                           SRCFILE(&SL/&SF) +                        *
//                           SRCMBR(&SM);                              *
//                                                                     *
//   >>COMPILE<<                                                       *
//     >>PARM<< TRUNCNBR(*NO);                                         *
//     >>PARM<< DBGVIEW(*LIST);                                        *
//   >>END-COMPILE<<                                                   *
//                                                                     *
//   >>EXECUTE<<                                                       *
//                                                                     *
// >>END-PRE-COMPILER<<                                                *
// =================================================================== *
ctl-opt nomain;
/copy QRUNCLSTM,COPYRIGHT
// =================================================================== *

/copy QRUNCLSTM,RUNCLSTMG3

dcl-c cBegClRem '/*';
dcl-c cLenBegClRem 2;
dcl-c cEndClRem '*/';
dcl-c cLenEndClRem 2;

dcl-c cBegLit '''';
dcl-c cLenBegLit 1;
dcl-c cEndLit '''';
dcl-c cLenEndLit 1;

//===============================================================*
//  Nachrichten
//===============================================================*
/copy QRUNCLSTM,USR0001

//===============================================================*
//  Public Prototypes
//===============================================================*
/copy QRUNCLSTM,RUNCLSTMG1
/copy QRUNCLSTM,RUNCLSTMG2

//===============================================================*
//  Private Prototypes
//===============================================================*
dcl-pr f_subst varchar(32767);
  str      varchar(32767) value;
  pos      like(int4_t) value;
  lenToken like(int4_t) value;
end-pr;

//  global variables
dcl-s g_msgF like(msg_t.file);
dcl-s g_msgFLib like(msg_t.lib);

//  Process Commands (QCAPCMD) API
dcl-pr QCAPCMD extpgm('QCAPCMD');
  i_cmd         char(32702) options(*varsize) const;
  i_cmdLen      int(10) const;
  i_ctrlBlk     char(32767) options(*varsize) const;
  i_ctrlBlkLen  int(10) const;
  i_ctrlBlkFmt  char(8) const;
  o_chgCmd      char(32702) options(*varsize);
  i_chgCmdLnPrv int(10) const;
  o_chgCmdLnAvl int(10);
  io_errorCode  char(32767) options(*varsize);
end-pr;

//  Send Program Message (QMHSNDPM) API
dcl-pr qmhsndpm extpgm('QMHSNDPM');
  i_msgid      char(7) const;
  i_qmsgf      char(20) const;
  i_msgdata    char(32767) options(*varsize) const;
  i_length     int(10) const;
  i_msgtype    char(10) const;
  i_callstke   char(256) const;
  i_callstkc   int(10) const;
  o_msgkey     char(4);
  io_errcode   char(32767) options(*varsize);
  i_lenstke    int(10) options(*nopass) const; // optGrp 1
  i_callstkeq  char(20) options(*nopass) const;
  i_wait       int(10) options(*nopass) const;
  i_callstkedt char(10) options(*nopass) const; // optGrp 2
  i_ccsid      int(10) options(*nopass) const;
end-pr;

//===============================================================*
//  Get Command From CL-Script
//===============================================================*
dcl-proc f_execute export;
  dcl-pi *n opdesc like(bool_t);
    i_cmd       like(capcmd_t) options(*varsize) const;
    o_msg       likeds(msg_t) options(*nopass: *omit);
    i_typCmdPrc like(int4_t) options(*nopass) const;
  end-pi;

  //  Definieren Funktionswert
  dcl-s isOK like(bool_t) inz;

  //  Definieren Hilfsfelder für optinale Parametergruppe 1
  dcl-s o1_msg like(msg_t) inz;

  //  Definieren Hilfsfelder für optinale Parametergruppe 2
  dcl-s i2_typCmdPrc int(10) inz;

  //  Definieren Parameter für p_getOpDesc
  dcl-s descType inz like(int4_t);
  dcl-s datatype inz like(int4_t);
  dcl-s descInf1 inz like(int4_t);
  dcl-s descInf2 inz like(int4_t);
  dcl-s dataLen inz like(int4_t);
  dcl-s feedBack inz like(fc_t);

  //  Definitionen für QCAPCMD
  dcl-s cmd like(i_cmd);
  dcl-s cmdLen int(10) inz;
  dcl-ds optCtrl;
    typCmdPrc  bindec(9) inz;
    DBCS_Data  char(1) inz('0'); // ignore DBCS
    prmt_Act   char(1) inz('2'); // selective prom
    cmdStrSntx char(1) inz('0'); // AS/400 Syntax
    msgRtvKey  char(4) inz(*blanks); // no retrieve ke
    res_01     char(9) inz(*ALLx'00');
  end-ds;
  dcl-s optCtrlLen int(10) inz(%len(OptCtrl));
  dcl-s optCtrlFmt char(8) inz('CPOP0100');
  dcl-s retCmd like(i_cmd) inz;
  dcl-s retCmdLenAvl int(10) inz;
  dcl-s retCmdLenRtn int(10) inz;
  dcl-s errCode like(errCode_t) inz;

  //  Hilfsfelder für Funktion: p_TestOmit
  dcl-s isPresent like(int4_t) inz;

  //---------------------------------------------------------------

  p_getOpDesc(1: descType: dataType:
                 descInf1: descInf2:
                 dataLen:  feedBack);

  cmd = %subst(i_cmd: 1: dataLen);
  cmdLen = %len(cmd);
  retCmd = '';
  retCmdLenAvl = %len(retCmd);

  If %parms >= 2;
    errCode = f_newErrCode(cErr_MonErr);
  Else;
    errCode = f_newErrCode(cErr_NoMonErr);
  Endif;

  i2_typCmdPrc = 2;

  If %parms >= 3;
    p_TestOmit(isPresent: 3: *omit);
    If isPresent = 1;
      i2_typCmdPrc = i_typCmdPrc;
    Endif;
  Endif;

  callp(e) QCAPCMD (cmd: cmdLen: optCtrl: optCtrlLen: optCtrlFmt
                    : retCmd: retCmdLenAvl: retCmdLenRtn: errCode);

  o1_msg = f_getAPIErrMsg(errCode);

  //  eintragen Rückgabeparameter ...
  If (%parms >= 2);
    o_msg = o1_msg;
  Endif;

  //  füllen Funktionswert ...
  If f_isAPIErr(errCode);
    isOK = cFalse;
  Else;
    isOK = cTrue;
  Endif;

  return isOK;

end-proc;

//===============================================================*
//  Create New Error Code
//===============================================================*
dcl-proc f_newErrCode export;

  //  Definieren Procedure Interface
  dcl-pi *n like(errCode_t);
    i_monErr like(bool_t) value;
  end-pi;

  //  Definieren Funktionswert
  dcl-ds errCode likeds(errCode_t);

  //  Definieren lokale Arbeitsfelder
  //-------------------------------------------------------------------*

  Clear errCode;

  If (i_monErr = cTrue);
    errCode.bytPrv = %size(errCode);
  Else;
    errCode.bytPrv = 0;
  Endif;

  return errCode;

end-proc;

//===============================================================*
//  Prozedur:  f_getAPIErrMsg
//===============================================================*
dcl-proc f_getAPIErrMsg export;

  //  Definieren Procedure Interface
  dcl-pi *n likeds(msg_t);
    i_errCode like(errCode_t) value;
  end-pi;

  //  Definieren Funktionswert
  dcl-ds apiErrMsg likeds(msg_t) inz;

  //  Definieren lokale Arbeitsfelder
  dcl-ds errCode likeds(errCode_t) inz;
  //-------------------------------------------------------------------*

  //  ermöglichen Zugriff auf Einzelfelder von i_errCode
  errCode = i_errCode;

  If f_isAPIErr(errCode);
    apiErrMsg = f_newMsg(errCode.excID: cMsg_TypEscape: errCode.excDta: 'QCPFMSG': '*LIBL');
  Else;
    apiErrMsg = f_newMsg('');
  Endif;

  return apiErrMsg;

end-proc;

//===============================================================*
//  Test for API error
//===============================================================*
dcl-proc f_isAPIErr export;

  //  Definieren Procedure Interface
  dcl-pi *n like(bool_t);
    i_errCode like(errCode_t) value;
  end-pi;

  //  Definieren Funktionswert
  dcl-s isAPIErr like(msg_t) inz;

  //  Definieren lokale Arbeitsfelder
  dcl-ds errCode likeds(errCode_t) inz;
  //-------------------------------------------------------------------*

  //  ermöglichen Zugriff auf Einzelfelder von i_errCode
  errCode = i_errCode;

  If errCode.bytAvl <> 0;
    isAPIErr = cTrue;
  Else;
    isAPIErr = cFalse;
  Endif;

  return isAPIErr;

end-proc;

//===============================================================*
//  Prozedur:  f_newMsg
//===============================================================*
dcl-proc f_newMsg export;
  dcl-pi *n likeds(msg_t);
    i_msgID   like(msg_t.ID) value;
    // optionale Parametergruppe 1
    i_msgType like(msg_t.type) options(*nopass) value;
    // optionale Parametergruppe 2
    i_msgData like(msg_t.data) options(*nopass: *omit) const;
    // optionale Parametergruppe 3
    i_msgF    like(msg_t.file) options(*nopass) value;
    // optionale Parametergruppe 4
    i_msgL    like(msg_t.lib) options(*nopass) value;
  end-pi;

  //  Definieren Funktionswert
  dcl-ds msg likeds(msg_t) inz;

  //  Hilfsfelder für optionale Parametergruppe 1
  dcl-s i1_msgType like(i_msgType) inz;

  //  Hilfsfelder für optionale Parametergruppe 2
  dcl-s i2_msgData like(I_MsgData) inz;

  //  Hilfsfelder für optionale Parametergruppe 3
  dcl-s i3_msgF like(I_MsgF) inz;

  //  Hilfsfelder für optionale Parametergruppe 4
  dcl-s i4_msgL like(I_MsgL) inz;

  //  Hilfsfelder für Funktion: p_TestOmit
  dcl-s isPresent like(int4_t) inz;
  //-------------------------------------------------------------------*

  //  ... MsgType
  IF (%parms < 2);
    i1_msgType = '*INFO';
  ELSE;
    i1_msgType = i_msgType;
  Endif;

  //  ... MsgData

  IF (%parms < 3);
    I2_MsgData = ' ';
  ELSE;
    p_TestOmit(isPresent: 3: *omit);
    IF (isPresent = 0);
      I2_MsgData = ' ';
    ELSE;
      I2_MsgData = I_MsgData;
    Endif;
  Endif;

  //  ... MsgF
  IF (%parms < 4);
    I3_MsgF = f_getMsgFile;
  ELSE;
    I3_MsgF = I_MsgF;
  Endif;

  //  ... MsgL
  IF (%parms < 5);
    I4_MsgL = f_getMsgFileLib;
  ELSE;
    I4_MsgL = I_MsgL;
  Endif;

  //  Erstellen Nachricht ...
  Clear msg;

  If (i_msgID <> '');
    //  ... MsgID
    msg.ID = i_msgID;
    //  ... MsgType
    msg.type = i1_msgType;
    //  ... MsgData
    msg.data = i2_msgData;
    //  ... MsgF
    msg.file = i3_msgF;
    //  ... MsgL
    msg.lib = i4_msgL;
  Endif;

  return msg;

end-proc;

//===============================================================*
//  Extract from the right side of a string
//===============================================================*
dcl-proc f_right export;

  //  Definieren Procedure Interface
  dcl-pi *n varchar(32767);
    i_str  varchar(32767) value;
    i_rLen like(int4_t) options(*nopass) value;
  end-pi;

  //  Definieren Funktionswert
  dcl-s rightStr like(string_t) inz;

  //  Definieren Hilfsfelder für optinale Parametergruppe 1
  dcl-s i1_rLen like(int4_t) inz;

  //  Lokale Hilfsfelder
  dcl-ds errMsg likeds(msg_t) inz;
  //-------------------------------------------------------------------*

  If (%parms >= 2);
    i1_rLen = i_rLen;
  Else;
    i1_rLen = %len(i_str);
  Endif;

  If %len(i_str) - i1_rLen >= 0;
    rightStr = %subst(i_str: %len(i_str) - i1_rLen + 1);
  Else;
    errMsg = f_newMsg('USR0001': cMsg_TypEscape);
    p_endPgmAbn(errMsg);
  Endif;

  return rightStr;

end-proc;

//===============================================================*
//  Remove Remarks from CL String
//===============================================================*
dcl-proc f_rmvRemCl export;

  //  Definieren Procedure Interface
  dcl-pi *n varchar(32767);
    i_clStr varchar(32767) value;
  end-pi;

  //  Definieren Funktionswert
  dcl-s newClStr varchar(32767) inz('');

  //  Lokale Arbeitsfelder
  dcl-s isClRem like(bool_t) inz(cFalse);
  dcl-s isLiteral like(bool_t) inz(cFalse);
  dcl-s x like(int4_t) inz;
  //-------------------------------------------------------------------*

  x = 1;
  newClStr = %trim(i_clStr);

  DoW x < %len(newClStr);

    //  Wenn wir uns nicht innerhalb eines Remark befinden, ...
    If not isClRem;
      //  ... dann
      //      Prüfen auf Anfang Literalzeichen
      If f_subst(newClStr: x: cLenBegLit) = cBegLit;
        isLiteral = cTrue;
        x = x + cLenBegLit;
        Iter;
      Endif;

      //      Prüfen auf Ende Literalzeichen
      If f_subst(newClStr: x: cLenEndLit) = cEndLit;
        isLiteral = cTrue;
        x = x + cLenEndLit;
        Iter;
      Endif;
    Endif;

    //  Wenn wir uns nicht innerhalb eines Literals befinden, ...
    If not isLiteral;
      //  ... dann
      //      Prüfen auf Anfang eines Remarks
      If f_subst(newClStr: x: cLenBegClRem)= cBegClRem;
        If (x = 1) or
           (%subst(newClStr: x - 1: 1) = ' ');
          isClRem = cTrue;
          %subst(newClStr: x: cLenBegClRem) = '';
          x = x + cLenBegClRem;
          Iter;
        Endif;
      Endif;

      //      Prüfen auf Ende eines Remarks
      If f_subst(newClStr: x: cLenEndClRem)= cEndClRem;
        If (x = %len(newClStr) - cLenEndClRem + 1) or
           (%subst(newClStr: x + cLenEndClRem: 1) = ' ');
          isClRem = cFalse;
          %subst(newClStr: x: cLenEndClRem) = '';
          x = x + cLenEndClRem;
          Iter;
        Endif;
      Endif;
    Endif;

    //  ... ausblenden Remarks
    If isClRem;
      %subst(newClStr: x: 1) = '';
    Endif;

    x = x + 1;
  Enddo;

  return %trim(newClStr);

end-proc;

// =============================================================
//  Formatieren CL Befehl
// =============================================================
dcl-proc f_fmtCmd export;
  dcl-pi *n like(capcmd_t);
    i_cmd like(capcmd_t) value;
  end-pi;

  //  Definitionen für QCAPCMD
  dcl-s cmd like(i_cmd);
  dcl-s cmdLen int(10) inz(%len(cmd));
  dcl-ds optCtrl;
    typCmdPrc  bindec(9) inz(4); // cl commands
    DBCS_Data  char(1) inz('1'); // handle DBCS
    prmt_Act   char(1) inz('0'); // never prompt
    cmdStrSntx char(1) inz('0'); // AS/400 Syntax
    msgRtvKey  char(4) inz(*blanks); // no retrieve ke
    res_01     char(9) inz(*ALLx'00');
  end-ds;
  dcl-s optCtrlLen int(10) inz(%len(OptCtrl));
  dcl-s optCtrlFmt char(8) inz('CPOP0100');
  dcl-s retCmd like(i_cmd) inz;
  dcl-s retCmdLenAvl int(10) inz(%len(retCmd));
  dcl-s retCmdLenRtn int(10) inz;
  dcl-ds errCode;
    errBytPrv int(10) inz(%size(errCode));
    errBytAvl int(10) inz;
    errID     char(7) inz;
    errRes01  char(1) inz;
    errDta    char(256) inz;
  end-ds;
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  Reset errCode;

  cmd          = i_cmd;

  callp(e) QCAPCMD ( cmd : cmdLen : optCtrl :
  optCtrlLen : optCtrlFmt : retCmd :
  retCmdLenAvl : retCmdLenRtn : errCode );

  //  Prüfen API-Fehler ...
  If f_isAPIErr(errCode);
    retCmd = '';
  Else;

    //  Prüfen Länge der Befehlszeichenkette ...
    If retCmdLenRtn > retCmdLenAvl;
      retCmd = '';
    Endif;
  Endif;

  return retCmd;

end-proc;

//===============================================================*
//  End Program Abnormal
//===============================================================*
dcl-proc p_endPgmAbn export;

  //  Definieren Procedure Interface
  dcl-pi *n;
    i_msg likeds(msg_t) value;
  end-pi;
  //-------------------------------------------------------------------*

  p_sndPgmMsg(i_msg: cMsg_Prv: cMsg_ToCtlBdy);

  return;

end-proc;

//===============================================================*
//  Compare generic Message IDs
//===============================================================*
dcl-proc f_cmpMonMsgID export;

  //  Definieren Procedure Interface
  dcl-pi *n like(bool_t);
    i_msgId    like(msg_t.ID) value;
    i_monMsgId like(msg_t.ID) value;
  end-pi;

  //  Definieren Funktionswert
  dcl-s isEqual like(bool_t) inz(cFalse);
  //-------------------------------------------------------------------*

  If %subst(i_msgId: 6: 2) = '00';
    %subst(i_monMsgId: 6: 2) = '00';
    If %subst(i_msgId: 4: 2) = '00';
      %subst(i_monMsgId: 4: 2) = '00';
    Endif;
  Endif;

  If i_monMsgId = i_msgId;
    isEqual = cTrue;
  Else;
    isEqual = cFalse;
  Endif;

  return isEqual;

end-proc;

//===============================================================*
//  Prozedur:  p_sndPgmMsg
//===============================================================*
dcl-proc p_sndPgmMsg export;
  dcl-pi *n;
    i_msg    likeds(msg_t) value;
    // optionale Parametergruppe 1
    i_toStkC like(int4_t) options(*nopass) value;
    // optionale Parametergruppe 2
    i_toProc like(proc_t) options(*nopass) value;
    // optionale Parametergruppe 3
    i_toMod  like(mod_t) options(*nopass: *omit) const;
    // optionale Parametergruppe 4
    i_toPgm  like(pgm_t) options(*nopass) value;
  end-pi;

  //  Zerlegung Eingangsparameter I_Msg in Einzelfelder
  dcl-ds msg likeds(msg_t) inz;

  //  Hilfsfelder für optionale Parametergruppe 1
  dcl-s I1_ToStkC like(I_ToStkC) inz(*zeros);

  //  Hilfsfelder für optionale Parametergruppe 2
  dcl-s I2_ToProc like(I_ToProc) inz(*blanks);

  //  Hilfsfelder für optionale Parametergruppe 3
  dcl-s I3_ToMod like(I_ToMod) inz(*zeros);

  //  Hilfsfelder für optionale Parametergruppe 4
  dcl-s I4_ToPgm like(I_ToPgm) inz(*blanks);

  //  Hilfsfelder für System-API: CEETSTA
  dcl-s isPresent like(int4_t) inz(*zeros);

  //  Parameterfelder für System-API: QMHSNDPM
  dcl-s p1_MsgID char(7) inz(*blanks);
  dcl-ds p1_DSMsgFObj len(20);
    p1_DSMsgF char(10) inz(*blanks);
    p1_DSMsgL char(10) inz(*blanks);
  end-ds;

  dcl-s p1_MsgData like(msg.data) inz(*blanks);
  dcl-s p1_LenMsgData like(int4_t) inz(*zeros);
  dcl-s p1_MsgType char(10) inz(*blanks);
  dcl-s p1_CallStkE like(I_ToProc) inz(*blanks);
  dcl-s p1_CallStkCtr like(int4_t) inz(*blanks);
  dcl-s p1_MsgKey char(4) inz(*blanks);
  dcl-ds p1_ErrCode likeds(errCode_t) inz;

  // Optional Parameter Group 1
  dcl-s p1_LenCallStkE like(int4_t) inz(*zeros);
  dcl-ds p1_CallStkEQ len(20);
    p1_CallStkEQM char(10) inz(*blanks);
    p1_CallStkEQP char(10) inz(*blanks);
  end-ds;
  dcl-s p1_WaitTime like(int4_t) inz(*zeros);
  //-------------------------------------------------------------------*

  //  Ermöglichen Zugriff auf Einzelfelder ...
  msg = i_msg;

  //  Einsetzen der Defaultwerte ...
  //  ... Stackcounter
  If %parms < 2;
    i1_toStkC = cMsg_Same;
  Else;
    i1_toStkC = i_toStkC;
  Endif;

  //  ... an Prozedur
  If (%parms < 3);
    i2_toProc     = cMsg_toMySelf;
  Else;
    i2_toProc  = i_toProc;
  Endif;

  //  ... an Modul
  If %parms < 4;
    i3_toMod   = '*NONE';
  Else;
    p_TestOmit(isPresent: 4 : *omit);
    If (isPresent = cCEE_isNotPresent);
      i3_toMod   = '*NONE';
    Else;
      I3_toMod   = i_toMod;
    Endif;
  Endif;

  //  ... an Programm
  IF %parms < 5;
    i4_toPgm   = '*NONE';
  ELSE;
    i4_toPgm   = i_toPgm;
  Endif;

  //  Füllen Parameterfelder für System-API ...
  //  Call Stack Counter ...
  Select;
  //  ... *EXT
  When i1_ToStkC     = cMsg_Ext;
    p1_callStkCtr = 0;
    i2_toProc     = '*EXT';
  //  ... *PERVIOUS
  When i1_toStkC     = cMsg_Prv;
    p1_callStkCtr = 1;
  //  ... *SAME
  When i1_toStkC     = cMsg_Same;
    p1_callStkCtr = 0;
  //  ... sonst
  Other;
    p1_callStkCtr = 0;
  Endsl;

  //  An Prozedur ...
  Select;
  //  ... *
  When i2_toProc = cMsg_toMySelf;
    p1_callStkE = '*';
    //      ... eigene Prozedur SndPgmMsg überspringen
    p1_callStkCtr = p1_callStkCtr + 1;
  //  ... *PGMBDY
  When i2_toProc = cMsg_ToPgmBdy;
    p1_callStkE = '*PGMBDY';
  //  ... *CTLBDY
  When i2_toProc = cMsg_ToCtlBdy;
    p1_callStkE = '*CTLBDY';
  //  ... *PGMNAME
  When i2_toProc = cMsg_ToPgm;
    p1_callStkE = '*PGMNAME';
  //  ... *EXT
  When i2_toProc = '*EXT';
    p1_callStkE = '*EXT';
  //  ... benannte Prozedur
  Other;
    p1_callStkE = i2_toProc;
  Endsl;

  //  An Modul ...
  p1_CallStkEQM = i3_toMod;

  //  An Programm ...
  p1_callStkEQP = i4_toPgm;

  //  Nachrichten ...
  p1_msgID = msg.ID;
  p1_msgData = msg.data;
  p1_lenMsgData  = %size(p1_msgData);

  Select;
  //  ... Anwendung-Information
  When msg.type = cMsg_AppInfo;
    p1_msgType = cMsg_TypInfo;
  //  ... Anwendung-Warnung
  When msg.type = cMsg_AppWarning;
    p1_msgType = cMsg_TypInfo;
  //  ... Anwendung-Fehler
  When msg.type = cMsg_AppError;
    p1_msgType = cMsg_TypInfo;
  Other;
    p1_msgType = msg.type;
  Endsl;

  p1_DSMsgF = msg.file;
  p1_DSMsgL = msg.lib;

  //  Nachrichtenschlüssel ...
  p1_msgKey = '';
  //  Fehlercode ...
  p1_errCode = f_newErrCode(cErr_NoMonErr);

  //  Sonstige Parameter ...
  p1_lenCallStkE = %size(p1_CallStkE);
  p1_waitTime = -1;

  QMHSNDPM (p1_MsgID: p1_DSMsgFObj: p1_MsgData: p1_LenMsgData: p1_MsgType
            : p1_CallStkE: p1_CallStkCtr: p1_MsgKey: p1_ErrCode
            : p1_LenCallStkE: p1_CallStkEQ: p1_WaitTime);

  return;

end-proc;

//===============================================================*
//  test if an object exist
//===============================================================*
dcl-proc f_exist export;

  //  Definieren Procedure Interface
  dcl-pi *n like(bool_t);
    i_obj     like(obj_t) const;
    i_lib     like(lib_t) options(*omit) const;
    i_objType like(objType_t) const;
    i_mbr     like(mbr_t) options(*omit) const;
    o_msg     likeds(msg_t) options(*nopass);
  end-pi;

  //  Definieren Funktionswert
  dcl-s isOK like(bool_t) inz;

  //  Definieren Hilfsfelder für optinale Parametergruppe 1
  dcl-s i1_lib like(lib_t) inz;

  //  Definieren Hilfsfelder für optinale Parametergruppe 2
  dcl-s i2_mbr like(mbr_t) inz;

  //  Hilfsfelder für Funktion: p_TestOmit
  dcl-s isPresent like(int4_t) inz(*zeros);

  //  Lokale Arbeitsfelder
  dcl-s cmdStr char(256) inz;
  dcl-ds errMsg likeds(msg_t) inz;

  //-------------------------------------------------------------------*

  p_TestOmit(isPresent: 2 : *omit);
  If (isPresent = cCEE_isNotPresent);
    i1_lib = '*LIBL';
  Else;
    i1_lib = i_lib;
  Endif;

  p_TestOmit(isPresent: 4 : *omit);
  If (isPresent = cCEE_isNotPresent);
    i2_mbr = '*NONE';
  Else;
    i2_mbr = i_mbr;
  Endif;

  cmdStr    = 'CHKOBJ OBJ('    +
             %trim(i1_lib)    +
             '/'              +
             %trim(i_obj)     +
             ') '             +
             'OBJTYPE('       +
             %trim(i_objtype) +
             ') '             +
             'MBR('           +
             %trim(i2_mbr)    +
             ') ';

  If not f_execute(cmdStr    :
                errMsg    );
    isOK = cFalse;
  Else;
    isOK = cTrue;
  Endif;

  If %parms >= 5;
    o_msg = errMsg;
  Endif;

  return isOK;

end-proc;

//===============================================================*
//  Set Message file
//===============================================================*
dcl-proc p_setMsgFile export;

  //  Definieren Procedure Interface
  dcl-pi *n;
    i_msgF    like(msg_t.file) value;
    i_msgFLib like(msg_t.lib) value;
  end-pi;
  //-------------------------------------------------------------------*

  g_msgF = i_msgF;
  g_msgFLib = i_msgFLib;

end-proc;

//===============================================================*
//  Get Message file
//===============================================================*
dcl-proc f_getMsgFile export;

  //  Definieren Procedure Interface
  dcl-pi *n like(msg_t.file);
  end-pi;

  //  Definieren Funktionswert
  dcl-s o_msgF like(msg_t.file) inz;
  //-------------------------------------------------------------------*

  o_msgF    = g_msgF;

  return o_msgF;

end-proc;

//===============================================================*
//  Get Message file library
//===============================================================*
dcl-proc f_getMsgFileLib export;

  //  Definieren Procedure Interface
  dcl-pi *n like(msg_t.lib);
  end-pi;

  //  Definieren Funktionswert
  dcl-s o_msgFLib like(msg_t.lib) inz;
  //-------------------------------------------------------------------*

  o_msgFLib = g_msgFLib;

  return o_msgFLib;

end-proc;

//===============================================================*
//  Private:
//  Get token from string
//===============================================================*
dcl-proc f_subst;

  //  Definieren Procedure Interface
  dcl-pi *n varchar(32767);
    str      varchar(32767) value;
    pos      like(int4_t) value;
    lenToken like(int4_t) value;
  end-pi;
  //-------------------------------------------------------------------*

  If pos + lenToken - 1 <= %len(str);
    return %subst(str: pos: lenToken);
  Else;
    return '';
  Endif;

end-proc;

