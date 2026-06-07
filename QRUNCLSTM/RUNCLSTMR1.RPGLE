**free
// =================================================================== *
//                                                                     *
//  Kurzdokumentation :                                                *
//                                                                     *
//  Bereich . . . : RUNCLSTM                                           *
//  Objekt  . . . : RUNCLSTMR1                                         *
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
//  12.04.2005  Th.Raddatz    Fixed Problem that variables were not    *
//                            replaced for MONMSG statements.          *
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
//     >>PARM<< OPTION(*EVENTF);                                       *
//   >>END-COMPILE<<                                                   *
//                                                                     *
//   >>EXECUTE<<                                                       *
//                                                                     *
// >>END-PRE-COMPILER<<                                                *
// =================================================================== *
/copy QRUNCLSTM,COPYRIGHT
ctl-opt main(pgm_entry_point);
// =================================================================== *
dcl-f SCRIPT disk(32766) usropn;



dcl-ds inf1_script;
  inf1_status zoned(5) inz pos(11);
  inf1_msg    char(7) inz pos(46);
  inf1_file   char(10) inz pos(83);
  inf1_lib    char(10) inz;
  inf1_recLen int(5) inz pos(125);
  inf1_mbr    char(10) inz pos(129);
  inf1_recNbr int(10) inz pos(397);
end-ds;

dcl-ds ds_script;
  ds_srcSeq zoned(6: 2) inz;
  ds_srcDat zoned(6) inz;
  ds_srcDta char(32754) inz;
end-ds;

//===============================================================*
//  Type Definitions
//===============================================================*
dcl-ds rplVarData_t based(pDummy) qualified;
  xLib        like(gi_xLib);
  xObj        like(gi_xObj);
  xTypeCode   like(gi_xTypeCode);
  xSrcLib     like(gi_xSrcLib);
  xSrcFile    like(gi_xSrcFile);
  xSrcMbr     like(gi_xSrcMbr);
  xTestLib    like(gi_xTestLib);
  xTestObj    like(gi_xTestObj);
  xTgtRls     like(gi_xTgtRls);
  xFrmSrcLib  like(gi_xFrmSrcLib);
  xFrmSrcFile like(gi_xFrmSrcFile);
  xFrmSrcMbr  like(gi_xFrmSrcMbr);
  xUser0      like(gi_xUser0);
  xUser1      like(gi_xUser1);
  xUser2      like(gi_xUser2);
  xUser3      like(gi_xUser3);
  xUser4      like(gi_xUser4);
  xUser5      like(gi_xUser5);
  xUser6      like(gi_xUser6);
  xUser7      like(gi_xUser6);
  xUser8      like(gi_xUser6);
  xUser9      like(gi_xUser6);
end-ds;

//===============================================================*
//  Common Constants
//===============================================================*

/copy QRUNCLSTM,RUNCLSTMG3

//===============================================================*
//  Messages
//===============================================================*
/copy QRUNCLSTM,USR0002
/copy QRUNCLSTM,USR0003
/copy QRUNCLSTM,USR0004

//===============================================================*
//  Imported Prototypes
//===============================================================*

/copy QRUNCLSTM,RUNCLSTMG1
/copy QRUNCLSTM,RUNCLSTMG2

dcl-pr ceertx extproc('CEERTX');
  i_procedure pointer(*proc) const;
  i_token     pointer options(*omit) const;
  o_fc        char(12) options(*omit);
end-pr;

dcl-pr ceeutx extproc('CEEUTX');
  i_procedure pointer(*proc) const;
  o_fc        char(12) options(*omit);
end-pr;

//===============================================================*
//  Private Prototypes
//===============================================================*

dcl-pr p_main;
  i_qFile       like(qObj_t) value;
  i_mbr         like(mbr_t) value;
  i_strSeq      like(srcSeq_t) value;
  i_endSeq      like(srcSeq_t) value;
  i_xLib        like(lib_t) value;
  i_xObj        like(obj_t) value;
  i_xTypeCode   like(typecode_t) value;
  i_xSrcLib     like(lib_t) value;
  i_xSrcFile    like(file_t) value;
  i_xSrcMbr     like(mbr_t) value;
  i_xTestLib    like(lib_t) value;
  i_xTestObj    like(obj_t) value;
  i_xTgtRls     like(tgtRls_t) value;
  i_xFrmSrcLib  like(lib_t) value;
  i_xFrmSrcFile like(file_t) value;
  i_xFrmSrcMbr  like(mbr_t) value;
  i_xUser0      like(userdef_t) value;
  i_xUser1      like(userdef_t) value;
  i_xUser2      like(userdef_t) value;
  i_xUser3      like(userdef_t) value;
  i_xUser4      like(userdef_t) value;
  i_xUser5      like(userdef_t) value;
  i_xUser6      like(userdef_t) value;
  i_xUser7      like(userdef_t) value;
  i_xUser8      like(userdef_t) value;
  i_xUser9      like(userdef_t) value;
  i_msgF        like(msg_t.file) value;
  i_naming      like(naming_t) value;
end-pr;

dcl-pr p_abnEndProc;
  i_token pointer const;
end-pr;

dcl-pr f_getCmd like(bool_t);
  io_cmdString like(capcmd_t);
  i_strSeq     like(srcSeq_t) value;
  i_endSeq     like(srcSeq_t) value;
