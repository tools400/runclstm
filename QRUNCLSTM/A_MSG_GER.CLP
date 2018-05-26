     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR0001                    */
     /* Länge ausserhalb des gültigen Bereichs.                     */
     /*-------------------------------------------------------------*/

             PGM        PARM(&LI)

             DCL        VAR(&LI) TYPE(*CHAR) LEN(10)

             RMVMSGD MSGID(USR0001) MSGF(&LI/RUNCLSTM)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR0001) +
                MSGF(&LI/RUNCLSTM) +
                MSG(+
'Länge ausserhalb des gültigen Bereichs.'                             +
                ) +
                SEV(00) +
     /*   Keine Ersatzvariablen definiert!                          */ +
                ALROPT(*NO) +
                CCSID( 65535) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR0002                    */
     /* Fehler bei Befehlsausführung in Zeile &1.                   */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR0002) MSGF(&LI/RUNCLSTM)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR0002) +
                MSGF(&LI/RUNCLSTM) +
                MSG(+
'Fehler bei Befehlsausführung in Zeile &1.'                           +
                ) +
                SECLVL(+
'Befehl  . . . . : &2'                                                +
                ) +
                SEV(30) +
                FMT( +
                    (*DEC 006 2) +
                    (*CHAR 512) +
                ) +
                ALROPT(*NO) +
                CCSID( 65535) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR0003                    */
     /* Die Betriebsart &1 ist bereits eingestellt worden.          */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR0003) MSGF(&LI/RUNCLSTM)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR0003) +
                MSGF(&LI/RUNCLSTM) +
                MSG(+
'Die Betriebsart &1 ist bereits eingestellt worden.'                  +
                ) +
                SECLVL(+
'Maßnahmen . . . :   Stellen Sie sicher, dass die Anweisung &2 nicht z-
weimal hintereinander verwendet wird. Die Anweisung &2 muss immer mit -
&3 beendet werden.'                                                   +
                ) +
                SEV(00) +
                FMT( +
                    (*CHAR 010) +
                    (*CHAR 010) +
                    (*CHAR 010) +
                ) +
                ALROPT(*NO) +
                CCSID( 65535) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR0004                    */
     /* Die Betriebsart &1 ist bereits eingestellt worden.          */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR0004) MSGF(&LI/RUNCLSTM)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR0004) +
                MSGF(&LI/RUNCLSTM) +
                MSG(+
'Die Betriebsart &1 ist bereits eingestellt worden.'                  +
                ) +
                SECLVL(+
'Maßnahmen . . . :   Stellen Sie sicher, dass die Anweisung &2 nicht z-
weimal hintereinander verwendet wird. Die Anweisung &2 muss immer mit -
&3 eingeleitet werden.'                                               +
                ) +
                SEV(00) +
                FMT( +
                    (*CHAR 010) +
                    (*CHAR 010) +
                    (*CHAR 010) +
                ) +
                ALROPT(*NO) +
                CCSID( 65535) +
                /*  -EOF-  */

             RCLRSC LVL(*)

             ENDPGM
