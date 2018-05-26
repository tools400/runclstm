      * =================================================================== *
      *                                                                     *
      *  Kurzdokumentation :                                                *
      *                                                                     *
      *  Bereich . . . : RUNCLSTM                                           *
      *  Objekt  . . . : RUNCLSTMG1                                         *
      *  Beschreibung  : Tool: RUNCLSTM   (Run CL Statements         )      *
      *  Author  . . . : Thomas Raddatz   <thomas.raddatz@tools400.de>      *
      *  Datum . . . . : 03.08.2000                                         *
      *                                                                     *
      * =================================================================== *
      *
      *===============================================================*
      *  Exported Prototypes
      *===============================================================*
      *
     D f_rmvRemCl...
     D                 PR         32767A          varying
     D  i_clString                32767A   value
     D                                     varying
      *
      *  ÷ffnen SQL
     D f_opnSQL        PR                         like(bool_t    )
     D  i_naming                           const  like(naming_t  )
     D  o_msg                                     like(msg_t     )
      *
     D f_executeSQL...
     D                 PR                  opdesc like(bool_t    )
     D  i_sqlStmt                          const  like(capcmd_t  )
     D                                     options(*varsize)
     D  o_msg                                     like(msg_t     )
      *
      *  Schlieﬂen SQL
     D p_cloSQL        PR
      *
     D f_execute...
     D                 PR                  opdesc like(bool_t    )
     D  i_cmd                              const  like(capcmd_t  )
     D                                     options(*varsize)
     D  o_msg                                     like(msg_t     )
     D                                     options(*nopass: *omit)
     D  i_typCmdPrc                        const  like(int4_t    )
     D                                     options(*nopass)
      *
     D f_fmtCmd...
     D                 PR                         like(capcmd_t  )
     D  i_cmd                              value  like(capcmd_t  )
      *
     D f_cmpMonMsgID...
     D                 PR                         like(bool_t    )
     D  i_msgId                            value  like(msg_t_ID  )
     D  i_monMsgId                         value  like(msg_t_ID  )
      *
     D f_newErrCode...
     D                 PR                         like(errCode_t )
     D  i_monErr                           value  like(bool_t    )
      *
     D f_getAPIErrMsg...
     D                 PR                         like(msg_t     )
     D  i_errorCode                        value  like(errCode_t )
      *
     D f_isAPIErr...
     D                 PR                         like(bool_t    )
     D  i_errorCode                        value  like(errCode_t )
      *
     D f_newMsg...
     D                 PR                         like(msg_t     )
     D  i_msgID                            value  like(msg_t_ID  )
      * optionale Parametergruppe 1
     D  i_msgType                          value  like(msg_t_type)
     D                                     options(*NOPASS)
      * optionale Parametergruppe 2
     D  i_msgDta                           const  like(msg_t_data)
     D                                     options(*NOPASS: *OMIT)
      * optionale Parametergruppe 3
     D  i_msgF                             value  like(msg_t_file)
     D                                     options(*NOPASS)
      * optionale Parametergruppe 4
     D  i_msgL                             value  like(msg_t_lib )
     D                                     options(*NOPASS)
      *
     D f_right...
     D                 PR         32767A   varying
     D  i_string                  32767A   value
     D                                     varying
     D  i_rLen                             value  like(int4_t    )
     D                                     options(*nopass )
      *
     D p_endPgmAbn...
     D                 PR
     D  i_msg                              value  like(msg_t     )
      *
     D p_sndPgmMsg...
     D                 PR
     D  i_msg                              value  like(msg_t     )
      * optionale Parametergruppe 1
     D  i_toStkC                           value  like(int4_t    )
     D                                     options(*NOPASS)
      * optionale Parametergruppe 2
     D  i_toProc                           value  like(proc_t    )
     D                                     options(*NOPASS)
      * optionale Parametergruppe 3
     D  i_toMod                            const  like(mod_t     )
     D                                     options(*NOPASS: *OMIT)
      * optionale Parametergruppe 4
     D  i_toPgm                            value  like(pgm_t     )
     D                                     options(*NOPASS)
      *
     D f_exist...
     D                 PR                         like(bool_t    )
     D  i_obj                              const  like(obj_t     )
     D  i_lib                              const  like(lib_t     )
     D                                     options(*omit)
     D  i_objType                          const  like(objType_t )
     D  i_mbr                              const  like(mbr_t     )
     D                                     options(*omit)
     D  o_msg                                     like(msg_t     )
     D                                     options(*nopass)
      *  Set Message file
     D p_setMsgFile...
     D                 PR
     D  i_msgF                             value like(msg_t_file)
     D  i_msgFLib                          value like(msg_t_lib )
      *
      *  Get Message file
     D f_getMsgFile...
     D                 PR                        like(msg_t_file)
      *
      *  Get Message file library
     D f_getMsgFileLib...
     D                 PR                        like(msg_t_lib )
      *