end-pr;

dcl-pr p_replace;
  io_string like(capcmd_t);
  i_var     char(10) value;
  i_value   char(256) value;
end-pr;

dcl-pr f_monMsg like(bool_t);
  i_msgID      like(msg_t.id) value;
  i_strSeq     like(srcSeq_t) value;
  i_endSeq     like(srcSeq_t) value;
  i_rplVarData likeds(rplVarData_t) value;
end-pr;

dcl-pr f_rtvCmdToken like(bool_t);
  i_cmdString like(capcmd_t) value;
  o_cmdToken  like(cmdToken_t);
end-pr;

dcl-pr f_rtvCmdParm like(bool_t);
  i_cmdString like(capcmd_t) value;
  o_cmdParm   like(capcmd_t);
end-pr;

dcl-pr f_rtvKeyWrd like(capcmd_t);
  i_keyWrd char(10) value;
  i_cmd    like(capcmd_t) value;
end-pr;

dcl-pr f_rtvKeyWrdDta like(capcmd_t);
  i_keyWrd like(capcmd_t) value;
end-pr;

dcl-pr f_getToken pointer extproc('strtok');
  pString    pointer options(*string) value;
  pTokenList pointer options(*string) value;
end-pr;

dcl-pr f_ucase char(2048);
  i_string char(2048) value;
end-pr;

dcl-pr f_rplVars like(capcmd_t);
  i_cmdString  like(capcmd_t) value;
  i_rplVarData likeds(rplVarData_t) value;
end-pr;

//===============================================================*
//  Global Constants
//===============================================================*

dcl-c cNONE '*NONE';
dcl-c cCLP 'CLP';
dcl-c cSQL 'SQL';
dcl-c cBeginSQL '/EXEC SQL';
dcl-c cEndSQL '/END-EXEC';

//===============================================================*
//  Global Fields
//===============================================================*
dcl-s g_isSqlOpn like(bool_t) inz(cFalse);

//===============================================================*
//  Global Input Variables
//===============================================================*

dcl-s gi_qFile like(qObj_t);
dcl-s gi_mbr like(mbr_t);
dcl-s gi_strSeq like(srcSeq_t);
dcl-s gi_endSeq like(srcSeq_t);
dcl-s gi_xLib like(lib_t);
dcl-s gi_xObj like(obj_t);
dcl-s gi_xTypeCode like(typecode_t);
dcl-s gi_xSrcLib like(lib_t);
dcl-s gi_xSrcFile like(file_t);
dcl-s gi_xSrcMbr like(mbr_t);
dcl-s gi_xTestLib like(lib_t);
dcl-s gi_xTestObj like(obj_t);
dcl-s gi_xTgtRls like(tgtRls_t);
dcl-s gi_xFrmSrcLib like(lib_t);
dcl-s gi_xFrmSrcFile like(file_t);
dcl-s gi_xFrmSrcMbr like(mbr_t);
dcl-s gi_xUser0 like(userdef_t);
dcl-s gi_xUser1 like(userdef_t);
dcl-s gi_xUser2 like(userdef_t);
dcl-s gi_xUser3 like(userdef_t);
dcl-s gi_xUser4 like(userdef_t);
dcl-s gi_xUser5 like(userdef_t);
dcl-s gi_xUser6 like(userdef_t);
dcl-s gi_xUser7 like(userdef_t);
dcl-s gi_xUser8 like(userdef_t);
dcl-s gi_xUser9 like(userdef_t);
dcl-s gi_xMsgF like(msg_t.file);
dcl-s gi_xNaming like(naming_t);

dcl-s xNaming like(gi_xNaming);
// --------------------------------------------------------------------
// Stand Alone Fields - TOP
// --------------------------------------------------------------------
dcl-s do_x1 packed(7);
// --------------------------------------------------------------------
// Stand Alone Fields - BOTTOM
// --------------------------------------------------------------------

dcl-pr pg_entr_point extpgm('RUNCLSTM');
  gi_qFile       like(qObj_t) const;
  gi_mbr         like(mbr_t) const;
  gi_strSeq      like(srcSeq_t) const;
  gi_endSeq      like(srcSeq_t) const;
  gi_xLib        like(lib_t) const;
  gi_xObj        like(obj_t) const;
  gi_xTypeCode   like(typecode_t) const;
  gi_xSrcLib     like(lib_t) const;
  gi_xSrcFile    like(file_t) const;
  gi_xSrcMbr     like(mbr_t) const;
  gi_xTestLib    like(lib_t) const;
  gi_xTestObj    like(obj_t) const;
  gi_xTgtRls     like(tgtRls_t) const;
  gi_xFrmSrcLib  like(lib_t) const;
  gi_xFrmSrcFile like(file_t) const;
  gi_xFrmSrcMbr  like(mbr_t) const;
  gi_xUser0      like(userdef_t) const;
  gi_xUser1      like(userdef_t) const;
  gi_xUser2      like(userdef_t) const;
  gi_xUser3      like(userdef_t) const;
  gi_xUser4      like(userdef_t) const;
  gi_xUser5      like(userdef_t) const;
  gi_xUser6      like(userdef_t) const;
  gi_xUser7      like(userdef_t) const;
  gi_xUser8      like(userdef_t) const;
  gi_xUser9      like(userdef_t) const;
  gi_xMsgF       like(msg_t.file) const;
  gi_xNaming     like(naming_t) const;
