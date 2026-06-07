**free
//** START HEADER FILE SPECIFICATIONS *****************************
//                                                                *
// Header File Name: SQLCLI                                       *
//                                                                *
// Descriptive Name: Structured Query Language (SQL) Call Level   *
//                   Interface.                                   *
//                                                                *
// 5716-SS1  (C) Copyright IBM Corp. 1995,1995                    *
// All rights reserved.                                           *
// US Government Users Restricted Rights -                        *
// Use, duplication or disclosure restricted                      *
// by GSA ADP Schedule Contract with IBM Corp.                    *
//                                                                *
// Licensed Materials-Property of IBM                             *
//                                                                *
//                                                                *
// Description: The SQL Call Level Interface provides access to   *
//              most SQL functions, without the need for a        *
//              precompiler.                                      *
//                                                                *
// Header Files Included: SQLCLI                                  *
//                                                                *
// Function Prototype List:  SQLAllocConnect                      *
//                           SQLAllocEnv                          *
//                           SQLAllocHandle                       *
//                           SQLAllocStmt                         *
//                           SQLBindCol                           *
//                           SQLBindFileToCol                     *
//                           SQLBindFileToParam                   *
//                           SQLBindParam                         *
//                           SQLBindParameter                     *
//                           SQLCancel                            *
//                           SQLCloseCursor                       *
//                           SQLColAttributes                     *
//                           SQLColumns                           *
//                           SQLConnect                           *
//                           SQLCopyDesc                          *
//                           SQLDataSources                       *
//                           SQLDescribeCol                       *
//                           SQLDescribeParam                     *
//                           SQLDisconnect                        *
//                           SQLDriverConnect                     *
//                           SQLEndTran                           *
//                           SQLError                             *
//                           SQLExecDirect                        *
//                           SQLExecute                           *
//                           SQLExtendedFetch                     *
//                           SQLFetch                             *
//                           SQLFetchScroll                       *
//                           SQLForeignKeys                       *
//                           SQLFreeConnect                       *
//                           SQLFreeEnv                           *
//                           SQLFreeHandle                        *
//                           SQLFreeStmt                          *
//                           SQLGetCol                            *
//                           SQLGetConnectOption                  *
//                           SQLGetCursorName                     *
//                           SQLGetConnectAttr                    *
//                           SQLGetData                           *
//                           SQLGetDescField                      *
//                           SQLGetDescRec                        *
//                           SQLGetDiagField                      *
//                           SQLGetDiagRec                        *
//                           SQLGetEnvAttr                        *
//                           SQLGetFunctions                      *
//                           SQLGetInfo                           *
//                           SQLGetLength                         *
//                           SQLGetPosition                       *
//                           SQLGetStmtAttr                       *
//                           SQLGetStmtOption                     *
//                           SQLGetSubString                      *
//                           SQLGetTypeInfo                       *
//                           SQLLanguages                         *
//                           SQLMoreResults                       *
//                           SQLNativeSql                         *
//                           SQLNumParams                         *
//                           SQLNumResultCols                     *
//                           SQLParamData                         *
//                           SQLParamOptions                      *
//                           SQLPrepare                           *
//                           SQLPrimaryKeys                       *
//                           SQLProcedureColumns                  *
//                           SQLProcedures                        *
//                           SQLPutData                           *
//                           SQLReleaseEnv                        *
//                           SQLRowCount                          *
//                           SQLSetConnectAttr                    *
//                           SQLSetConnectOption                  *
//                           SQLSetCursorName                     *
//                           SQLSetDescField                      *
//                           SQLSetDescRec                        *
//                           SQLSetEnvAttr                        *
//                           SQLSetParam                          *
//                           SQLSetStmtAttr                       *
//                           SQLSetStmtOption                     *
//                           SQLSpecialColumns                    *
//                           SQLStatistics                        *
//                           SQLTables                            *
//                           SQLTransact                          *
//                                                                *
// Change Activity:                                               *
//                                                                *
// CFD List:                                                      *
//                                                                *
// FLAG REASON       LEVEL DATE   PGMR      CHANGE DESCRIPTION    *
// ---- ------------ ----- ------ --------- ----------------------*
// $A0= D91823       3D60  941206 MEGERIAN  New Include           *
// $A1= D94881       4D20  960816 MEGERIAN  V4R2M0 enhancements   *
// $A2= D95600       4D30  970910 MEGERIAN  V4R3M0 enhancements   *
// $A3= P3682850     4D40  981030 MEGERIAN  V4R4M0 enhancements   *
// $A4= D97596       4D50  990326 LJAMESON  V4R5M0 enhancements   *
//                                                                *
// End CFD List.                                                  *
//                                                                *
//  Additional notes about the Change Activity                    *
// End Change Activity.                                           *
//*****************************************************************
//                                                                *
// Translated from SQLCLI.h V5R1 by Thomas Raddatz at tools400.de *
// Mail-to: <thomas.raddatz@tools400.de>                          *
//                                                                *
// SQLCLI.RPGLE is provided as is. There is no guarantee that     *
// there are no errors left and that it will work under all       *
// circumstances.                                                 *
//                                                                *
//** END HEADER FILE SPECIFICATIONS *******************************

/if NOT defined(SQL_H_SQLCLI)

// Permit duplicate Includes *
/define SQL_H_SQLCLI

// generally useful constants *
dcl-c SQL_FALSE 0;
dcl-c SQL_TRUE 1;
// NTS = Null Terminated string
dcl-c SQL_NTS -3;
// Size of SQLSTATE, not including null terminating byte
dcl-c SQL_SQLSTATE_SIZE 5;
dcl-c SQL_MAX_MESSAGE_LENGTH 512;

// RETCODE values
dcl-c SQL_SUCCESS 0;
dcl-c SQL_SUCCESS_WITH_INFO 1;
dcl-c SQL_NO_DATA_FOUND 100;
dcl-c SQL_NEED_DATA 99;
dcl-c SQL_NO_DATA 100;
dcl-c SQL_ERROR -1;
dcl-c SQL_INVALID_HANDLE -2;

// SQLFreeStmt option values
dcl-c SQL_CLOSE 0;
dcl-c SQL_DROP 1;
dcl-c SQL_UNBIND 2;
dcl-c SQL_RESET_PARAMS 3;

// SQLSetParam defines
dcl-c SQL_C_DEFAULT 99;

// SQLTransact option values
dcl-c SQL_COMMIT 0;
dcl-c SQL_ROLLBACK 1;
dcl-c SQL_COMMIT_HOLD 2;
dcl-c SQL_ROLLBACK_HOLD 3;

// SQLDriverConnect option values
dcl-c SQL_DRIVER_COMPLETE 1;
dcl-c SQL_DRIVER_COMPLETE_REQUIRED 1;
dcl-c SQL_DRIVER_NOPROMPT 1;

//  Valid option codes for GetInfo procedure
dcl-c SQL_ACTIVE_CONNECTIONS 0;
dcl-c SQL_ACTIVE_STATEMENTS 1;
dcl-c SQL_PROCEDURES 2;
dcl-c SQL_DBMS_NAME 17;
dcl-c SQL_DBMS_VER 18;
dcl-c SQL_MAX_COLUMN_NAME_LEN 30;
dcl-c SQL_MAX_CURSOR_NAME_LEN 31;
dcl-c SQL_MAX_OWNER_NAME_LEN 32;
dcl-c SQL_MAX_SCHEMA_NAME_LEN 33;
dcl-c SQL_MAX_TABLE_NAME_LEN 35;

// Standard SQL data types
dcl-c SQL_CHAR 1;
dcl-c SQL_NUMERIC 2;
dcl-c SQL_DECIMAL 3;
dcl-c SQL_INTEGER 4;
dcl-c SQL_SMALLINT 5;
dcl-c SQL_FLOAT 6;
dcl-c SQL_REAL 7;
dcl-c SQL_DOUBLE 8;
dcl-c SQL_DATETIME 9;
dcl-c SQL_VARCHAR 12;
dcl-c SQL_BLOB 13;
dcl-c SQL_CLOB 14;
dcl-c SQL_DBCLOB 15;
dcl-c SQL_DATALINK 16;
dcl-c SQL_WCHAR 17;
dcl-c SQL_WVARCHAR 18;
dcl-c SQL_BIGINT 19;
dcl-c SQL_BLOB_LOCATOR 20;
dcl-c SQL_CLOB_LOCATOR 21;
dcl-c SQL_DBCLOB_LOCATOR 22;
dcl-c SQL_WLONGVARCHAR 18;
dcl-c SQL_LONGVARCHAR 12;
dcl-c SQL_GRAPHIC 95;
dcl-c SQL_VARGRAPHIC 96;
dcl-c SQL_LONGVARGRAPHIC 96;
dcl-c SQL_BINARY 97;
dcl-c SQL_VARBINARY 98;
dcl-c SQL_LONGVARBINARY 98;
dcl-c SQL_DATE 91;
dcl-c SQL_TYPE_DATE 91;
dcl-c SQL_TIME 92;
dcl-c SQL_TYPE_TIME 92;
dcl-c SQL_TIMESTAMP 93;
dcl-c SQL_TYPE_TIMESTAMP 93;
dcl-c SQL_CODE_DATE 1;
dcl-c SQL_CODE_TIME 2;
dcl-c SQL_CODE_TIMESTAMP 3;
dcl-c SQL_ALL_TYPES 0;


