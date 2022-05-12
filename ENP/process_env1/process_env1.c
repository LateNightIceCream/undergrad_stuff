#include <stdio.h>
#include <stdlib.h>

int main(int argc, char* argv[], char* envp[]) {

    int i = 0;

    printf("Anzahl der Aufrufparameter: %d\n", argc);
    printf("============================\n");
    printf("Liste der Aufrufparameter:\n");


    for (i = 0; i < argc; i++) {
        printf("argv[%d]: %s\n", i, argv[i]);
    }

    printf("============================\n");

    /*while (*envp != NULL) {
        printf("%s\n", *envp);
        envp++;
    }*/

    i = 0;
    while (envp[i] != NULL) {
        printf("%s\n", envp[i]);
        i++;
    }

    return EXIT_SUCCESS;
    // exit (EXIT_SUCCESS)

    // ./a.out hallo welt

    // AUSGABE:
    /*
    Anzahl der Aufrufparameter: 3
    ============================
    Liste der Aufrufparameter:
    argv[0]: ./a.out
    argv[1]: hallo
    argv[2]: welt
    ============================
    SHELL=/bin/bash
    WINDOWID=92274702
    COLORTERM=truecolor
    XDG_CONFIG_DIRS=/usr/share/xdg:/etc/xdg:/usr/share
    XDG_SESSION_PATH=/org/freedesktop/DisplayManager/Session0
    __GL_MaxFramesAllowed=1
    GNOME_KEYRING_CONTROL=/home/zamza/.cache/keyring-KDH5Z0
    HISTSIZE=1000
    I3SOCK=/run/user/1000/i3/ipc-socket.999
    JAVA_HOME=/usr/lib64/openjdk-8
    DESKTOP_SESSION=i3
    XDG_SEAT=seat0
    PWD=/home/zamza/Documents/HS/Semester VI/ENP_AUFGABEN/process_env1
    LOGNAME=zamza
    XDG_SESSION_DESKTOP=i3
    QT_QPA_PLATFORMTHEME=gtk2
    XDG_SESSION_TYPE=x11
    XAUTHORITY=/home/zamza/.Xauthority
    DESKTOP_STARTUP_ID=i3/kitty/999-34-omega_TIME12274339
    XDG_GREETER_DATA_DIR=/var/lib/lightdm-data/zamza
    GDM_LANG=en_US.utf8
    HOME=/home/zamza
    LANG=en_US.UTF-8
    XDG_CURRENT_DESKTOP=i3
    KITTY_WINDOW_ID=1
    XDG_SEAT_PATH=/org/freedesktop/DisplayManager/Seat0
    XDG_SESSION_CLASS=user
    TERMINFO=/usr/lib/kitty/terminfo
    TERM=xterm-kitty
    USER=zamza
    DISPLAY=:0
    SHLVL=1
    INPUTRC=/etc/inputrc
    XDG_VTNR=7
    XDG_SESSION_ID=1
    XDG_RUNTIME_DIR=/run/user/1000
    QT_AUTO_SCREEN_SCALE_FACTOR=0
    XDG_DATA_DIRS=/home/zamza/.local/share/flatpak/exports/share:/var/lib/flatpak/exports/share:/usr/share:/var/lib/snapd/desktop/
    PATH=/sbin:/bin:/usr/sbin:/usr/bin:/snap/bin:/home/zamza/.local/bin
    HISTIGNORE=&:[bf]g:exit
    GDMSESSION=i3
    DBUS_SESSION_BUS_ADDRESS=unix:abstract=/tmp/dbus-r3EZDuTU1F,guid=a6dc3037794dc3f12ab43873604869c0
    OLDPWD=/home/zamza/Documents/HS/Semester VI/ENP_AUFGABEN
    _=./a.out
    */
}