end-pr;

//===============================================================*
//  Main Stream
//===============================================================*
dcl-proc pgm_entry_point;
  dcl-pi *n;
    gi_qFile       like(qObj_t) const;
    gi_mbr         like(mbr_t) const;
    gi_strSeq      like(srcSeq_t) const;
    gi_endSeq      like(srcSeq_t) const;
    gi_xLib        like(lib_t) const;
    gi_xObj        like(obj_t) const;
    gi_xTypeCode   like(typecode_t) const;
    gi_xSrcLib     like(lib_t) const;
    gi_xSrcFile    like(file_t) const;
    gi_xSrcMbr     like(mbr_t) const;
    gi_xTestLib    like(lib_t) const;
    gi_xTestObj    like(obj_t) const;
    gi_xTgtRls     like(tgtRls_t) const;
    gi_xFrmSrcLib  like(lib_t) const;
    gi_xFrmSrcFile like(file_t) const;
    gi_xFrmSrcMbr  like(mbr_t) const;
    gi_xUser0      like(userdef_t) const;
    gi_xUser1      like(userdef_t) const;
    gi_xUser2      like(userdef_t) const;
    gi_xUser3      like(userdef_t) const;
    gi_xUser4      like(userdef_t) const;
    gi_xUser5      like(userdef_t) const;
    gi_xUser6      like(userdef_t) const;
    gi_xUser7      like(userdef_t) const;
    gi_xUser8      like(userdef_t) const;
    gi_xUser9      like(userdef_t) const;
    gi_xMsgF       like(msg_t.file) const;
    gi_xNaming     like(naming_t) const;
  end-pi;

  If %addr(gi_xNaming) = *NULL;
    xNaming = '*SYS';
  Else;
    xNaming = gi_xNaming;
  Endif;

  CEERTX(%paddr('P_ABNENDPROC') :
        *null                  :
        *omit                  );

  p_main(gi_qFile    : gi_mbr     :
        gi_strSeq   : gi_endSeq  :
        gi_xLib     : gi_xObj    :
        gi_xTypeCode             :
        gi_xSrcLib  : gi_xSrcFile:
        gi_xSrcMbr               :
        gi_xTestLib : gi_xTestObj:
        gi_xTgtRls               :
        gi_xFrmSrcLib            :
        gi_xFrmSrcFile           :
        gi_xFrmSrcMbr            :
        gi_xUser0                :
        gi_xUser1                :
        gi_xUser2                :
        gi_xUser3                :
        gi_xUser4                :
        gi_xUser5                :
        gi_xUser6                :
        gi_xUser7                :
        gi_xUser8                :
        gi_xUser9                :
        gi_xMsgF                 :
        xNaming                  );

on-exit;

  CEEUTX(%paddr('P_ABNENDPROC'): *omit);

end-proc;

