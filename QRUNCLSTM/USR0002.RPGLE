**free
//---------------------------------------------------------------
// Datenstruktur für Message-ID : USR0002

// Fehler bei Befehlsausführung in Zeile &1.

dcl-ds USR0002;
  USR00021 packed(006: 2) inz(*zeros);
  USR00022 char(512) inz(*blanks);
end-ds;
dcl-s USR0002# bindec(8) inz(0516);

