**free
//---------------------------------------------------------------
// Datenstruktur für Message-ID : USR0004

// Die Betriebsart &1 ist bereits eingestellt worden.

dcl-ds USR0004;
  USR00041 char(010) inz(*blanks);
  USR00042 char(010) inz(*blanks);
  USR00043 char(010) inz(*blanks);
end-ds;
dcl-s USR0004# bindec(8) inz(0030);