//===============================================================*
//  Main Procedure
//===============================================================*
dcl-proc p_main;
  dcl-pi *n;
    i_qFile       like(qObj_t) value;
    i_mbr         like(mbr_t) value;
    i_strSeq      like(srcSeq_t) value;
    i_endSeq      like(srcSeq_t) value;
    i_xLib        like(lib_t) value;
    i_xObj        like(obj_t) value;
    i_xTypeCode   like(typecode_t) value;
    i_xSrcLib     like(lib_t) value;
    i_xSrcFile    like(file_t) value;
    i_xSrcMbr     like(mbr_t) value;
    i_xTestLib    like(lib_t) value;
    i_xTestObj    like(obj_t) value;
    i_xTgtRls     like(tgtRls_t) value;
    i_xFrmSrcLib  like(lib_t) value;
    i_xFrmSrcFile like(file_t) value;
    i_xFrmSrcMbr  like(mbr_t) value;
    i_xUser0      like(userdef_t) value;
    i_xUser1      like(userdef_t) value;
    i_xUser2      like(userdef_t) value;
    i_xUser3      like(userdef_t) value;
    i_xUser4      like(userdef_t) value;
    i_xUser5      like(userdef_t) value;
    i_xUser6      like(userdef_t) value;
    i_xUser7      like(userdef_t) value;
    i_xUser8      like(userdef_t) value;
    i_xUser9      like(userdef_t) value;
    i_xMsgF       like(msg_t.file) value;
    i_xNaming     like(naming_t) value;
  end-pi;

  dcl-s cmdString like(capcmd_t) inz;
  dcl-ds errMsg likeds(msg_t) inz;

  dcl-ds rplVarData likeds(rplVarData_t) inz;

  dcl-ds qFile likeds(qObj_t) inz;
  dcl-s clCmdString char(256);
  dcl-ds diagMsg likeds(msg_t) inz;
  dcl-s mode char(10) inz;
  dcl-s srcSeq like(srcSeq_t) inz;
  dcl-s cmdToken like(cmdToken_t);
  dcl-ds errCode likeds(errCode_t) inz;

  //---------------------------------------------------------------

  qFile = i_qFile;

  //  Laden Werte für Ersatzvariablen
  rplVarData.xLib        = i_xLib;
  rplVarData.xObj        = i_xObj;
  rplVarData.xTypeCode   = i_xTypeCode;
  rplVarData.xSrcLib     = i_xSrcLib;
  rplVarData.xSrcFile    = i_xSrcFile;
  rplVarData.xSrcMbr     = i_xSrcMbr;
  rplVarData.xTestLib    = i_xTestLib;
  rplVarData.xTestObj    = i_xTestObj;
  rplVarData.xTgtRls     = i_xTgtRls;
  rplVarData.xFrmSrcLib  = i_xFrmSrcLib;
  rplVarData.xFrmSrcFile = i_xFrmSrcFile;
  rplVarData.xFrmSrcMbr  = i_xFrmSrcMbr;
  rplVarData.xUser0      = i_xUser0;
  rplVarData.xUser1      = i_xUser1;
  rplVarData.xUser2      = i_xUser2;
  rplVarData.xUser3      = i_xUser3;
  rplVarData.xUser4      = i_xUser4;
  rplVarData.xUser5      = i_xUser5;
  rplVarData.xUser6      = i_xUser6;
  rplVarData.xUser7      = i_xUser7;
  rplVarData.xUser8      = i_xUser8;
  rplVarData.xUser9      = i_xUser9;

  //  Setzen der Nachrichtendatei
  p_setMsgFile(i_xMsgF: '*LIBL');

  //  Wenn die Bibliothek nicht existiert, ...
  If (qFile.lib <> '*LIBL  ') and
     (qFile.lib <> '*CURLIB');
    If not f_exist(qFile.lib  : *omit     :
                '*LIB'     : *omit     : errMsg);
      //  ... dann
      //      beenden mit Fehlermeldung
      p_endPgmAbn(errMsg);
    Endif;
  Endif;

  //  Wenn die Datei nicht existiert, ...
  If not f_exist(qFile.name : qFile.lib :
              '*FILE'    : *omit     : errMsg);
    //  ... dann
    //      beenden mit Fehlermeldung
    p_endPgmAbn(errMsg);
  Endif;

  //  Wenn die Teildatei nicht existiert, ...
  If not f_exist(qFile.name : qFile.lib :
              '*FILE'   : i_mbr      : errMsg);
    //  ... dann
    //      beenden mit Fehlermeldung
    p_endPgmAbn(errMsg);
  Endif;

  //  Wenn die Datei nicht überschrieben werden kann, ...
  clCmdString = 'OVRDBF FILE('    +
               'SCRIPT'          +
               ') '              +
               'TOFILE('         +
               %trim(qFile.lib)  +
               '/'               +
               %trim(qFile.name) +
               ') '              +
               'MBR('            +
               %trim(i_mbr)      +
               ') '              +
               'OVRSCOPE('       +
               '*ACTGRPDFN'      +
               ')';
  If not f_execute(clCmdString: errMsg);
    //      ... dann
    //          beenden mit Fehlermeldung
    p_endPgmAbn(errMsg);
  Endif;

  //  Setzen Betriebsmodus ...
  mode = cCLP;

  //  Lesen und verarbeiten Skript ...
  Open SCRIPT;
  errCode = f_newErrCode(cErr_NoMonErr);
  p_rmvPgmMsg('*': 0: '':'*ALL': errCode);

  DoW f_getCmd(cmdString: i_strSeq: i_endSeq);

    //  Entfernen Remarks ...
    cmdString = f_rmvRemCl(cmdString);
    If %trim(cmdString) = '';
      Iter;
    Endif;

    //  Überlesen MONMSG ...
    f_rtvCmdToken(cmdString :
                 cmdToken  );
    If f_ucase(cmdToken) = 'MONMSG';
      Iter;
    Endif;

    //  Überlesen PGM ...
    f_rtvCmdToken(cmdString :
                 cmdToken  );
    If f_ucase(cmdToken) = 'PGM';
      Iter;
    Endif;

    //  Überlesen DCL ...
    f_rtvCmdToken(cmdString :
                 cmdToken  );
    If f_ucase(cmdToken) = 'DCL';
      Iter;
    Endif;

    //  Überlesen ENDPGM ...
    f_rtvCmdToken(cmdString :
                 cmdToken  );
    If f_ucase(cmdToken) = 'ENDPGM';
      Iter;
    Endif;

    //  Prüfen Betriebsartenumschaltung auf ...
    //  ... starten SQL
    If cmdString = cBeginSQL;
      //      Wenn die Betriebsart SQL bereits eingestellt ist, ...
      If mode = cSQL;
        //      ... dann
        //          ausgeben Diagnose Nachricht
        Clear USR0002;
        USR00021 = ds_srcSeq;
        USR00022 = cmdString;
        diagMsg  = f_newMsg('USR0002'      :
                           cMsg_TypDiag   :
                           USR0002        );
        p_sndPgmMsg(diagMsg       :
                   cMsg_Prv      :
                   cMsg_ToCtlBdy );
        //          beenden mit Fehlermeldung
        Clear USR0003;
        USR00031 = cSQL;
        USR00032 = cBeginSQL;
        USR00033 = cEndSQL;
        errMsg   = f_newMsg('USR0003'      :
                           cMsg_TypEscape :
                           USR0003        );
        p_endPgmAbn(errMsg);
      Else;
        //      ... sonst
        //          umschalten auf SQL-Modus
        mode = cSQL;
        Iter;
      Endif;
    Endif;

    //  ... beenden SQL
    If cmdString = cEndSQL;
      //      Wenn die Betriebsart CLP bereits eingestellt ist, ...
      If mode = cCLP;
        //      ... dann
        //          ausgeben Diagnose Nachricht
        Clear USR0002;
        USR00021 = ds_srcSeq;
        USR00022 = cmdString;
        diagMsg  = f_newMsg('USR0002'      :
                           cMsg_TypDiag   :
                           USR0002        );
        p_sndPgmMsg(diagMsg       :
                   cMsg_Prv      :
                   cMsg_ToCtlBdy );
        //          beenden mit Fehlermeldung
        Clear USR0004;
        USR00041 = cCLP;
        USR00042 = cEndSQL;
        USR00043 = cBeginSQL;
        errMsg   = f_newMsg('USR0004'      :
                           cMsg_TypEscape :
                           USR0004        );
        p_endPgmAbn(errMsg);
      Else;
        //      ... sonst
        //          umschalten auf SQL-Modus
        mode = cCLP;
        Iter;
      Endif;
    Endif;

    //  Ersetzen Variablen ...
    cmdString = f_rplVars(cmdString: rplVarData);

    //  Ausführen ...
    Select;
    //  ... CL-Befehl
    When mode = cCLP;
      srcSeq = ds_srcSeq;
      If not f_execute(cmdString: errMsg)  and
         not f_monMsg(errMsg.ID : i_strSeq: i_endSeq:
                   rplVarData);
        //      ... dann
        //          ausgeben Diagnose-Nachricht
        Clear USR0002;
        USR00021 = srcSeq;
        USR00022 = cmdString;
        diagMsg  = f_newMsg('USR0002'      :
                           cMsg_TypDiag   :
                           USR0002        );
        p_sndPgmMsg(diagMsg       :
                   cMsg_Prv      :
                   cMsg_ToCtlBdy );
        //          beenden mit Fehlermeldung
        p_endPgmAbn(errMsg);
      Endif;
    //  ... SQL-Anweisung
    When mode = cSQL;
      srcSeq = ds_srcSeq;
      If not g_isSqlOpn and
         not f_opnSql(i_xNaming: diagMsg);
        g_isSqlOpn = cFalse;
        //          senden Diagnose Nachricht
        diagMsg  = f_newMsg(diagMsg.ID     :
                           cMsg_TypDiag   :
                           diagMsg.data   );
        p_sndPgmMsg(diagMsg       :
                   cMsg_Prv      :
                   cMsg_ToCtlBdy );
        //          beenden mit Fehlermeldung
        p_endPgmAbn(errMsg);
      Else;
        g_isSqlOpn = cTrue;
      Endif;

      If not f_executeSQL(cmdString: errMsg) and
         not f_monMsg(errMsg.ID   : i_strSeq:i_endSeq:
                   rplVarData);
        //      ... dann
        //          ausgeben Diagnose-Nachricht
        Clear USR0002;
        USR00021 = srcSeq;
        USR00022 = cmdString;
        diagMsg  = f_newMsg('USR0002'      :
                           cMsg_TypDiag   :
                           USR0002        );
        p_sndPgmMsg(diagMsg       :
                   cMsg_Prv      :
                   cMsg_ToCtlBdy );
        //          beenden mit Fehlermeldung
        errMsg = f_newMsg('CPF9898'      :
                         cMsg_TypEscape :
                         errMsg.data    :
                         'QCPFMSG'      :
                         '*LIBL'        );
        p_endPgmAbn(errMsg);
      Endif;
    //  ... ungültiger Modus
    Other;
    Endsl;

  Enddo;

  Close SCRIPT;

  If g_isSqlOpn;
    p_cloSql();
    g_isSqlOpn = cFalse;
  Endif;

  //  Wenn die Überschreibungen nicht gelöscht werden können, ...
  clCmdString = 'DLTOVR FILE(' +
               'SCRIPT'       +
               ') '           +
               'LVL('         +
               '*ACTGRPDFN'   +
               ')';

  If not f_execute(clCmdString: errMsg);
    //  ... dann
    //      beenden mit Fehlermeldung
    p_endPgmAbn(errMsg);
  Endif;

  Return;

