**free
// =================================================================== *
//                                                                     *
//  Kurzdokumentation :                                                *
//                                                                     *
//  Bereich . . . : RUNCLSTM                                           *
//  Objekt  . . . : RUNCLSTMS2                                         *
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
//  03.05.2002  Th.Raddatz    Changed RUNCLSTM to use SQL-CLI.         *
//  19.06.2002  Th.Raddatz    Fixed error in f_sqlErrMsg() to          *
//                            get the correct SQL message ID.          *
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
ctl-opt nomain;
/copy QRUNCLSTM,COPYRIGHT
// =================================================================== *

/copy QRUNCLSTM,RUNCLSTMG3
/copy QRUNCLSTM,SQLCLI

//===============================================================*
//  Nachrichten
//===============================================================*

//===============================================================*
//  Public Prototypes
//===============================================================*
/copy QRUNCLSTM,RUNCLSTMG1
/copy QRUNCLSTM,RUNCLSTMG2

//===============================================================*
//  Globale Variablen
//===============================================================*
dcl-s g_henv like(SQLHENV_t) inz;
dcl-s g_hdbc like(SQLHDBC_t) inz;
dcl-s g_hstmt like(SQLHSTMT_t) inz;

//===============================================================*
//  Public Prototypes
//===============================================================*

//===============================================================*
//  Private Prototypes
//===============================================================*

//  Is SQL Error
dcl-pr f_isSqlErr like(bool_t);
  i_rc  like(SQLRETCODE_t) value;
  o_msg like(msg_t);
end-pr;

//  Get SQL MsgID
dcl-pr f_sqlErrMsg like(msg_t);
end-pr;

//===================================================================*
//  Prozedur:  f_opnSQL                                   (Body)     *
//===================================================================*

dcl-proc f_opnSQL export;

  //  definieren Procedure Interface ...
  dcl-pi *n like(bool_t);
    i_naming like(naming_t) const;
    o_msg    likeds(msg_t);
  end-pi;

  //  lokale variablen ...
  dcl-s rc like(SQLRETCODE_t) inz;
  dcl-s connectAttr like(SQLINTEGER_t) inz;
  dcl-s envAttr like(SQLINTEGER_t) inz;
  // ------------------------------------------------------------------------

  // EXEC SQL CONNECT TO :server USER :uid USING :authentication_string;
  // ... allocate an environment handle
  rc = SQLAllocEnv (%addr(g_henv));

  If f_isSqlErr(rc: o_msg);
    p_cloSQL();
    return cFalse;
  Endif;

  // ... change environment attribute to requested naming standard
  If i_naming = '*SQL';
    envAttr = SQL_FALSE;
  Else;
    envAttr = SQL_TRUE;
  Endif;
  rc = SQLSetEnvAttr(g_henv: SQL_ATTR_SYS_NAMING: %addr(envAttr): %size(envAttr));

  If f_isSqlErr(rc: o_msg);
    p_cloSQL();
    return cFalse;
  Endif;

  // ... allocate a connection handle
  rc = SQLAllocConnect (g_henv: %addr(g_hdbc));

  If f_isSqlErr(rc: o_msg);
    p_cloSQL();
    return cFalse;
  Endif;

  // ... change connection attribute to not use committment control
  connectAttr = SQL_TXN_NO_COMMIT;
  rc = SQLSetConnectAttr(g_hdbc: SQL_ATTR_COMMIT: %addr(connectAttr): %size(connectAttr));

  If f_isSqlErr(rc: o_msg);
    p_cloSQL();
    return cFalse;
  Endif;

  // ... connect to database indicated by "server" variable
  //     and current user profile
  rc = SQLConnect (g_hdbc: '*LOCAL': SQL_NTS: *null: SQL_NTS: *null: SQL_NTS);

  If f_isSqlErr(rc: o_msg);
    p_cloSQL();
    return cFalse;
  Endif;

  // ... allocate a statement handle
  rc = SQLAllocStmt (g_hdbc: %addr(g_hstmt));

  If f_isSqlErr(rc: o_msg);
    p_cloSQL();
    return cFalse;
  Endif;


  return cTrue;

end-proc;

