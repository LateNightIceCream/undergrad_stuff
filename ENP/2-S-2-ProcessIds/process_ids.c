#include <stdio.h>
#include <sys/types.h>
#include <unistd.h>

int main(int argc, char *argv[]) {

    // Prozess-ID des Prozesses
    printf("PID:\t%d\n", getpid());

    // Prozess-ID des Vaterprozesses (z.B. Terminal)
    printf("PPID:\t%d\n", getppid());

    // Benutzer-ID
    printf("UID:\t%d\n", getuid());

    // Effektive Nutzer-ID
    printf("EUID:\t%d\n", geteuid());

    // Gruppen-ID
    printf("GID:\t%d\n", getgid());

    // Effektive Gruppej-ID
    printf("EGID:\t%d\n", getegid());

    return 0;

    // ./a.out

    // AUSGABE:
    /*
    PID:	17812
    PPID:	8868
    UID:	1000
    EUID:	1000
    GID:	1000
    EGID:	1000
    */

    // ps im Terminal liefert folgende Ausgabe:
    /*
    > ps
    PID TTY       TIME     CMD
    8868 pts/0    00:00:00 bash
    15934 pts/0   00:00:00 ps
    */

    // wenn man nun noch einen Prozess über das
    // Terminal startet erhält man z.B.:
    /*
    > emacs &
    > ps
    PID TTY        TIME     CMD
    8868 pts/0     00:00:00 bash
    15994 pts/0    00:00:00 emacs
    15999 pts/0    00:00:00 ps
    */

    // Mit pstree kann man es auch grafisch
    // verfolgen
    /*
    ├─kitty─┬─bash─┬─emacs───3*[{emacs}]
            │      │       └─pstree
    */

    // Die effektiven Nutzer- und Gruppen-Ids können spezifisch
    // für einen Prozess gesetzt werden (z.B. mit setuid(2)), um z.B.
    // Zugriffsbeschränkungen für einen Prozess zu erteilen

    // Ausschnitt aus /etc/passwd
    /*
      zamza:x:1000:1000:Richie:/home/zamza:/bin/bash
    */
    // Struktur der Zeile:
    // Username:Passwort:UID:GID:Kommentar:Home-Verzeichnis:Login-Befehl
    // -> UID und GID stimmen mit der Ausgabe dieses
    // Programmes überein.

    // Ausschnitt aus /etc/group
    /*
      zamza:x:1000:
    */
    // Struktur: Gruppenname:Passwort:GID:Zugehörige Nutzer
}