// NULL status defines; these are used in SQLColAttributes, SQLDescribeCol,
// to describe the nullability of a column in a table.
dcl-c SQL_UNUSED 0;
dcl-c SQL_HANDLE_ENV 1;
dcl-c SQL_HANDLE_DBC 2;
dcl-c SQL_HANDLE_STMT 3;
dcl-c SQL_HANDLE_DESC 4;
dcl-c SQL_NULL_HANDLE 0;

dcl-c SQL_NO_NULLS 0;
dcl-c SQL_NULLABLE 1;
dcl-c SQL_NULLABLE_UNKNOWN 2;

// Special length values
dcl-c SQL_NULL_DATA -1;
dcl-c SQL_DATA_AT_EXEC -2;
dcl-c SQL_BIGINT_PREC 19;
dcl-c SQL_INTEGER_PREC 10;
dcl-c SQL_SMALLINT_PREC 5;

// SQLColAttributes defines */
dcl-c SQL_ATTR_READONLY 0;
dcl-c SQL_ATTR_WRITE 1;
dcl-c SQL_ATTR_READWRITE_UNKNOWN 2;

// Valid concurrency values
dcl-c SQL_CONCUR_LOCK 0;
dcl-c SQL_CONCUR_READ_ONLY 1;

//  Valid environment attributes
dcl-c SQL_ATTR_OUTPUT_NTS 10001;
dcl-c SQL_ATTR_SYS_NAMING 10002;
dcl-c SQL_ATTR_DEFAULT_LIB 10003;
dcl-c SQL_ATTR_SERVER_MODE 10004;
dcl-c SQL_ATTR_JOB_SORT_SEQUENCE 10005;
dcl-c SQL_ATTR_ENVHNDL_COUNTER 10009;
dcl-c SQL_ATTR_ESCAPE_CHAR 10010;

//  Valid environment/connection attributes
dcl-c SQL_ATTR_DATE_FMT 10020;
dcl-c SQL_ATTR_DATE_SEP 10021;
dcl-c SQL_ATTR_TIME_FMT 10022;
dcl-c SQL_ATTR_TIME_SEP 10023;
dcl-c SQL_ATTR_DECIMAL_SEP 10024;

//  Valid environment/connection values
dcl-c SQL_FMT_ISO 1;
dcl-c SQL_FMT_USA 2;
dcl-c SQL_FMT_EUR 3;
dcl-c SQL_FMT_JIS 4;
dcl-c SQL_FMT_MDY 5;
dcl-c SQL_FMT_DMY 6;
dcl-c SQL_FMT_YMD 7;
dcl-c SQL_FMT_JUL 8;
dcl-c SQL_FMT_HMS 9;
dcl-c SQL_FMT_JOB 10;
dcl-c SQL_SEP_SLASH 1;
dcl-c SQL_SEP_DASH 2;
dcl-c SQL_SEP_PERIOD 3;
dcl-c SQL_SEP_COMMA 4;
dcl-c SQL_SEP_BLANK 5;
dcl-c SQL_SEP_COLON 6;
dcl-c SQL_SEP_JOB 7;

//  Valid values for type in GetCol
dcl-c SQL_DEFAULT 99;
dcl-c SQL_ARD_TYPE -99;

//  Valid values for UPDATE_RULE and DELETE_RULE in SQLForeignKeys
dcl-c SQL_CASCADE 1;
dcl-c SQL_RESTRICT 2;
dcl-c SQL_NO_ACTION 3;
dcl-c SQL_SET_NULL 4;
dcl-c SQL_SET_DEFAULT 5;

//  Valid values for COLUMN_TYPE in SQLProcedureColumns
dcl-c SQL_PARAM_INPUT 1;
dcl-c SQL_PARAM_OUTPUT 2;
dcl-c SQL_PARAM_INPUT_OUTPUT 3;

// statement attributes
dcl-c SQL_ATTR_APP_ROW_DESC 10010;
dcl-c SQL_ATTR_APP_PARAM_DESC 10011;
dcl-c SQL_ATTR_IMP_ROW_DESC 10012;
dcl-c SQL_ATTR_IMP_PARAM_DESC 10013;
dcl-c SQL_ATTR_FOR_FETCH_ONLY 10014;
dcl-c SQL_ATTR_CONCURRENCY 10014;
dcl-c SQL_CONCURRENCY 10014;
dcl-c SQL_ATTR_CURSOR_SCROLLABLE 10015;
dcl-c SQL_ATTR_ROWSET_SIZE 10016;
dcl-c SQL_ROWSET_SIZE 10016;

//  Codes used in FetchScroll
dcl-c SQL_FETCH_NEXT 1;
dcl-c SQL_FETCH_FIRST 2;
dcl-c SQL_FETCH_LAST 3;
dcl-c SQL_FETCH_PRIOR 4;
dcl-c SQL_FETCH_ABSOLUTE 5;
dcl-c SQL_FETCH_RELATIVE 6;

// SQLColAttributes defines
dcl-c SQL_DESC_COUNT 1;
dcl-c SQL_DESC_TYPE 2;
dcl-c SQL_DESC_LENGTH 3;
dcl-c SQL_DESC_LENGTH_PTR 4;
dcl-c SQL_DESC_PRECISION 5;
dcl-c SQL_DESC_SCALE 6;
dcl-c SQL_DESC_DATETIME_INTERVAL_CODE 7;
dcl-c SQL_DESC_NULLABLE 8;
dcl-c SQL_DESC_INDICATOR_PTR 9;
dcl-c SQL_DESC_DATA_PTR 10;
dcl-c SQL_DESC_NAME 11;
dcl-c SQL_DESC_UNNAMED 12;
dcl-c SQL_DESC_DISPLAY_SIZE 13;
dcl-c SQL_DESC_ALLOC_TYPE 99;
dcl-c SQL_DESC_ALLOC_AUTO 1;
dcl-c SQL_DESC_ALLOC_USER 2;

dcl-c SQL_COLUMN_COUNT 1;
dcl-c SQL_COLUMN_TYPE 2;
dcl-c SQL_COLUMN_LENGTH 3;
dcl-c SQL_COLUMN_LENGTH_PTR 4;
dcl-c SQL_COLUMN_PRECISION 5;
dcl-c SQL_COLUMN_SCALE 6;
dcl-c SQL_COLUMN_DATETIME_INTERVAL_CODE 7;
dcl-c SQL_COLUMN_NULLABLE 8;
dcl-c SQL_COLUMN_INDICATOR_PTR 9;
dcl-c SQL_COLUMN_DATA_PTR 10;
dcl-c SQL_COLUMN_NAME 11;
dcl-c SQL_COLUMN_UNNAMED 12;
dcl-c SQL_COLUMN_DISPLAY_SIZE 13;
dcl-c SQL_COLUMN_ALLOC_TYPE 99;
dcl-c SQL_COLUMN_ALLOC_AUTO 1;
dcl-c SQL_COLUMN_ALLOC_USER 2;

//  Valid codes for SpecialColumns procedure
dcl-c SQL_SCOPE_CURROW 0;
dcl-c SQL_SCOPE_TRANSACTION 1;
dcl-c SQL_SCOPE_SESSION 2;
dcl-c SQL_PC_UNKNOWN 0;
dcl-c SQL_PC_NOT_PSEUDO 1;
dcl-c SQL_PC_PSEUDO 2;