//===============================================================*
//  Execute SQL statement
//===============================================================*
dcl-proc f_executeSQL export;
  dcl-pi *n opdesc like(bool_t);
    i_sqlStmt like(capCmd_t) options(*varsize) const;
    o_msg     likeds(msg_t);
  end-pi;

  //  Definieren Funktionswert
  dcl-s isOK like(bool_t) inz;

  //  Definieren Parameter für p_getOpDesc
  dcl-s descType inz like(int4_t);
  dcl-s datatype inz like(int4_t);
  dcl-s descInf1 inz like(int4_t);
  dcl-s descInf2 inz like(int4_t);
  dcl-s dataLen inz like(int4_t);
  dcl-s feedBack inz like(fc_t);

  //  Arbeitsfelder
  dcl-s sqlStmt like(i_sqlStmt) inz;
  dcl-s rc like(SQLRETCODE_t) inz;
  //---------------------------------------------------------------

  p_getOpDesc(1: descType: dataType:
                 descInf1: descInf2:
                 dataLen:  feedBack);

  sqlStmt = %subst(i_sqlStmt: 1: dataLen);

  //  ausführen SQL Anweisung
  rc = SQLExecDirect(g_hstmt: %trim(sqlStmt): SQL_NTS);
  If f_isSqlErr(rc: o_msg);
    isOK = cFalse;
  Else;
    isOK = cTrue;
  Endif;

  return isOK;

end-proc;

//===================================================================*
//  Prozedur:  p_cloSQL                                   (Body)     *
//===================================================================*

dcl-proc p_cloSQL export;

  //  definieren Procedure Interface ...
  dcl-pi *n;
  end-pi;

  //  lokale variablen ...
  dcl-s rc like(SQLRETCODE_t) inz;
  dcl-s msg like(msg_t) inz;
  // ------------------------------------------------------------------------

  // EXEC SQL CLOSE c1;
  // ... free the statement handle
  If g_hstmt <> 0;
    rc = SQLFreeStmt(g_hstmt: SQL_DROP);
  Endif;

  // EXEC SQL DISCONNECT;
  // disconnect from the database
  If g_hdbc <> 0;
    rc = SQLDisconnect(g_hdbc);
  Endif;

  // free the connection handle
  If g_hdbc <> 0;
    rc = SQLFreeConnect(g_hdbc);
  Endif;

  // free the environment handle
  If g_henv <> 0;
    rc = SQLFreeEnv(g_henv);
  Endif;

  Reset g_hstmt;
  Reset g_hdbc;
  Reset g_henv;

  return;

end-proc;

//===================================================================*
//  Private:
//  Prozedur:  f_isSqlErr
//===================================================================*

dcl-proc f_isSqlErr;

  //  definieren Procedure Interface ...
  dcl-pi *n like(bool_t);
    i_rc  like(SQLRETCODE_t) value;
    o_msg like(msg_t);
  end-pi;

  //  definieren Funktionswert ...
  dcl-s f_isSqlErr like(bool_t);

  //  lokale Arbeitsfelder
  // ------------------------------------------------------------------------

  If (i_rc <> SQL_SUCCESS) and (i_rc <> SQL_SUCCESS_WITH_INFO);
    f_isSqlErr = cTrue;
    o_msg = f_sqlErrMsg;
  Else;
    f_isSqlErr = cFalse;
    o_msg = f_newMsg('');
  Endif;

  return f_isSqlErr;

end-proc;

//===================================================================*
//  Prozedur:  f_sqlErrMsg                                (Body)     *
//===================================================================*

dcl-proc f_sqlErrMsg;

  //  definieren Procedure Interface ...
  dcl-pi *n like(msg_t);
  end-pi;

  //  definieren Funktionswert ...
  dcl-s f_sqlErrMsg like(msg_t) inz;

  //  lokale variablen ...
  //  ... buffer = SQL_MAX_MESSAGE_LENGTH + 1
  dcl-s buffer char(513);
  dcl-s sqlState char(5);
  dcl-s sqlCode like(SQLINTEGER_t);
  dcl-s length like(SQLSMALLINT_t);
  dcl-ds msgID;
    msgID_prefix char(3);
    msgID_num    zoned(4);
  end-ds;
  // ------------------------------------------------------------------------

  If SQLError(SQL_NULL_HENV: g_hdbc: g_hstmt: %addr(sqlState): %addr(sqlCode)
              : %addr(buffer): %size(buffer): %addr(length)) = SQL_SUCCESS;
    msgID_prefix = 'SQL';
    msgID_num = %abs(sqlCode);
    f_sqlErrMsg = f_newMsg(msgID: cMsg_TypEscape: %str(%addr(buffer)): 'QSQLMSG': '*LIBL');
  Else;
    f_sqlErrMsg = f_newMsg('');
  Endif;

  return f_sqlErrMsg;

end-proc;

