      * =================================================================== *
      *                                                                     *
      *  Kurzdokumentation :                                                *
      *                                                                     *
      *  Bereich . . . : RUNCLSTM                                           *
      *  Objekt  . . . : RUNCLSTMG3                                         *
      *  Beschreibung  : Tool: RUNCLSTM   (Run CL Statements         )      *
      *  Author  . . . : Thomas Raddatz   <thomas.raddatz@tools400.de>      *
      *  Datum . . . . : 03.08.2000                                         *
      *                                                                     *
      * =================================================================== *
      *
      *===============================================================*
      *  Reference fields
      *===============================================================*
      *
     D msg_t         E DS                  extname(xdmsg     ) based(pDummy)
     D                                     prefix(msg_t_     )
     D errCode_t     E DS                  extname(xderrcode ) based(pDummy)
     D                                     prefix(errcode_t  )
     D qObj_t        E DS                  extname(xdqobj    ) based(pDummy)
     D                                     prefix(qObj_t     )
     D capcmd_t        S          32702A   based(pDummy)
     D cmdToken_t      S             10A   based(pDummy)
     D bool_t          S               N   based(pDummy)
     D int2_t          S              5I 0 based(pDummy)
     D int4_t          S             10I 0 based(pDummy)
     D string_t        S          32767A   based(pDummy)
     D obj_t           S             10A   based(pDummy)
     D fc_t            S             12A   based(pDummy)
     D file_t          S                   like(obj_t     )
     D                                     based(pDummy)
     D lib_t           S                   like(obj_t     )
     D                                     based(pDummy)
     D mbr_t           S                   like(obj_t     )
     D                                     based(pDummy)
     D mod_t           S                   like(obj_t     )
     D                                     based(pDummy)
     D naming_t        S             10A   based(pDummy)
     D objType_t       S             10A   based(pDummy)
     D pgm_t           S                   like(obj_t     )
     D                                     based(pDummy)
     D proc_t          S            256A   based(pDummy)
     D srcSeq_t        S              6P 2 based(pDummy)
     D tgtRls_t        S             10A   based(pDummy)
     D typeCode_t      S              6A   based(pDummy)
     D userDef_t       S             30A   based(pDummy)
      *
      *===============================================================*
      *  Cosntants
      *===============================================================*
     D cTrue           C                   const(*on )
     D cFalse          C                   const(*off)
      *
     D cMsg_Same       C                   const(-3)
     D cMsg_Prv        C                   const(-2)
     D cMsg_Ext        C                   const(-1)
     D cMsg_ToMyself   C                   const('*')
     D cMsg_ToPgmBdy   C                   const('*PGMBDY')
     D cMsg_ToCtlBdy   C                   const('*CTLBDY')
     D cMsg_ToPgm      C                   const('*PGMNAME')
      *
     D cMsg_AppInfo    C                   const('*INFO')
     D cMsg_AppWarning...
     D                 C                   const('*WARNING')
     D cMsg_AppError   C                   const('*ERROR')
      *
     D cMsg_TypInfo    C                   const('*INFO')
     D cMsg_TypDiag    C                   const('*DIAG')
     D cMsg_TypEscape  C                   const('*ESCAPE')
      *
     D cErr_MonErr     C                   const(*ON)
     D cErr_NoMonErr   C                   const(*OFF)
      *
     D cCEE_IsPresent  C                   const(1)
     D cCEE_IsNotPresent...
     D                 C                   const(0)
      *
