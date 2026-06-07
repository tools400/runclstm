**free
// =================================================================== *
//                                                                     *
//  Kurzdokumentation :                                                *
//                                                                     *
//  Bereich . . . : RUNCLSTM                                           *
//  Objekt  . . . : RUNCLSTMG2                                         *
//  Beschreibung  : Tool: RUNCLSTM   (Run CL Statements         )      *
//  Author  . . . : Thomas Raddatz   <thomas.raddatz@tools400.de>      *
//  Datum . . . . : 03.08.2000                                         *
//                                                                     *
// =================================================================== *

//===============================================================*
//  Common used prototypes
//===============================================================*

dcl-pr p_rmvPgmMsg extpgm('QMHRMVPM');
  i_callStackE  char(10) const;
  i_callStackC  int(10) const;
  i_msgKey      char(4) const;
  i_msgToRmv    char(10) const;
  i_errCode     char(32767) options(*varsize);
  i_lenCalStkE  int(10) options(*nopass);
  i_calStkEQual char(20) options(*nopass);
  i_rmvExcp     char(10) options(*nopass);
  i_calStkeDTyp char(10) options(*nopass);
end-pr;

dcl-pr p_testOmit extproc('CEETSTA');
  isPresent int(10);
  ArgNumber int(10) const;
  fc        char(12) options(*omit);
end-pr;

dcl-pr p_getOpDesc extproc('CEEDOD');
  posNr    int(10) const;
  descType int(10);
  datatype int(10);
  descInf1 int(10);
  descInf2 int(10);
  dataLen  int(10);
  fc       char(12) options(*omit);
end-pr;

