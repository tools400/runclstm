**free
/if NOT DEFINED(msg_t     )
/define msg_t
// ============================================================= *
//   Message structure                                           *
// ============================================================= *

dcl-ds msg_t qualified based(pDummy);
/if defined(*V5R3M0)
  ID   likeds(msgID_t);
/else
  ID   char(7);
/endif
  data char(512);
  type char(10);
  file char(10);
  lib  char(10);
end-ds;

/if defined(*V5R3M0)
dcl-ds msgID_t qualified based(pDummy);
  prefix char(3);
  nbr    zoned(4);
end-ds;
/endif

/endif
