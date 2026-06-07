**free
// =================================================================== *
//                                                                     *
//  Kurzdokumentation :                                                *
//                                                                     *
//  Bereich . . . : RUNCLSTM                                           *
//  Objekt  . . . : RUNCLSTMG1                                         *
//  Beschreibung  : Tool: RUNCLSTM   (Run CL Statements         )      *
//  Author  . . . : Thomas Raddatz   <thomas.raddatz@tools400.de>      *
//  Datum . . . . : 03.08.2000                                         *
//                                                                     *
// =================================================================== *

//===============================================================*
//  Exported Prototypes
//===============================================================*

dcl-pr f_rmvRemCl varchar(32767);
  i_clString varchar(32767) value;
end-pr;

//  Öffnen SQL
dcl-pr f_opnSQL like(bool_t);
  i_naming like(naming_t) const;
  o_msg    likeds(msg_t);
end-pr;

dcl-pr f_executeSQL opdesc like(bool_t);
  i_sqlStmt like(capcmd_t) options(*varsize) const;
  o_msg     likeds(msg_t);
end-pr;

//  Schließen SQL
dcl-pr p_cloSQL;
end-pr;

dcl-pr f_execute opdesc like(bool_t);
  i_cmd       like(capcmd_t) options(*varsize) const;
  o_msg       likeds(msg_t) options(*nopass: *omit);
  i_typCmdPrc like(int4_t) options(*nopass) const;
end-pr;

dcl-pr f_fmtCmd like(capcmd_t);
  i_cmd like(capcmd_t) value;
end-pr;

dcl-pr f_cmpMonMsgID like(bool_t);
  i_msgId    like(msg_t.ID) value;
  i_monMsgId like(msg_t.ID) value;
end-pr;

dcl-pr f_newErrCode like(errCode_t);
  i_monErr like(bool_t) value;
end-pr;

dcl-pr f_getAPIErrMsg likeds(msg_t);
  i_errorCode like(errCode_t) value;
end-pr;

dcl-pr f_isAPIErr like(bool_t);
  i_errorCode like(errCode_t) value;
end-pr;

dcl-pr f_newMsg likeds(msg_t);
  i_msgID   like(msg_t.ID) value;
  // optionale Parametergruppe 1
  i_msgType like(msg_t.type) options(*nopass) value;
  // optionale Parametergruppe 2
  i_msgDta  like(msg_t.data) options(*nopass: *omit) const;
  // optionale Parametergruppe 3
  i_msgF    like(msg_t.file) options(*nopass) value;
  // optionale Parametergruppe 4
  i_msgL    like(msg_t.lib) options(*nopass) value;
end-pr;

dcl-pr f_right varchar(32767);
  i_string varchar(32767) value;
  i_rLen   like(int4_t) options(*nopass) value;
end-pr;

dcl-pr p_endPgmAbn;
  i_msg likeds(msg_t) value;
end-pr;

dcl-pr p_sndPgmMsg;
  i_msg    likeds(msg_t) value;
  // optionale Parametergruppe 1
  i_toStkC like(int4_t) options(*nopass) value;
  // optionale Parametergruppe 2
  i_toProc like(proc_t) options(*nopass) value;
  // optionale Parametergruppe 3
  i_toMod  like(mod_t) options(*nopass: *omit) const;
  // optionale Parametergruppe 4
  i_toPgm  like(pgm_t) options(*nopass) value;
end-pr;

dcl-pr f_exist like(bool_t);
  i_obj     like(obj_t) const;
  i_lib     like(lib_t) options(*omit) const;
  i_objType like(objType_t) const;
  i_mbr     like(mbr_t) options(*omit) const;
  o_msg     likeds(msg_t) options(*nopass);
end-pr;
//  Set Message file
dcl-pr p_setMsgFile;
  i_msgF    like(msg_t.file) value;
  i_msgFLib like(msg_t.lib) value;
end-pr;

//  Get Message file
dcl-pr f_getMsgFile like(msg_t.file);
end-pr;

//  Get Message file library
dcl-pr f_getMsgFileLib like(msg_t.lib);
end-pr;