//  Valid values for connect attribute
dcl-c SQL_ATTR_AUTO_IPD 10001;
dcl-c SQL_ATTR_ACCESS_MODE 10002;
dcl-c SQL_ACCESS_MODE 10002;
dcl-c SQL_ATTR_AUTOCOMMIT 10003;
dcl-c SQL_AUTOCOMMIT 10003;
dcl-c SQL_ATTR_DBC_SYS_NAMING 10004;
dcl-c SQL_ATTR_DBC_DEFAULT_LIB 10005;
dcl-c SQL_ATTR_COMMIT 0;
dcl-c SQL_MODE_READ_ONLY 0;
dcl-c SQL_MODE_READ_WRITE 1;
dcl-c SQL_MODE_DEFAULT 1;
dcl-c SQL_AUTOCOMMIT_OFF 0;
dcl-c SQL_AUTOCOMMIT_ON 1;
dcl-c SQL_TXN_ISOLATION 0;
dcl-c SQL_COMMIT_NONE 1;
dcl-c SQL_TXN_NO_COMMIT 1;
dcl-c SQL_TXN_NOCOMMIT 1;
dcl-c SQL_COMMIT_CHG 2;
dcl-c SQL_COMMIT_UR 2;
dcl-c SQL_TXN_READ_UNCOMMITTED 2;
dcl-c SQL_COMMIT_CS 3;
dcl-c SQL_TXN_READ_COMMITTED 3;
dcl-c SQL_COMMIT_ALL 4;
dcl-c SQL_COMMIT_RS 4;
dcl-c SQL_TXN_REPEATABLE_READ 4;
dcl-c SQL_COMMIT_RR 5;
dcl-c SQL_TXN_SERIALIZABLE 5;

//  Valid index flags
dcl-c SQL_INDEX_UNIQUE 0;
dcl-c SQL_INDEX_ALL 1;
dcl-c SQL_INDEX_OTHER 3;

//  Valid File Options
dcl-c SQL_FILE_READ 2;
dcl-c SQL_FILE_CREATE 8;
dcl-c SQL_FILE_OVERWRITE 16;
dcl-c SQL_FILE_APPEND 32;

// Valid types for GetDiagField
dcl-c SQL_DIAG_RETURNCODE 1;
dcl-c SQL_DIAG_NUMBER 2;
dcl-c SQL_DIAG_ROW_COUNT 3;
dcl-c SQL_DIAG_SQLSTATE 4;
dcl-c SQL_DIAG_NATIVE 5;
dcl-c SQL_DIAG_MESSAGE_TEXT 6;
dcl-c SQL_DIAG_DYNAMIC_FUNCTION 7;
dcl-c SQL_DIAG_CLASS_ORIGIN 8;
dcl-c SQL_DIAG_SUBCLASS_ORIGIN 9;
dcl-c SQL_DIAG_CONNECTION_NAME 10;
dcl-c SQL_DIAG_SERVER_NAME 11;


// SQLColAttributes defines
// These are also used by SQLGetInfo
dcl-c SQL_UNSEARCHABLE 0;
dcl-c SQL_LIKE_ONLY 1;
dcl-c SQL_ALL_EXCEPT_LIKE 2;
dcl-c SQL_SEARCHABLE 3;

// GetFunctions() values to identify CLI functions
dcl-c SQL_API_SQLALLOCCONNECT 1;
dcl-c SQL_API_SQLALLOCENV 2;
dcl-c SQL_API_SQLALLOCHANDLE 1001;
dcl-c SQL_API_SQLALLOCSTMT 3;
dcl-c SQL_API_SQLBINDCOL 4;
dcl-c SQL_API_SQLBINDFILETOCOL 2002;
dcl-c SQL_API_SQLBINDFILETOPARAM 2003;
dcl-c SQL_API_SQLBINDPARAM 1002;
dcl-c SQL_API_SQLBINDPARAMETER 1023;
dcl-c SQL_API_SQLCANCEL 5;
dcl-c SQL_API_SQLCLOSECURSOR 1003;
dcl-c SQL_API_SQLCOLATTRIBUTES 6;
dcl-c SQL_API_SQLCOLUMNS 40;
dcl-c SQL_API_SQLCONNECT 7;
dcl-c SQL_API_SQLCOPYDESC 1004;
dcl-c SQL_API_SQLDATASOURCES 57;
dcl-c SQL_API_SQLDESCRIBECOL 8;
dcl-c SQL_API_SQLDESCRIBEPARAM 58;
dcl-c SQL_API_SQLDISCONNECT 9;
dcl-c SQL_API_SQLDRIVERCONNECT 68;
dcl-c SQL_API_SQLENDTRAN 1005;
dcl-c SQL_API_SQLERROR 10;
dcl-c SQL_API_SQLEXECDIRECT 11;
dcl-c SQL_API_SQLEXECUTE 12;
dcl-c SQL_API_SQLEXTENDEDFETCH 1022;
dcl-c SQL_API_SQLFETCH 13;
dcl-c SQL_API_SQLFETCHSCROLL 1021;
dcl-c SQL_API_SQLFOREIGNKEYS 60;
dcl-c SQL_API_SQLFREECONNECT 14;
dcl-c SQL_API_SQLFREEENV 15;
dcl-c SQL_API_SQLFREEHANDLE 1006;
dcl-c SQL_API_SQLFREESTMT 16;
dcl-c SQL_API_SQLGETCOL 43;
dcl-c SQL_API_SQLGETCONNECTATTR 1007;
dcl-c SQL_API_SQLGETCONNECTOPTION 42;
dcl-c SQL_API_SQLGETCURSORNAME 17;
dcl-c SQL_API_SQLGETDATA 43;
dcl-c SQL_API_SQLGETDESCFIELD 1008;
dcl-c SQL_API_SQLGETDESCREC 1009;
dcl-c SQL_API_SQLGETDIAGFIELD 1010;
dcl-c SQL_API_SQLGETDIAGREC 1011;
dcl-c SQL_API_SQLGETENVATTR 1012;
dcl-c SQL_API_SQLGETFUNCTIONS 44;
dcl-c SQL_API_SQLGETINFO 45;
dcl-c SQL_API_SQLGETLENGTH 2004;
dcl-c SQL_API_SQLGETPOSITION 2005;
dcl-c SQL_API_SQLGETSTMTATTR 1014;
dcl-c SQL_API_SQLGETSTMTOPTION 46;
dcl-c SQL_API_SQLGETSUBSTRING 2006;
dcl-c SQL_API_SQLGETTYPEINFO 47;
dcl-c SQL_API_SQLLANGUAGES 2001;
dcl-c SQL_API_SQLMORERESULTS 61;
dcl-c SQL_API_SQLNATIVESQL 62;
dcl-c SQL_API_SQLNUMPARAMS 63;
dcl-c SQL_API_SQLNUMRESULTCOLS 18;
dcl-c SQL_API_SQLPARAMDATA 48;
dcl-c SQL_API_SQLPARAMOPTIONS 2007;
dcl-c SQL_API_SQLPREPARE 19;
dcl-c SQL_API_SQLPRIMARYKEYS 65;
dcl-c SQL_API_SQLPROCEDURECOLUMNS 66;
dcl-c SQL_API_SQLPROCEDURES 67;
dcl-c SQL_API_SQLPUTDATA 49;
dcl-c SQL_API_SQLRELEASEENV 1015;
dcl-c SQL_API_SQLROWCOUNT 20;
dcl-c SQL_API_SQLSETCONNECTATTR 1016;
dcl-c SQL_API_SQLSETCONNECTOPTION 50;
dcl-c SQL_API_SQLSETCURSORNAME 21;
dcl-c SQL_API_SQLSETDESCFIELD 1017;
dcl-c SQL_API_SQLSETDESCREC 1018;
dcl-c SQL_API_SQLSETENVATTR 1019;
dcl-c SQL_API_SQLSETPARAM 22;
dcl-c SQL_API_SQLSETSTMTATTR 1020;
dcl-c SQL_API_SQLSETSTMTOPTION 51;
dcl-c SQL_API_SQLSPECIALCOLUMNS 52;
dcl-c SQL_API_SQLSTATISTICS 53;
dcl-c SQL_API_SQLTABLES 54;
dcl-c SQL_API_SQLTRANSACT 23;

// NULL handle defines
dcl-c SQL_NULL_HENV 0;
dcl-c SQL_NULL_HDBC 0;
dcl-c SQL_NULL_HSTMT 0;

// C Data Types
dcl-s char_t char(1) based(pDummy);
dcl-s short_t int(5) based(pDummy);
dcl-s ushort_t uns(5) based(pDummy);
dcl-s int_t int(10) based(pDummy);
dcl-s uint_t uns(10) based(pDummy);
dcl-s long_t int(10) based(pDummy);
dcl-s ulong_t uns(10) based(pDummy);
dcl-s float_t float(4) based(pDummy);
dcl-s double_t float(8) based(pDummy);