end-proc;

//===============================================================*
//  Get Command From CL-Script
//===============================================================*
dcl-proc f_getCmd;
  dcl-pi *n like(bool_t);
    io_cmdString like(capcmd_t);
    i_strSeq     like(srcSeq_t) value;
    i_endSeq     like(srcSeq_t) value;
  end-pi;

  dcl-s concat char(1) inz;

  dcl-s isOK like(bool_t) inz(cFalse);
  dcl-s cmdString varchar(32767) inz;

  //---------------------------------------------------------------

  //  Initialisierung
  cmdString = '';
  concat    = '+';

  isOK = cTrue;

  //  Lesen, bis das Ende des Befehls erreicht wird ...
  for do_x1 = 1 to *HIVAL;
    Read SCRIPT ds_script;
    If %eof(SCRIPT);
      isOK = cFalse;
      Leave;
    Endif;

    //  ... lesen, bis Endezeile erreicht ist
    If ds_srcSeq > i_endSeq;
      Iter;
    Endif;

    //  ... überlesen, bis Startzeile gefunden ist
    If ds_srcSeq < i_strSeq;
      Iter;
    Endif;

    //  ... zusammenbauen Befehl
    Select;
    When concat = '+';
      cmdString = cmdString + %triml(ds_srcDta);
    When concat = '-';
      cmdString = cmdString + ds_srcDta;
    Other;
    //**
    Endsl;

    //  ... prüfen auf Fortsetzungszeile
    cmdString = %trimr(cmdString);

    //  ... prüfen auf Leerstring
    If %len(cmdString) = 0;
      Iter;
    Endif;

    Select;
    When f_right(cmdString: 1) = '+';
      concat = '+';
    When f_right(cmdString: 1) = '-';
      concat = '-';
    Other;
      concat = ' ';
    Endsl;

    //  ... Wenn keine Fortsetzungszeile erwartet wird, ...
    If concat = ' ';
      //      ... dann
      //          beenden Verarbeitung
      Leave;
    Else;
      //      ... sonst
      //          abschneiden Fortsetzungszeichen
      cmdString = %subst(cmdString: 1:
                        %len(cmdString) - 1);
    Endif;

  endfor;

  io_cmdString = %triml(cmdString);

  Return isOK;

