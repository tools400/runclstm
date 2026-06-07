**free
//---------------------------------------------------------------
// Datenstruktur für Message-ID : USR0003

// Die Betriebsart &1 ist bereits eingestellt worden.

dcl-ds USR0003;
  USR00031 char(010) inz(*blanks);
  USR00032 char(010) inz(*blanks);
  USR00033 char(010) inz(*blanks);
end-ds;
dcl-s USR0003# bindec(8) inz(0030);