// SQL Data Types
dcl-s SDWORD_t like(long_t) based(pDummy);
dcl-s UDWORD_t like(ulong_t) based(pDummy);
dcl-s UWORD_t like(ushort_t) based(pDummy);
dcl-s SWORD_t like(short_t) based(pDummy);

dcl-s SQLCHAR_t like(char_t) based(pDummy);
dcl-s SQLINTEGER_t like(long_t) based(pDummy);
dcl-s SQLSMALLINT_t like(short_t) based(pDummy);
dcl-s SQLUSMALLINT_t like(UWORD_t) based(pDummy);
dcl-s SQLUINTEGER_t like(UDWORD_t) based(pDummy);
dcl-s SQLDOUBLE_t like(double_t) based(pDummy);
dcl-s SQLREAL_t like(float_t) based(pDummy);

dcl-s PTR_t pointer based(pDummy);
dcl-s SQLPOINTER_t like(PTR_t) based(pDummy);
dcl-s HENV_t like(long_t) based(pDummy);
dcl-s HDBC_t like(long_t) based(pDummy);
dcl-s HSTMT_t like(long_t) based(pDummy);
dcl-s HDESC_t like(long_t) based(pDummy);
dcl-s SQLHENV_t like(HENV_t) based(pDummy);
dcl-s SQLHDBC_t like(HDBC_t) based(pDummy);
dcl-s SQLHSTMT_t like(HSTMT_t) based(pDummy);
dcl-s SQLHDESC_t like(HDESC_t) based(pDummy);

dcl-s RETCODE_t like(SQLINTEGER_t) based(pDummy);
dcl-s SQLRETCODE_t like(RETCODE_t) based(pDummy);

dcl-s SFLOAT like(float_t) based(pDummy);


// DATE, TIME, and TIMESTAMP structures.  These are for compatibility
// purposes only.  When actually specifying or retrieving DATE, TIME,
// and TIMESTAMP values, character strings must be used.


dcl-ds DATE_STRUCT_t align based(pDummy);
  DATE_STRUCT_year_t  like(SQLSMALLINT_t);
  DATE_STRUCT_month_t like(SQLSMALLINT_t);
  DATE_STRUCT_day_t   like(SQLSMALLINT_t);
end-ds;

dcl-ds TIME_STRUCT_t align based(pDummy);
  TIME_STRUCT_hour_t   like(SQLSMALLINT_t);
  TIME_STRUCT_minute_t like(SQLSMALLINT_t);
  TIME_STRUCT_second_t like(SQLSMALLINT_t);
end-ds;

dcl-ds TIMESTAMP_STRUCT_t align based(pDummy);
  TIMESTAMP_STRUCT_year_t     like(SQLSMALLINT_t);
  TIMESTAMP_STRUCT_month_t    like(SQLSMALLINT_t);
  TIMESTAMP_STRUCT_day_t      like(SQLSMALLINT_t);
  TIMESTAMP_STRUCT_hour_t     like(SQLSMALLINT_t);
  TIMESTAMP_STRUCT_minute_t   like(SQLSMALLINT_t);
  TIMESTAMP_STRUCT_second_t   like(SQLSMALLINT_t);
  TIMESTAMP_STRUCT_fraction_t like(SQLINTEGER_t);
end-ds;


dcl-pr SQLAllocConnect extproc('SQLAllocConnect') like(SQLRETCODE_t);
  i_henv  like(SQLHENV_t) value;
  o_phdbc pointer value; // SQLHDBC *
end-pr;

dcl-pr SQLAllocEnv extproc('SQLAllocEnv') like(SQLRETCODE_t);
  o_phenv pointer value; // SQLHENV *
end-pr;

dcl-pr SQLAllocHandle extproc('SQLAllocHandle') like(SQLRETCODE_t);
  i_htype   like(SQLSMALLINT_t) value;
  i_ihandle like(SQLINTEGER_t) value;
  o_handle  pointer value; // SQLINTEGER *
end-pr;

dcl-pr SQLAllocStmt extproc('SQLAllocStmt') like(SQLRETCODE_t);
  i_hdbc   like(SQLHDBC_t) value;
  o_phstmt pointer value; // SQLHSTMT *
end-pr;

dcl-pr SQLBindCol extproc('SQLBindCol') like(SQLRETCODE_t);
  i_hstmt      like(SQLHSTMT_t) value;
  i_icol       like(SQLSMALLINT_t) value;
  i_fcType     like(SQLSMALLINT_t) value;
  o_rgbValue   like(SQLPOINTER_t) value; // VOID *
  i_cbValueMax like(SQLINTEGER_t) value;
  o_pcbValue   pointer value; // SQLINTEGER *
end-pr;

dcl-pr SQLBindFileToCol extproc('SQLBindFileToCol') like(SQLRETCODE_t);
  i_hstmt     like(SQLHSTMT_t) value;
  i_icol      like(SQLSMALLINT_t) value;
  o_fName     pointer value; // SQLCHAR *
  o_fNameLen  pointer value; // SQLSMALLINT *
  o_fOptions  pointer value; // SQLINTEGER *
  i_fValueMax like(SQLSMALLINT_t) value;
  o_sLen      pointer value; // SQLINTEGER *
  o_pcbValue  pointer value; // SQLINTEGER *
end-pr;

dcl-pr SQLBindFileToParam extproc('SQLBindFileToParam') like(SQLRETCODE_t);
  i_hstmt     like(SQLHSTMT_t) value;
  i_ipar      like(SQLSMALLINT_t) value;
  i_iType     like(SQLSMALLINT_t) value;
  o_fName     pointer value; // SQLCHAR *
  o_fNameLen  pointer value; // SQLSMALLINT *
  o_fOptions  pointer value; // SQLINTEGER *
  i_fValueMax like(SQLSMALLINT_t) value;
  o_pcbValue  pointer value; // SQLINTEGER *
end-pr;

dcl-pr SQLBindParam extproc('SQLBindParam') like(SQLRETCODE_t);
  i_hstmt      like(SQLHSTMT_t) value;
  i_ipar       like(SQLSMALLINT_t) value;
  i_fCType     like(SQLSMALLINT_t) value;
  i_fSqlType   like(SQLSMALLINT_t) value;
  i_cbParamDef like(SQLINTEGER_t) value;
  i_ibScale    like(SQLSMALLINT_t) value;
  io_rpgValue  like(SQLPOINTER_t) value; // VOID *
  i_pcbValue   pointer value; // SQLINTEGER *
end-pr;

dcl-pr SQLBindParameter extproc('SQLBindParameter') like(SQLRETCODE_t);
  i_hstmt       like(SQLHSTMT_t) value;
  i_ipar        like(SQLSMALLINT_t) value;
  i_IOType      like(SQLSMALLINT_t) value;
  i_fCType      like(SQLSMALLINT_t) value;
  i_fSqlType    like(SQLSMALLINT_t) value;
  i_colSize     like(SQLINTEGER_t) value;
  i_scale       like(SQLSMALLINT_t) value;
  io_parValPtr  like(SQLPOINTER_t) value; // VOID *
  i_buffLen     like(SQLINTEGER_t) value;
  i_strLnIndPtr pointer value; // SQLINTEGER *
end-pr;

dcl-pr SQLCancel extproc('SQLCancel') like(SQLRETCODE_t);
  i_hstmt like(SQLHSTMT_t) value;
end-pr;

dcl-pr SQLCloseCursor extproc('SQLCloseCursor') like(SQLRETCODE_t);
  i_hstmt like(SQLHSTMT_t) value;
end-pr;

dcl-pr SQLColAttributes extproc('SQLColAttributes') like(SQLRETCODE_t);
  i_hstmt     like(SQLHSTMT_t) value;
  i_icol      like(SQLSMALLINT_t) value;
  i_fDescType like(SQLSMALLINT_t) value;
  o_rgbDesc   pointer value; // SQLCHAR *
  i_cbDescMax like(SQLINTEGER_t) value;
  o_pcbDesc   pointer value; // SQLINTEGER *
  o_pfDesc    pointer value; // SQLINTEGER *
end-pr;