end-proc;

//===============================================================*
//  Replace variables
//===============================================================*
dcl-proc p_replace;
  dcl-pi *n;
    io_string like(capcmd_t);
    i_var     char(10) value;
    i_value   char(256) value;
  end-pi;

  dcl-s x like(int4_t) inz;
  //---------------------------------------------------------------

  x = 0;

  DoU x = 0;

    If x > 0;
      io_string = %replace(%trim(i_value)    :
                          io_string         :
                          x                 :
                          %len(%trim(i_var)));
    Endif;

    x = %scan(%trim(i_var) :
             io_string    );
  Enddo;

  Return;

end-proc;

//===============================================================*
//  Monitor Message
//===============================================================*
dcl-proc f_monMsg;
  dcl-pi *n like(bool_t);
    i_msgID      like(msg_t.id) value;
    i_strSeq     like(srcSeq_t) value;
    i_endSeq     like(srcSeq_t) value;
    i_rplVarData likeds(rplVarData_t) value;
  end-pi;

  //  Deklarieren Funktionswert
  dcl-s isMonitored like(bool_t) inz(cFalse);

  //  Arbeitsfelder
  dcl-s cmdString like(capcmd_t);
  dcl-s msgIdStr like(capcmd_t);
  dcl-s cmdToken like(cmdToken_t);
  dcl-s x like(int4_t);
  dcl-s pToken pointer inz;
  //---------------------------------------------------------------

  //  Vorbelegen "isMonitored" mit "Nein"
  isMonitored = cFalse;

  DoW f_getCmd(cmdString: i_strSeq: i_endSeq);

    //  Entfernen Remarks ...
    cmdString = f_rmvRemCl(cmdString);
    If %trim(cmdString) = '';
      Iter;
    Endif;

    //  Ersetzen Variablen
    cmdString = f_rplVars(cmdString   :
                         i_rplVarData);

    cmdString = %trim(cmdString);

    If (cmdString = cBeginSQL) or
       (cmdString = cEndSQL  );
      Leave;
    Endif;

    cmdString = f_fmtCmd(cmdString);
    f_rtvCmdToken(cmdString: cmdToken);
    If cmdToken <> 'MONMSG';
      Leave;
    Endif;

    If f_rtvCmdParm(cmdString: msgIdStr);

      //  Extrahieren Daten des Schlüsselworts MSGID
      msgIdStr =
      f_rtvKeyWrdDta(f_rtvKeyWrd('MSGID':msgIdStr));

      If msgIdStr <> '';
        pToken = f_getToken(msgIdStr: ' ');

        Dow (pToken      <> *null )  and
           (isMonitored =  cFalse);
          If f_cmpMonMsgId(%str(pToken): i_msgId);
            isMonitored = cTrue;
          Endif;
          pToken = f_getToken(*null: ' ');
        Enddo;

      Endif;
    Endif;

    If isMonitored;
      Leave;
    Endif;
  Enddo;

  Return isMonitored;

end-proc;

//===============================================================*
//  Ermitteln Befehls-Token (OS/400 Befehl)
//===============================================================*
dcl-proc f_rtvCmdToken;
  dcl-pi *n like(bool_t);
    i_cmdString like(capcmd_t) value;
    o_cmdToken  like(cmdToken_t);
  end-pi;

  //  Deklarieren Funktionswert
  dcl-s isToken like(bool_t) inz;

  //  Arbeitsfelder
  dcl-s x like(int4_t) inz;
  dcl-s cmdString like(capcmd_t) inz;
  dcl-s cmdToken like(cmdToken_t) inz;
  //---------------------------------------------------------------

  cmdString = %triml(i_cmdString);

  x = %scan(' ': cmdString);
  x = x - 1;

  If (x >  %len(cmdToken))  or
     (x <= 0               );
    isToken = cFalse;
  Else;
    cmdToken = %subst(cmdString: 1: x);
    If f_right(%trimr(cmdToken): 1) = ':';
      isToken = cFalse;
    Else;
      isToken = cTrue;
    Endif;
  Endif;

  If isToken;
    o_cmdToken = cmdToken;
  Else;
    o_cmdToken = ' ';
  Endif;

  Return isToken;

