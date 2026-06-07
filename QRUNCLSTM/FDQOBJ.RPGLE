**free
/if NOT DEFINED(qObj_t    )
/define qObj_t
// ============================================================= *
//   Qualified object name                                       *
//===============================================================*

dcl-ds qObj_t qualified based(pDummy);
  name char(10);
  lib  char(10);
end-ds;

/endif