dcl-pr SQLColumns extproc('SQLColumns') like(SQLRETCODE_t);
  i_hstmt      like(SQLHSTMT_t) value;
  i_szCtlgName pointer value; // SQLCHAR *
  i_cbCtlgName like(SQLSMALLINT_t) value;
  i_szSchmName pointer value; // SQLCHAR *
  i_cbSchmName like(SQLSMALLINT_t) value;
  i_szTblName  pointer value; // SQLCHAR *
  i_cbTblName  like(SQLSMALLINT_t) value;
  i_szColName  pointer value; // SQLCHAR *
  i_cbColName  like(SQLSMALLINT_t) value;
end-pr;

dcl-pr SQLConnect extproc('SQLConnect') like(SQLRETCODE_t);
  i_hdbc      like(SQLHDBC_t) value;
  i_szDSN     pointer options(*string) value; // SQLCHAR *
  i_cbDSN     like(SQLSMALLINT_t) value; // => SQL_NTS
  i_szUID     pointer options(*string) value; // SQLCHAR *
  i_cbUID     like(SQLSMALLINT_t) value; // => SQL_NTS
  i_szAuthStr pointer options(*string) value; // SQLCHAR *
  i_cbAuthStr like(SQLSMALLINT_t) value; // => SQL_NTS
end-pr;

dcl-pr SQLCopyDesc extproc('SQLCopyDesc') like(SQLRETCODE_t);
  i_sDesc like(SQLHDESC_t) value;
  i_tDesc like(SQLHDESC_t) value;
end-pr;

dcl-pr SQLDataSources extproc('SQLDataSources') like(SQLRETCODE_t);
  i_henv       like(SQLHENV_t) value;
  i_fDirection like(SQLSMALLINT_t) value;
  o_szDSN      pointer value; // SQLCHAR *
  i_cbDSNMax   like(SQLSMALLINT_t) value;
  o_pcbDSN     pointer value; // SQLSMALLINT *
  o_szDesc     pointer value; // SQLCHAR *
  i_cbDescMax  like(SQLSMALLINT_t) value;
  o_pcbDesc    pointer value; // SQLSMALLINT *
end-pr;

dcl-pr SQLDescribeCol extproc('SQLDescribeCol') like(SQLRETCODE_t);
  i_hstmt       like(SQLHSTMT_t) value;
  i_icol        like(SQLSMALLINT_t) value;
  o_szColName   pointer value; // SQLCHAR *
  i_cbColNameMx like(SQLSMALLINT_t) value;
  o_pcbColName  pointer value; // SQLSMALLINT *
  o_pfSqltype   pointer value; // SQLSMALLINT *
  o_pcbColDef   pointer value; // SQLINTEGER *
  o_pibScale    pointer value; // SQLSMALLINT *
  o_pfNullable  pointer value; // SQLSMALLINT *
end-pr;

dcl-pr SQLDescribeParam extproc('SQLDescribeParam') like(SQLRETCODE_t);
  i_hstmt      like(SQLHSTMT_t) value;
  i_iPar       like(SQLSMALLINT_t) value;
  o_pfSqltype  pointer value; // SQLSMALLINT *
  o_pcbColDef  pointer value; // SQLINTEGER *
  o_pibScale   pointer value; // SQLSMALLINT *
  o_pfNullable pointer value; // SQLSMALLINT *
end-pr;

dcl-pr SQLDisconnect extproc('SQLDisconnect') like(SQLRETCODE_t);
  i_hdbc like(SQLHDBC_t) value;
end-pr;

dcl-pr SQLDriverConnect extproc('SQLDriverConnect') like(SQLRETCODE_t);
  i_hdbc        like(SQLHDBC_t) value;
  i_hwnd        like(SQLPOINTER_t) value; // VOID *
  i_szCnStrIn   pointer value; // SQLCHAR
  i_cbCnStrIn   like(SQLSMALLINT_t) value;
  o_szCnStrOut  pointer value; // SQLCHAR
  i_cbCnStrOutM like(SQLSMALLINT_t) value;
  o_pcbCnStrOut pointer value; // SQLSMALLINT *
  i_fDrvCompl   like(SQLSMALLINT_t) value;
end-pr;

dcl-pr SQLEndTran extproc('SQLEndTran') like(SQLRETCODE_t);
  i_htype like(SQLSMALLINT_t) value;
  i_henv  like(SQLHENV_t) value;
  i_ctype like(SQLSMALLINT_t) value;
end-pr;

dcl-pr SQLError extproc('SQLError') like(SQLRETCODE_t);
  i_henv        like(SQLHENV_t) value;
  i_hdbc        like(SQLHDBC_t) value;
  i_hstmt       like(SQLHSTMT_t) value;
  o_szSqlState  pointer value; // SQLCHAR *
  o_pfNativeErr pointer value; // SQLINTEGER *
  o_szErrorMsg  pointer value; // SQLCHAR *
  i_cbErrMsgMax like(SQLSMALLINT_t) value;
  o_pcbErrorMsg pointer value; // SQLSMALLINT *
end-pr;

dcl-pr SQLExecDirect extproc('SQLExecDirect') like(SQLRETCODE_t);
  i_hstmt    like(SQLHSTMT_t) value;
  i_szSqlStr pointer options(*string) value; // SQLCHAR *
  i_cbSqlStr like(SQLINTEGER_t) value; // => SQL_NTS
end-pr;

dcl-pr SQLExecute extproc('SQLExecute') like(SQLRETCODE_t);
  i_hstmt like(SQLHSTMT_t) value;
end-pr;

dcl-pr SQLExtendedFetch extproc('SQLExtendedFetch') like(SQLRETCODE_t);
  i_hstmt      like(SQLHSTMT_t) value;
  i_fOrient    like(SQLSMALLINT_t) value;
  i_fOffset    like(SQLINTEGER_t) value;
  o_pcrow      pointer value; // SQLINTEGER *
  o_rgfRowStat pointer value; // SQLSMALLINT *
end-pr;

dcl-pr SQLFetch extproc('SQLFetch') like(SQLRETCODE_t);
  i_hstmt like(SQLHSTMT_t) value;
end-pr;

dcl-pr SQLFetchScroll extproc('SQLFetchScroll') like(SQLRETCODE_t);
  i_hstmt   like(SQLHSTMT_t) value;
  i_fOrient like(SQLSMALLINT_t) value;
  i_fOffset like(SQLINTEGER_t) value;
end-pr;

dcl-pr SQLForeignKeys extproc('SQLForeignKeys') like(SQLRETCODE_t);
  i_hstmt       like(SQLHSTMT_t) value;
  i_szPkCtlgNme pointer value; // SQLCHAR *
  i_cbPkCtlgNme like(SQLSMALLINT_t) value;
  i_szPkSchmNme pointer value; // SQLCHAR *
  i_cbPkSchmNme like(SQLSMALLINT_t) value;
  i_szPkTblNme  pointer value; // SQLCHAR *
  i_cbPkTblNme  like(SQLSMALLINT_t) value;
  i_szFkCtlgNme pointer value; // SQLCHAR *
  i_cbFkCtlgNme like(SQLSMALLINT_t) value;
  i_szFkSchmNme pointer value; // SQLCHAR *
  i_cbFkSchmNme like(SQLSMALLINT_t) value;
  i_szFkTblNme  pointer value; // SQLCHAR *
  i_cbFkTblNme  like(SQLSMALLINT_t) value;
end-pr;

dcl-pr SQLFreeConnect extproc('SQLFreeConnect') like(SQLRETCODE_t);
  i_hdbc like(SQLHDBC_t) value;
end-pr;

dcl-pr SQLFreeEnv extproc('SQLFreeEnv') like(SQLRETCODE_t);
  i_henv like(SQLHENV_t) value;
end-pr;

dcl-pr SQLFreeHandle extproc('SQLFreeHandle') like(SQLRETCODE_t);
  i_htype  like(SQLSMALLINT_t) value;
  i_handle like(SQLINTEGER_t) value;
end-pr;

dcl-pr SQLFreeStmt extproc('SQLFreeStmt') like(SQLRETCODE_t);
  i_hstmt   like(SQLHSTMT_t) value;
  i_fOption like(SQLSMALLINT_t) value;
end-pr;

dcl-pr SQLGetCol extproc('SQLGetCol') like(SQLRETCODE_t);
  i_hstmt      like(SQLHSTMT_t) value;
  i_icol       like(SQLSMALLINT_t) value;
  i_fcType     like(SQLSMALLINT_t) value;
  o_rgbValue   like(SQLPOINTER_t) value; // VOID *
  i_cbValueMax like(SQLINTEGER_t) value;
  o_pcbValue   pointer value; // SQLINTEGER *