end-proc;

//===============================================================*
//  Ermitteln Befehls-Parameter
//===============================================================*
dcl-proc f_rtvCmdParm;
  dcl-pi *n like(bool_t);
    i_cmdString like(capcmd_t) value;
    o_cmdParm   like(capcmd_t);
  end-pi;

  //  Deklarieren Funktionswert
  dcl-s isParm like(bool_t) inz;

  //  Arbeitsfelder
  dcl-s x like(int4_t) inz;
  dcl-s cmdString like(capcmd_t) inz;
  //---------------------------------------------------------------

  cmdString = %triml(i_cmdString);

  x = %scan(' ': cmdString);

  If (x >  %len(o_cmdParm))  or
     (x <= 0            );
    o_cmdParm = '';
    isParm  = cFalse;
  Else;
    o_cmdParm = %triml(%subst(cmdString: x));
    isParm  = cTrue;
  Endif;

  Return isParm;

end-proc;

// =============================================================
//  Extrahieren Befehlsschlüsselwort
// =============================================================
dcl-proc f_rtvKeyWrd;
  dcl-pi *n like(capcmd_t);
    i_keyWrd char(10) value;
    i_cmd    like(capcmd_t) value;
  end-pi;

  //  Funktionswert
  dcl-s keyWrdStr like(capcmd_t) inz;

  //  Arbeitsfelder
  dcl-s startPos like(int4_t) inz;
  dcl-s dataLen like(int4_t) inz;
  dcl-s x like(int4_t) inz;
  dcl-s y like(int4_t) inz;
  dcl-s token varchar(11) inz;
  dcl-s endPos like(int4_t) inz;
  dcl-s numBracket like(int4_t) inz;
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

  token = %trim(i_keyWrd) + '(';

  //  suchen Schlüsselwort im vorhandenen Befehlstring
  startPos = %scan(token: i_cmd);

  //  Wenn das Schlüsselwort gefunden werden konnte, ...
  If startPos > 0;
    //  ... dann
    //      ermitteln Länge des Schlüsselwortes ...
    x          = startPos + %len(token);
    numBracket = 1;
    dataLen    = %len(token);
    endPos     = %len(%trimr(i_cmd));

    for y = x to endPos;

      DataLen = DataLen + 1;
      //      ... '('
      If %subst(i_cmd: y: 1) = '(';
        numBracket = numBracket + 1;
        Iter;
      Endif;
      //      ... ')'
      If %subst(i_cmd: y: 1) = ')';
        numBracket = numBracket - 1;
        Iter;
      Endif;
      //      ... gefunden
      If numBracket <= 0;
        Leave;
      Endif;

    endfor;

    //      Wenn der Klammernzähler <> 0 ist, ...
    If numBracket <> 0;
      //      ... dann
      //          konnte das Ende des Schlüsselwortes
      //          nicht gefunden werden
      keyWrdStr = '';
    Else;
      keyWrdStr = %subst(i_cmd: startPos: dataLen);
    Endif;

  Else;
    keyWrdStr = '';
  Endif;

  Return keyWrdStr;

end-proc;

// =============================================================
//  Extrahieren Befehlsschlüsselwort Daten
// =============================================================
dcl-proc f_rtvKeyWrdDta;
  dcl-pi *n like(capcmd_t);
    i_keyWrd like(capcmd_t) value;
  end-pi;

  //  Funktionswert
  dcl-s keyWrdDta like(capcmd_t) inz;

  //  Arbeitsfelder
  dcl-s startPos like(int4_t) inz;
  dcl-s dataLen like(int4_t) inz;
  dcl-s x like(int4_t) inz;
  dcl-s y like(int4_t) inz;
  dcl-s token varchar(11) inz;
  dcl-s endPos like(int4_t) inz;
  dcl-s numBracket like(int4_t) inz;
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

  token = '(';

  //  suchen Schlüsselwortdaten im vorhandenen Befehlstring
  startPos = %scan(token: i_keyWrd);

  //  Wenn das Schlüsselwort gefunden werden konnte, ...
  If (startPos > 0)  and
     (f_right(%trimr(i_keyWrd): 1) = ')');
    //  ... dann
    //      ermitteln Länge des Schlüsselwortes ...
    startPos   = startPos + %len(token);
    endPos     = %len(%trimr(i_keyWrd)) - 1;
    dataLen    = endPos - startPos + 1;

    keyWrdDta =
             %subst(i_keyWrd: startPos: dataLen);
  Else;
    keyWrdDta = '';
  Endif;

  Return keyWrdDta;

end-proc;

// =============================================================
//  Konvertieren in Grossbuchstaben
// =============================================================
dcl-proc f_ucase;
  dcl-pi *n char(2048);
    i_lower char(2048) value;
  end-pi;

  //  Funktionswert
  dcl-s upper char(2048) inz;

  //  Konvertierungstabellen
  dcl-c lc 'abcdefghijklmnopqrstuvwxyz';
  dcl-c uc 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

  %subst(upper:1:%size(i_lower)) =
  %xlate(lc:uc:i_lower);

  Return upper;

end-proc;

