**free
// =================================================================== *
//                                                                     *
//  Kurzdokumentation :                                                *
//                                                                     *
//  Bereich . . . : RUNCLSTM                                           *
//  Objekt  . . . : RUNCLSTMG3                                         *
//  Beschreibung  : Tool: RUNCLSTM   (Run CL Statements         )      *
//  Author  . . . : Thomas Raddatz   <thomas.raddatz@tools400.de>      *
//  Datum . . . . : 03.08.2000                                         *
//                                                                     *
// =================================================================== *

//===============================================================*
//  Reference fields
//===============================================================*

/include qrunclstm,fderrcode
/include qrunclstm,fdmsg
/include qrunclstm,fdqobj

dcl-s capcmd_t char(32702) based(pDummy);
dcl-s cmdToken_t char(10) based(pDummy);
dcl-s bool_t ind based(pDummy);
dcl-s int2_t int(5) based(pDummy);
dcl-s int4_t int(10) based(pDummy);
dcl-s string_t char(32767) based(pDummy);
dcl-s obj_t char(10) based(pDummy);
dcl-s fc_t char(12) based(pDummy);
dcl-s file_t like(obj_t) based(pDummy);
dcl-s lib_t like(obj_t) based(pDummy);
dcl-s mbr_t like(obj_t) based(pDummy);
dcl-s mod_t like(obj_t) based(pDummy);
dcl-s naming_t char(10) based(pDummy);
dcl-s objType_t char(10) based(pDummy);
dcl-s pgm_t like(obj_t) based(pDummy);
dcl-s proc_t char(256) based(pDummy);
dcl-s srcSeq_t packed(6: 2) based(pDummy);
dcl-s tgtRls_t char(10) based(pDummy);
dcl-s typeCode_t char(6) based(pDummy);
dcl-s userDef_t char(30) based(pDummy);

//===============================================================*
//  Cosntants
//===============================================================*
dcl-c cTrue *on;
dcl-c cFalse *off;

dcl-c cMsg_Same -3;
dcl-c cMsg_Prv -2;
dcl-c cMsg_Ext -1;
dcl-c cMsg_ToMyself '*';
dcl-c cMsg_ToPgmBdy '*PGMBDY';
dcl-c cMsg_ToCtlBdy '*CTLBDY';
dcl-c cMsg_ToPgm '*PGMNAME';

dcl-c cMsg_AppInfo '*INFO';
dcl-c cMsg_AppWarning '*WARNING';
dcl-c cMsg_AppError '*ERROR';

dcl-c cMsg_TypInfo '*INFO';
dcl-c cMsg_TypDiag '*DIAG';
dcl-c cMsg_TypEscape '*ESCAPE';

dcl-c cErr_MonErr *on;
dcl-c cErr_NoMonErr *off;

dcl-c cCEE_IsPresent 1;
dcl-c cCEE_IsNotPresent 0;