end-pr;

dcl-pr SQLGetConnectAttr extproc('SQLGetConnectAttr') like(SQLRETCODE_t);
  i_hdbc    like(SQLHDBC_t) value;
  i_fattr   like(SQLINTEGER_t) value;
  o_pvParam like(SQLPOINTER_t) value; // VOID *
  i_blen    like(SQLINTEGER_t) value;
  o_slen    pointer value; // SQLINTEGER *
end-pr;

dcl-pr SQLGetConnectOption extproc('SQLGetConnectOption') like(SQLRETCODE_t);
  i_hdbc    like(SQLHDBC_t) value;
  i_fOption like(SQLSMALLINT_t) value;
  o_pvParam like(SQLPOINTER_t) value; // VOID *
end-pr;

dcl-pr SQLGetCursorName extproc('SQLGetCursorName') like(SQLRETCODE_t);
  i_hstmt       like(SQLHSTMT_t) value;
  o_szCursor    pointer value; // SQLCHAR *
  i_cbCursorMax like(SQLSMALLINT_t) value;
  o_pcbCursor   pointer value; // SQLSMALLINT *
end-pr;

dcl-pr SQLGetData extproc('SQLGetData') like(SQLRETCODE_t);
  i_hstmt      like(SQLHSTMT_t) value;
  i_icol       like(SQLSMALLINT_t) value;
  i_fcType     like(SQLSMALLINT_t) value;
  o_rgbValue   like(SQLPOINTER_t) value; // VOID *
  i_cbValueMax like(SQLINTEGER_t) value;
  o_pcbValue   pointer value; // SQLINTEGER *
end-pr;

dcl-pr SQLGetDescField extproc('SQLGetDescField') like(SQLRETCODE_t);
  i_hdesc     like(SQLHDESC_t) value;
  i_irec      like(SQLSMALLINT_t) value;
  i_fDescType like(SQLSMALLINT_t) value;
  o_rgbDesc   like(SQLPOINTER_t) value; // VOID *
  i_blen      like(SQLINTEGER_t) value;
  i_sLen      pointer value; // SQLINTEGER *
end-pr;

dcl-pr SQLGetDescRec extproc('SQLGetDescRec') like(SQLRETCODE_t);
  i_hdesc     like(SQLHDESC_t) value;
  i_irec      like(SQLSMALLINT_t) value;
  o_rgbDesc   pointer value; // SQLCHAR *
  i_cbDescMax like(SQLSMALLINT_t) value;
  o_pcbDesc   pointer value; // SQLSMALLINT *
  o_type      pointer value; // SQLSMALLINT *
  o_subType   pointer value; // SQLSMALLINT *
  o_length    pointer value; // SQLINTEGER *
  o_precision pointer value; // SQLSMALLINT *
  o_scale     pointer value; // SQLSMALLINT *
  o_nullable  pointer value; // SQLSMALLINT *
end-pr;

dcl-pr SQLGetDiagField extproc('SQLGetDiagField') like(SQLRETCODE_t);
  i_hType    like(SQLSMALLINT_t) value;
  i_handle   like(SQLINTEGER_t) value;
  i_recNum   like(SQLSMALLINT_t) value;
  i_diagID   like(SQLSMALLINT_t) value;
  o_diagInfo like(SQLPOINTER_t) value; // VOID *
  i_bLen     like(SQLSMALLINT_t) value;
  o_sLen     pointer value; // SQLSMALLINT *
end-pr;

dcl-pr SQLGetDiagRec extproc('SQLGetDiagRec') like(SQLRETCODE_t);
  i_hType       like(SQLSMALLINT_t) value;
  i_handle      like(SQLINTEGER_t) value;
  i_recNum      like(SQLSMALLINT_t) value;
  o_szSqlState  pointer value; // SQLCHAR *
  o_pfNativeErr pointer value; // SQLINTEGER *
  o_szErrorMsg  pointer value; // SQLCHAR *
  i_cbErrMsgMax like(SQLSMALLINT_t) value;
  o_pcbErrorMsg pointer value; // SQLSMALLINT *
end-pr;

dcl-pr SQLGetEnvAttr extproc('SQLGetEnvAttr') like(SQLRETCODE_t);
  i_henv       like(SQLHENV_t) value;
  i_Attr       like(SQLINTEGER_t) value;
  o_pParam     like(SQLPOINTER_t) value; // VOID *
  i_cbParamMax like(SQLINTEGER_t) value;
  o_pcbParam   pointer value; // SQLINTEGER
end-pr;

dcl-pr SQLGetFunctions extproc('SQLGetFunctions') like(SQLRETCODE_t);
  i_hdbc      like(SQLHDBC_t) value;
  i_fFunction like(SQLSMALLINT_t) value;
  i_pfExists  pointer value; // SQLSMALLINT *
end-pr;

dcl-pr SQLGetInfo extproc('SQLGetInfo') like(SQLRETCODE_t);
  i_hdbc        like(SQLHDBC_t) value;
  i_fInfoType   like(SQLSMALLINT_t) value;
  o_rgbInfoVal  like(SQLPOINTER_t) value; // VOID *
  i_cbInfValMax like(SQLSMALLINT_t) value;
  o_pcbInfoVal  pointer value; // SQLSMALLINT *
end-pr;

dcl-pr SQLGetLength extproc('SQLGetLength') like(SQLRETCODE_t);
  i_hstmt   like(SQLHSTMT_t) value;
  i_locType like(SQLSMALLINT_t) value;
  i_locator like(SQLINTEGER_t) value;
  o_sLength pointer value; // SQLINTEGER *
  o_ind     pointer value; // SQLINTEGER *
end-pr;

dcl-pr SQLGetPosition extproc('SQLGetPosition') like(SQLRETCODE_t);
  i_hstmt       like(SQLHSTMT_t) value;
  i_locType     like(SQLSMALLINT_t) value;
  i_srceLocator like(SQLINTEGER_t) value;
  i_srchLocator like(SQLINTEGER_t) value;
  i_srchLiteral pointer value; // SQLCHAR *
  i_srchLitLen  like(SQLINTEGER_t) value;
  i_fPosition   like(SQLINTEGER_t) value;
  o_located     pointer value; // SQLINTEGER *
  o_ind         pointer value; // SQLINTEGER *
end-pr;

dcl-pr SQLGetStmtAttr extproc('SQLGetStmtAttr') like(SQLRETCODE_t);
  i_hstmt   like(SQLHSTMT_t) value;
  i_fAttr   like(SQLINTEGER_t) value;
  o_pvParam like(SQLPOINTER_t) value; // VOID *
  i_bLen    like(SQLINTEGER_t) value;
  o_sLen    pointer value; // SQLINTEGER *
end-pr;

dcl-pr SQLGetStmtOption extproc('SQLGetStmtOption') like(SQLRETCODE_t);
  i_hstmt   like(SQLHSTMT_t) value;
  i_fOption like(SQLSMALLINT_t) value;
  o_pvParam like(SQLPOINTER_t) value; // VOID *
end-pr;

dcl-pr SQLGetSubString extproc('SQLGetSubString') like(SQLRETCODE_t);
  i_hstmt       like(SQLHSTMT_t) value;
  i_locType     like(SQLSMALLINT_t) value;
  i_srceLocator like(SQLINTEGER_t) value;
  i_fPosition   like(SQLINTEGER_t) value;
  i_length      like(SQLINTEGER_t) value;
  i_tType       like(SQLSMALLINT_t) value;
  o_rgbValue    like(SQLPOINTER_t) value; // VOID *
  i_cbValueMax  like(SQLINTEGER_t) value;
  o_pcbValue    pointer value; // SQLINTEGER *
  o_ind         pointer value; // SQLINTEGER *
end-pr;

dcl-pr SQLGetTypeInfo extproc('SQLGetTypeInfo') like(SQLRETCODE_t);
  i_hstmt    like(SQLHSTMT_t) value;
  i_fSqltype like(SQLSMALLINT_t) value;
end-pr;

dcl-pr SQLLanguages extproc('SQLLanguages') like(SQLRETCODE_t);
  i_hstmt like(SQLHSTMT_t) value;
end-pr;

dcl-pr SQLMoreResults extproc('SQLMoreResults') like(SQLRETCODE_t);
  i_hstmt like(SQLHSTMT_t) value;
end-pr;