// =============================================================
//  Ersetzen Variablen
// =============================================================
dcl-proc f_rplVars;
  dcl-pi *n like(capcmd_t);
    i_cmdString  like(capcmd_t) value;
    i_rplVarData likeds(rplVarData_t) value;
  end-pi;

  //  Funktionswert
  dcl-s cmdString like(capcmd_t) inz;
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

  cmdString = i_cmdString;

  //  Ersetzen Lib         (&LI)
  If i_rplVarData.xLib <> cNONE;
    p_replace(cmdString: '&LI': i_rplVarData.xLib);
  Endif;

  //  Ersetzen Objekt      (&OB)
  If i_rplVarData.xObj <> cNONE;
    p_replace(cmdString: '&OB': i_rplVarData.xObj);
  Endif;

  //  Ersetzen Type Code   (&TY)
  If i_rplVarData.xTypeCode <> cNONE;
    p_replace(cmdString: '&TY': i_rplVarData.xTypeCode);
  Endif;

  //  Ersetzen Source Lib  (&SL)
  If i_rplVarData.xSrcLib <> cNONE;
    p_replace(cmdString: '&SL': i_rplVarData.xSrcLib);
  Endif;

  //  Ersetzen Source File (&SF)
  If i_rplVarData.xSrcFile <> cNONE;
    p_replace(cmdString: '&SF': i_rplVarData.xSrcFile);
  Endif;

  //  Ersetzen Source Mbr  (&SM)
  If i_rplVarData.xSrcMbr <> cNONE;
    p_replace(cmdString: '&SM': i_rplVarData.xSrcMbr);
  Endif;

  //  Ersetzen Test Lib    (&TL)
  If i_rplVarData.xTestLib <> cNONE;
    p_replace(cmdString: '&TL': i_rplVarData.xTestLib);
  Endif;

  //  Ersetzen Test Object (&TO)
  If i_rplVarData.xTestObj <> cNONE;
    p_replace(cmdString: '&TO': i_rplVarData.xTestObj);
  Endif;

  //  Ersetzen Taget Rel.  (&TO)
  If i_rplVarData.xTgtRls <> cNONE;
    p_replace(cmdString: '&TR': i_rplVarData.xTgtRls);
  Endif;

  //  Ersetzen From Src Lib  (&SL)
  If i_rplVarData.xFrmSrcLib <> cNONE;
    p_replace(cmdString: '&FL': i_rplVarData.xFrmSrcLib);
  Endif;

  //  Ersetzen From Src File (&SF)
  If i_rplVarData.xFrmSrcFile <> cNONE;
    p_replace(cmdString: '&FF': i_rplVarData.xFrmSrcFile);
  Endif;

  //  Ersetzen From Src Mbr  (&SM)
  If i_rplVarData.xFrmSrcMbr <> cNONE;
    p_replace(cmdString: '&FM': i_rplVarData.xFrmSrcMbr);
  Endif;

  //  Ersetzen Parameter  (&USER0)
  If i_rplVarData.xUser0 <> cNONE;
    p_replace(cmdString: '&U0': i_rplVarData.xUser0);
  Endif;

  //  Ersetzen Parameter  (&USER1)
  If i_rplVarData.xUser1 <> cNONE;
    p_replace(cmdString: '&U1': i_rplVarData.xUser1);
  Endif;

  //  Ersetzen Parameter  (&USER2)
  If i_rplVarData.xUser2 <> cNONE;
    p_replace(cmdString: '&U2': i_rplVarData.xUser2);
  Endif;

  //  Ersetzen Parameter  (&USER3)
  If i_rplVarData.xUser3 <> cNONE;
    p_replace(cmdString: '&U3': i_rplVarData.xUser3);
  Endif;

  //  Ersetzen Parameter  (&USER4)
  If i_rplVarData.xUser4 <> cNONE;
    p_replace(cmdString: '&U4': i_rplVarData.xUser4);
  Endif;

  //  Ersetzen Parameter  (&USER5)
  If i_rplVarData.xUser5 <> cNONE;
    p_replace(cmdString: '&U5': i_rplVarData.xUser5);
  Endif;

  //  Ersetzen Parameter  (&USER6)
  If i_rplVarData.xUser6 <> cNONE;
    p_replace(cmdString: '&U6': i_rplVarData.xUser6);
  Endif;

  //  Ersetzen Parameter  (&USER7)
  If i_rplVarData.xUser7 <> cNONE;
    p_replace(cmdString: '&U7': i_rplVarData.xUser7);
  Endif;

  //  Ersetzen Parameter  (&USER8)
  If i_rplVarData.xUser8 <> cNONE;
    p_replace(cmdString: '&U8': i_rplVarData.xUser8);
  Endif;

  //  Ersetzen Parameter  (&USER9)
  If i_rplVarData.xUser9 <> cNONE;
    p_replace(cmdString: '&U9': i_rplVarData.xUser9);
  Endif;

  Return cmdString;

end-proc;

// =============================================================
//  Abnormal End Procedure
// =============================================================
dcl-proc p_abnEndProc;
  dcl-pi *n;
    i_token pointer const;
  end-pi;
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

  If g_isSqlOpn;
    p_cloSql();
    g_isSqlOpn = cFalse;
  Endif;

  Return;

end-proc;

