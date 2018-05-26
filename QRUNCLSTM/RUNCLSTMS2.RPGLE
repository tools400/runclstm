      * =================================================================== *
      *                                                                     *
      *  Kurzdokumentation :                                                *
      *                                                                     *
      *  Bereich . . . : RUNCLSTM                                           *
      *  Objekt  . . . : RUNCLSTMS2                                         *
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
      *  03.05.2002  Th.Raddatz    Changed RUNCLSTM to use SQL-CLI.         *
      *  19.06.2002  Th.Raddatz    Fixed error in f_sqlErrMsg() to          *
      *                            get the correct SQL message ID.          *
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
      /COPY QRUNCLSTM,SQLCLI
      *
      *===============================================================*
      *  Nachrichten
      *===============================================================*
      *
      *===============================================================*
      *  Public Prototypes
      *===============================================================*
      /COPY QRUNCLSTM,RUNCLSTMG1
      /COPY QRUNCLSTM,RUNCLSTMG2
      *
      *===============================================================*
      *  Globale Variablen
      *===============================================================*
     D g_henv          S                   like(SQLHENV_t  ) inz
     D g_hdbc          S                   like(SQLHDBC_t )  inz
     D g_hstmt         S                   like(SQLHSTMT_t)  inz
      *
      *===============================================================*
      *  Public Prototypes
      *===============================================================*
      *
      *===============================================================*
      *  Private Prototypes
      *===============================================================*
      *
      *  Is SQL Error
     D f_isSqlErr      PR                        like(bool_t      )
     D  i_rc                               value like(SQLRETCODE_t)
     D  o_msg                                    like(msg_t       )
      *
      *  Get SQL MsgID
     D f_sqlErrMsg     PR                        like(msg_t     )
      *
      *===================================================================*
      *  Prozedur:  f_opnSQL                                   (Body)     *
      *===================================================================*
      *
     P f_opnSQL        B                   export
      *
      *  definieren Procedure Interface ...
     D f_opnSQL        PI                         like(bool_t    )
     D  i_naming                           const  like(naming_t  )
     D  o_msg                                     like(msg_t     )
      *
      *  definieren Funktionswert ...
     D f_opnSQL        S                   like(bool_t    ) inz
      *
      *  lokale variablen ...
     D rc              S                   like(SQLRETCODE_t) inz
     D connectAttr     S                   like(SQLINTEGER_t) inz
     D envAttr         S                   like(SQLINTEGER_t) inz
      * ------------------------------------------------------------------------
      *
      * EXEC SQL CONNECT TO :server USER :uid USING :authentication_string;
      * ... allocate an environment handle
     C                   Eval      rc = SQLAllocEnv (%addr(g_henv))
      *
     C                   If        f_isSqlErr(rc: o_msg)
     C                   Eval      f_opnSQL = cFalse
     C                   Callp     p_cloSQL
     C                   Goto      fkt_ende
     C                   Endif
      *
      * ... change environment attribute to requested naming standard
     C                   If        i_naming = '*SQL'
     C                   Eval      envAttr = SQL_FALSE
     C                   Else
     C                   Eval      envAttr = SQL_TRUE
     C                   Endif
     C                   Eval      rc = SQLSetEnvAttr(g_henv              :
     C                                                SQL_ATTR_SYS_NAMING :
     C                                                %addr(envAttr)      :
     C                                                %size(envAttr)      )
      *
     C                   If        f_isSqlErr(rc: o_msg)
     C                   Eval      f_opnSQL = cFalse
     C                   Callp     p_cloSQL
     C                   Goto      fkt_ende
     C                   Endif
      *
      * ... allocate a connection handle
     C                   Eval      rc = SQLAllocConnect (g_henv: %addr(g_hdbc))
      *
     C                   If        f_isSqlErr(rc: o_msg)
     C                   Eval      f_opnSQL = cFalse
     C                   Callp     p_cloSQL
     C                   Goto      fkt_ende
     C                   Endif
      *
      * ... change connection attribute to not use committment control
     C                   Eval      connectAttr = SQL_TXN_NO_COMMIT
     C                   Eval      rc = SQLSetConnectAttr(g_hdbc            :
     C                                                    SQL_ATTR_COMMIT   :
     C                                                    %addr(connectAttr):
     C                                                    %size(connectAttr))
      *
     C                   If        f_isSqlErr(rc: o_msg)
     C                   Eval      f_opnSQL = cFalse
     C                   Callp     p_cloSQL
     C                   Goto      fkt_ende
     C                   Endif
      *
      * ... connect to database indicated by "server" variable
      *     and current user profile
     C                   Eval      rc = SQLConnect (g_hdbc  :
     C                                              '*LOCAL': SQL_NTS:
     C                                              *null   : SQL_NTS:
     C                                              *null   : SQL_NTS)
      *
     C                   If        f_isSqlErr(rc: o_msg)
     C                   Eval      f_opnSQL = cFalse
     C                   Callp     p_cloSQL
     C                   Goto      fkt_ende
     C                   Endif
      *
      * ... allocate a statement handle
     C                   Eval      rc = SQLAllocStmt (g_hdbc: %addr(g_hstmt))
      *
     C                   If        f_isSqlErr(rc: o_msg)
     C                   Eval      f_opnSQL = cFalse
     C                   Callp     p_cloSQL
     C                   Goto      fkt_ende
     C                   Endif
      *
     C                   Eval      f_opnSQL = cTrue
      *
     C     fkt_ende      Tag
      *
     C                   Return    f_opnSQL
      *
     P f_opnSQL        E
      *
      *===============================================================*
      *  Execute SQL statement
      *===============================================================*
     P f_executeSQL...
     P                 B                   export
      *
     D f_executeSQL...
     D                 PI                  opdesc like(bool_t    )
     D  i_sqlStmt                          const  like(capCmd_t  )
     D                                     options(*varsize)
     D  o_msg                                     like(msg_t     )
      *
      *  Definieren Funktionswert
     D isOK            S                   like(bool_t    )
     D                                     inz
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
      *  Hilfsfelder für Funktion: p_TestOmit
     D isPresent       S                   like(int4_t      )
     D                                     inz
      *
      *  Arbeitsfelder
     D sqlStmt         S                   like(i_sqlStmt   ) inz
     D rc              S                   like(SQLRETCODE_t) inz
      *---------------------------------------------------------------
      *
     C                   Callp     p_getOpDesc(1: descType: dataType:
     C                                            descInf1: descInf2:
     C                                            dataLen:  feedBack)
      *
     C                   Eval      sqlStmt = %subst(i_sqlStmt: 1: dataLen)
      *
      *  ausführen SQL Anweisung
     C                   Eval      rc = SQLExecDirect(g_hstmt        :
     C                                                %trim(sqlStmt) :
     C                                                SQL_NTS        )
     C                   If        f_isSqlErr(rc: o_msg)
     C                   Eval      isOK = cFalse
     C                   Else
     C                   Eval      isOK = cTrue
     C                   Endif
      *
     C                   Return    isOK
      *
     P f_executeSQL...
     P                 E
      *
      *===================================================================*
      *  Prozedur:  p_cloSQL                                   (Body)     *
      *===================================================================*
      *
     P p_cloSQL        B                   export
      *
      *  definieren Procedure Interface ...
     D p_cloSQL        PI
      *
      *  lokale variablen ...
     D rc              S                   like(SQLRETCODE_t) inz
     D msg             S                   like(msg_t       ) inz
      * ------------------------------------------------------------------------
      *
      * EXEC SQL CLOSE c1;
      * ... free the statement handle
     C                   If        g_hstmt <> 0
     C                   Eval      rc = SQLFreeStmt(g_hstmt: SQL_DROP)
     C                   Endif
      *
      * EXEC SQL DISCONNECT;
      * disconnect from the database
     C                   If        g_hdbc <> 0
     C                   Eval      rc = SQLDisconnect(g_hdbc)
     C                   Endif
      *
      * free the connection handle
     C                   If        g_hdbc <> 0
     C                   Eval      rc = SQLFreeConnect(g_hdbc)
     C                   Endif
      *
      * free the environment handle
     C                   If        g_henv <> 0
     C                   Eval      rc = SQLFreeEnv(g_henv)
     C                   Endif
      *
     C                   Reset                   g_hstmt
     C                   Reset                   g_hdbc
     C                   Reset                   g_henv
      *
     C                   Return
      *
     P p_cloSQL        E
      *
      *===================================================================*
      *  Private:
      *  Prozedur:  f_isSqlErr
      *===================================================================*
      *
     P f_isSqlErr      B
      *
      *  definieren Procedure Interface ...
     D f_isSqlErr      PI                        like(bool_t      )
     D  i_rc                               value like(SQLRETCODE_t)
     D  o_msg                                    like(msg_t       )
      *
      *  definieren Funktionswert ...
     D f_isSqlErr      S                   like(bool_t    )
      *
      *  lokale Arbeitsfelder
      * ------------------------------------------------------------------------
      *
     C                   If        (i_rc <> SQL_SUCCESS          )  and
     C                             (i_rc <> SQL_SUCCESS_WITH_INFO)
     C                   Eval      f_isSqlErr = cTrue
     C                   Eval      o_msg      = f_sqlErrMsg
     C                   Else
     C                   Eval      f_isSqlErr = cFalse
     C                   Eval      o_msg      = f_newMsg(' ')
     C                   Endif
      *
     C                   Return    f_isSqlErr
      *
     P f_isSqlErr      E
      *
      *===================================================================*
      *  Prozedur:  f_sqlErrMsg                                (Body)     *
      *===================================================================*
      *
     P f_sqlErrMsg     B
      *
      *  definieren Procedure Interface ...
     D f_sqlErrMsg     PI                        like(msg_t     )
      *
      *  definieren Funktionswert ...
     D f_sqlErrMsg     S                   like(msg_t     ) inz
      *
      *  lokale variablen ...
      *  ... buffer = SQL_MAX_MESSAGE_LENGTH + 1
     D buffer          S            513A
     D sqlState        S              5A
     D sqlCode         S                   like(SQLINTEGER_t )
     D length          S                   like(SQLSMALLINT_t)
     D msgID           DS
     D  msgID_prefix                  3A
     D  msgID_num                     4S 0
      * ------------------------------------------------------------------------
      *
     C                   If        SQLError(SQL_NULL_HENV: g_hdbc: g_hstmt:
     C                                      %addr(sqlState) :
     C                                      %addr(sqlCode)  :
     C                                      %addr(buffer)   :
     C                                      %size(buffer)   :
     C                                      %addr(length)        ) = SQL_SUCCESS
     C                   Eval      msgID_prefix = 'SQL'
     C                   Eval      msgID_num    = %abs(sqlCode)
     C                   Eval      f_sqlErrMsg = f_newMsg(msgID               :
     C                                                    cMsg_TypEscape      :
     C                                                    %str(%addr(buffer)) :
     C                                                    'QSQLMSG'           :
     C                                                    '*LIBL'             )
     C                   Else
     C                   Eval      f_sqlErrMsg = f_newMsg(' ')
     C                   Endif
      *
     C                   Return    f_sqlErrMsg
      *
     P f_sqlErrMsg     E
      *