dcl-pr SQLNativeSql extproc('SQLNativeSql') like(SQLRETCODE_t);
  i_hdbc        like(SQLHDBC_t) value;
  i_szSqlStrIn  pointer value; // SQLCHAR *
  i_cbSqlStrIn  like(SQLINTEGER_t) value;
  o_szSqlStrOut pointer value; // SQLCHAR *
  i_cbSqlStrOut like(SQLINTEGER_t) value;
  o_pcbSqlStrO  pointer value; // SQLINTEGER *
end-pr;

dcl-pr SQLNumParams extproc('SQLNumParams') like(SQLRETCODE_t);
  i_hstmt like(SQLHSTMT_t) value;
  i_pcpar pointer value; // SQLSMALLINT *
end-pr;

dcl-pr SQLNumResultCols extproc('SQLNumResultCols') like(SQLRETCODE_t);
  i_hstmt like(SQLHSTMT_t) value;
  i_pccol pointer value; // SQLSMALLINT *
end-pr;

dcl-pr SQLParamData extproc('SQLParamData') like(SQLRETCODE_t);
  i_hstmt     like(SQLHSTMT_t) value;
  o_prgbValue like(SQLPOINTER_t) value; // VOID *
end-pr;

dcl-pr SQLParamOptions extproc('SQLParamOptions') like(SQLRETCODE_t);
  i_hstmt like(SQLHSTMT_t) value;
  i_crow  like(SQLINTEGER_t) value;
  i_pirow pointer value; // SQLINTEGER *
end-pr;

dcl-pr SQLPrepare extproc('SQLPrepare') like(SQLRETCODE_t);
  i_hstmt    like(SQLHSTMT_t) value;
  i_szSqlStr pointer options(*string) value; // SQLCHAR *
  i_cbSqlStr like(SQLSMALLINT_t) value; // => SQL_NTS
end-pr;

dcl-pr SQLPrimaryKeys extproc('SQLPrimaryKeys') like(SQLRETCODE_t);
  i_hstmt     like(SQLHSTMT_t) value;
  i_szCtlgNme pointer value; // SQLCHAR *
  i_cbCtlgNme like(SQLSMALLINT_t) value;
  i_szSchmNme pointer value; // SQLCHAR *
  i_cbSchmNme like(SQLSMALLINT_t) value;
  i_szTblNme  pointer value; // SQLCHAR *
  i_cbTblNme  like(SQLSMALLINT_t) value;
end-pr;

dcl-pr SQLProcedureColumns extproc('SQLProcedureColumns') like(SQLRETCODE_t);
  i_hstmt     like(SQLHSTMT_t) value;
  i_szCtlgNme pointer value; // SQLCHAR *
  i_cbCtlgNme like(SQLSMALLINT_t) value;
  i_szSchmNme pointer value; // SQLCHAR *
  i_cbSchmNme like(SQLSMALLINT_t) value;
  i_szProcNme pointer value; // SQLCHAR *
  i_cbProcNme like(SQLSMALLINT_t) value;
  i_szColNme  pointer value; // SQLCHAR *
  i_cbColNme  like(SQLSMALLINT_t) value;
end-pr;

dcl-pr SQLProcedures extproc('SQLProcedures') like(SQLRETCODE_t);
  i_hstmt     like(SQLHSTMT_t) value;
  i_szCtlgNme pointer value; // SQLCHAR *
  i_cbCtlgNme like(SQLSMALLINT_t) value;
  i_szSchmNme pointer value; // SQLCHAR *
  i_cbSchmNme like(SQLSMALLINT_t) value;
  i_szProcNme pointer value; // SQLCHAR *
  i_cbProcNme like(SQLSMALLINT_t) value;
end-pr;

dcl-pr SQLPutData extproc('SQLPutData') like(SQLRETCODE_t);
  i_hstmt    like(SQLHSTMT_t) value;
  i_rgbValue like(SQLPOINTER_t) value; // VOID *
  i_cbValue  like(SQLINTEGER_t) value;
end-pr;

dcl-pr SQLReleaseEnv extproc('SQLReleaseEnv') like(SQLRETCODE_t);
  i_henv like(SQLHENV_t) value;
end-pr;

dcl-pr SQLRowCount extproc('SQLRowCount') like(SQLRETCODE_t);
  i_hstmt like(SQLHSTMT_t) value;
  o_pcrow pointer value; // SQLINTEGER *
end-pr;

dcl-pr SQLSetConnectAttr extproc('SQLSetConnectAttr') like(SQLRETCODE_t);
  i_hdbc   like(SQLHDBC_t) value;
  i_fAttr  like(SQLINTEGER_t) value;
  i_vParam like(SQLPOINTER_t) value; // VOID *
  i_sLen   like(SQLINTEGER_t) value;
end-pr;

dcl-pr SQLSetConnectOption extproc('SQLSetConnectOption') like(SQLRETCODE_t);
  i_hdbc    like(SQLHDBC_t) value;
  i_fOption like(SQLSMALLINT_t) value;
  i_vParam  like(SQLPOINTER_t) value; // VOID *
end-pr;

dcl-pr SQLSetCursorName extproc('SQLSetCursorName') like(SQLRETCODE_t);
  i_hstmt    like(SQLHSTMT_t) value;
  i_szCursor pointer value; // SQLCHAR *
  i_cbCursor like(SQLSMALLINT_t) value;
end-pr;

dcl-pr SQLSetDescField extproc('SQLSetDescField') like(SQLRETCODE_t);
  i_hdesc     like(SQLHDESC_t) value;
  i_irec      like(SQLSMALLINT_t) value;
  i_fDescType like(SQLSMALLINT_t) value;
  i_rgbDesc   like(SQLPOINTER_t) value; // VOID *
  i_bLen      like(SQLINTEGER_t) value;
end-pr;

dcl-pr SQLSetDescRec extproc('SQLSetDescRec') like(SQLRETCODE_t);
  i_hdesc     like(SQLHDESC_t) value;
  i_irec      like(SQLSMALLINT_t) value;
  i_type      like(SQLSMALLINT_t) value;
  i_subType   like(SQLSMALLINT_t) value;
  i_length    like(SQLINTEGER_t) value;
  i_precision like(SQLSMALLINT_t) value;
  i_scale     like(SQLSMALLINT_t) value;
  i_rgbValue  like(SQLPOINTER_t) value; // VOID *
  i_sLen      pointer value; // SQLINTEGER *
  i_indic     pointer value; // SQLSMALLINT *
end-pr;

dcl-pr SQLSetEnvAttr extproc('SQLSetEnvAttr') like(SQLRETCODE_t);
  i_henv    like(SQLHENV_t) value;
  i_attr    like(SQLINTEGER_t) value;
  i_pParam  like(SQLPOINTER_t) value; // VOID *
  i_cbParam like(SQLINTEGER_t) value;
end-pr;

dcl-pr SQLSetParam extproc('SQLSetParam') like(SQLRETCODE_t);
  i_hstmt    like(SQLHSTMT_t) value;
  i_ipar     like(SQLSMALLINT_t) value;
  i_fcType   like(SQLSMALLINT_t) value;
  i_fsqltype like(SQLSMALLINT_t) value;
  i_cbColDef like(SQLINTEGER_t) value;
  i_ibScale  like(SQLSMALLINT_t) value;
  o_rgbValue like(SQLPOINTER_t) value; // VOID *
  i_pcbValue pointer value; // SQLINTEGER *
end-pr;

dcl-pr SQLSetStmtAttr extproc('SQLSetStmtAttr') like(SQLRETCODE_t);
  i_hstmt  like(SQLHSTMT_t) value;
  i_attr   like(SQLINTEGER_t) value;
  i_pParam like(SQLPOINTER_t) value; // VOID *
  i_vParam like(SQLINTEGER_t) value;
end-pr;

dcl-pr SQLSetStmtOption extproc('SQLSetStmtOption') like(SQLRETCODE_t);
  i_hstmt   like(SQLHSTMT_t) value;
  i_fOption like(SQLSMALLINT_t) value;
  i_vParam  like(SQLPOINTER_t) value; // VOID *
end-pr;

dcl-pr SQLSpecialColumns extproc('SQLSpecialColumns') like(SQLRETCODE_t);
  i_hstmt     like(SQLHSTMT_t) value;
  i_fColType  like(SQLSMALLINT_t) value;
  i_szCtlgNme pointer value; // SQLCHAR *
  i_cbCtlgNme like(SQLSMALLINT_t) value;
  i_szSchmNme pointer value; // SQLCHAR *
  i_cbSchmNme like(SQLSMALLINT_t) value;
  i_szTblNme  pointer value; // SQLCHAR *
  i_cbTblNme  like(SQLSMALLINT_t) value;
  i_fScope    like(SQLSMALLINT_t) value;
  i_fNullable like(SQLSMALLINT_t) value;
end-pr;

dcl-pr SQLStatistics extproc('SQLStatistics') like(SQLRETCODE_t);
  i_hstmt     like(SQLHSTMT_t) value;
  i_szCtlgNme pointer value; // SQLCHAR *
  i_cbCtlgNme like(SQLSMALLINT_t) value;
  i_szSchmNme pointer value; // SQLCHAR *
  i_cbSchmNme like(SQLSMALLINT_t) value;
  i_szTblNme  pointer value; // SQLCHAR *
  i_cbTblNme  like(SQLSMALLINT_t) value;
  i_fUnique   like(SQLSMALLINT_t) value;
  i_fAccuracy like(SQLSMALLINT_t) value;
end-pr;

dcl-pr SQLTables extproc('SQLTables') like(SQLRETCODE_t);
  i_hstmt     like(SQLHSTMT_t) value;
  i_szCtlgNme pointer value; // SQLCHAR *
  i_cbCtlgNme like(SQLSMALLINT_t) value;
  i_szSchmNme pointer value; // SQLCHAR *
  i_cbSchmNme like(SQLSMALLINT_t) value;
  i_szTblNme  pointer value; // SQLCHAR *
  i_cbTblNme  like(SQLSMALLINT_t) value;
  i_szTblType pointer value; // SQLCHAR *
  i_cbTblType like(SQLSMALLINT_t) value;
end-pr;

dcl-pr SQLTransact extproc('SQLTransact') like(SQLRETCODE_t);
  i_henv  like(SQLHENV_t) value;
  i_hdbc  like(SQLHDBC_t) value;
  i_fType like(SQLSMALLINT_t) value;
end-pr;


// maximum data source name size
dcl-c SQL_MAX_DSN_LENGTH 18;

// maximum identifier name size, e.g. cursor names
dcl-c SQL_MAX_ID_LENGTH 18;

// Maximum statement size
dcl-c SQL_MAX_STMT_SIZ 32767;

// Maximum record length
dcl-c SQL_MAXRECL 32766;

// Size of a SMALLINT
dcl-c SQL_SMALL_LENGTH 2;

// Maximum value of a SMALLINT
dcl-c SQL_MAXSMALLVAL 32767;

// Minimum value of a SMALLINT
dcl-c SQL_MINSMALLVAL -32766;

// Size of an INTEGER
dcl-c SQL_INT_LENGTH 4;

// Maximum value of an INTEGER
dcl-c SQL_MAXINTVAL 2147483647;

// Minimum value of an INTEGER
dcl-c SQL_MININTVAL -2147483646;

// Size of a FLOAT
dcl-c SQL_FLOAT_LENGTH 8;

// Default precision for DECIMAL
dcl-c SQL_DEFDEC_PRECISION 5;

// Default scale for DECIMAL
dcl-c SQL_DEFDEC_SCALE 0;

// Maximum scale/prec. for DECIMAL
dcl-c SQL_MAXDECIMAL 31;

// Default length for a CHAR
dcl-c SQL_DEFCHAR 1;

// Default length for a wchar_t
dcl-c SQL_DEFWCHAR 1;

// Maximum length of a CHAR
dcl-c SQL_MAXCHAR 32766;

// Maximum length of an LSTRING
dcl-c SQL_MAXLSTR 255;

// Maximum length of a VARCHAR
dcl-c SQL_MAXVCHAR 32740;

// Maximum length of a VARGRAPHIC
dcl-c SQL_MAXVGRAPH 16370;

// Max. length of a BLOB host var
dcl-c SQL_MAXBLOB 15728640;

// Max. length of a CLOB host var
dcl-c SQL_MAXCLOB 15728640;

// Max. length of an DBCLOB host var
dcl-c SQL_MAXDBCLOB 7864320;

// Maximum length of a LONG VARCHAR
dcl-c SQL_LONGMAX 32740;

// Max. length of a LONG VARGRAPHIC
dcl-c SQL_LONGGRMAX 16370;

// Overhead for LONG VARCHAR in record
dcl-c SQL_LVCHAROH 26;

// Overhead for LOB in record
dcl-c SQL_LOBCHAROH 312;

// BLOB maximum length, in bytes
dcl-c SQL_BLOB_MAXLEN 15728640;

// CLOB maximum length, in chars
dcl-c SQL_CLOB_MAXLEN 15728640;

// maxlen for dbcs lobs
dcl-c SQL_DBCLOB_MAXLEN 7864320;

// Size of a TIME field
dcl-c SQL_TIME_LENGTH 3;

// Size of a TIME field output
dcl-c SQL_TIME_STRLEN 8;

// Size of a non-USA TIME field output wothout seconds
dcl-c SQL_TIME_MINSTRLEN 5;

// Size of a DATE field
dcl-c SQL_DATE_LENGTH 4;

// Size of a DATE field output
dcl-c SQL_DATE_STRLEN 10;

// Size of a TIMESTAMP field
dcl-c SQL_STAMP_LENGTH 10;

// Size of a TIMESTAMP field output
dcl-c SQL_STAMP_STRLEN 26;

// Size of a TIMESTAMP field output without microseconds
dcl-c SQL_STAMP_MINSTRLEN 19;

// Size of a BOOLEAN field
dcl-c SQL_BOOLEAN_LENGTH 1;

// Size of an indicator value
dcl-c SQL_IND_LENGTH 2;

// Max size of Stored Proc Name
dcl-c SQL_MAX_PNAME_LENGTH 254;

// Maximum length of Long Identifer
dcl-c SQL_LG_IDENT 18;

// Maximum length of Short Identifer
dcl-c SQL_SH_IDENT 8;

// Minimum length of Identifiers
dcl-c SQL_MN_IDENT 1;

// Max size of Host Variable Name
dcl-c SQL_MAX_VAR_NAME 30;

// # of bytes in a kilobyte
dcl-c SQL_KILO_VALUE 1024;

// # of bytes in a megabyte
dcl-c SQL_MEGA_VALUE 1048576;

// # of bytes in a gigabyte
dcl-c SQL_GIGA_VALUE 1073741824;

// SQL extended data types (negative means unsupported)
dcl-c SQL_TINYINT -6;
dcl-c SQL_BIT -7;

dcl-c SQL_WARN_VAL_TRUNC '01004';

// C data type to SQL data type mapping
// ... CHAR, VARCHAR, DECIMAL, NUMERIC
dcl-c SQL_C_CHAR 1; // ('SQL_CHAR')
// ... INTEGER
dcl-c SQL_C_LONG 4; // ('SQL_INTEGER'
// ... SMALLINT
dcl-c SQL_C_SHORT 5; // ('SQL_SMALLINT
// ... REAL
dcl-c SQL_C_FLOAT 7; // ('SQL_REAL')
// ... FLOAT, DOUBLE
dcl-c SQL_C_DOUBLE 8; // ('SQL_DOUBLE')
// ... DATE
dcl-c SQL_C_DATE 91; // ('SQL_DATE')
// ... TIME
dcl-c SQL_C_TIME 92; // ('SQL_TIME')
// ... TIMESTAMP
dcl-c SQL_C_TIMESTAMP 93; // ('SQL_TIMESTAM
// ... BINARY, VARBINARY
dcl-c SQL_C_BINARY 97; // ('SQL_BINARY')
dcl-c SQL_C_BIT -7; // ('SQL_BIT')
dcl-c SQL_C_TINYINT -6; // ('SQL_TINYINT'
dcl-c SQL_C_BIGINT 19; // ('SQL_BIGINT')
dcl-c SQL_C_DBCHAR 15; // ('SQL_DBCLOB')
// ... UNICODE
dcl-c SQL_C_WCHAR 17; // ('SQL_WCHAR')
// ... DATETIME
dcl-c SQL_C_DATETIME 9; // ('SQL_DATETIME
dcl-c SQL_C_BLOB 13; // ('SQL_BLOB')
dcl-c SQL_C_CLOB 14; // ('SQL_CLOB')
dcl-c SQL_C_DBCLOB 15; // ('SQL_DBCLOB')
dcl-c SQL_C_BLOB_LOCATOR 20; // ('SQL_BLOB_LOC
dcl-c SQL_C_CLOB_LOCATOR 21; // ('SQL_CLOB_LOC
dcl-c SQL_C_DBCLOB_LOCATOR 22; // ('SQL_DBCLOB_L
/endif
