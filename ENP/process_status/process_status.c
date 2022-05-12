#include <stdio.h>
#include <sys/types.h>
#include <unistd.h>
#include <stdlib.h>
#include <sys/wait.h>

void child_print (char* str);
void evaluate_exit_status (int wstatus);
void child_function (void);
char get_termination_type (void);

int
main(int argc, char *argv[]) {

  int wstatus;

  if (fork() == 0) {
    child_function();
  }

  wait(&wstatus);
  evaluate_exit_status(wstatus);

  return EXIT_SUCCESS;
}

void
evaluate_exit_status (int wstatus) {

  int ecode;
  int signo;

  if (WIFEXITED(wstatus)) {

    ecode = WEXITSTATUS(wstatus);
    printf("Parent: Child exited with Error Code %d\n", ecode);

  }
  else if (WIFSIGNALED(wstatus)) {

    signo = WTERMSIG(wstatus);
    printf("Parent: Child exited by Signal %d\n", signo);

    #ifdef WCOREDUMP
    if (WCOREDUMP(wstatus)) {
      printf("Parent: Child produced a core dump\n");
    }
    #else
    printf("WCOREDUMP not available\n");
    #endif

  }
  else if (WIFSTOPPED(wstatus)) {

    signo = WSTOPSIG(wstatus);
    printf("Parent: Child exited by Signal %d\n", signo);

  }
}

void child_function () {

  char term_type;
  int  div;
  int* notAllowed;

  term_type = get_termination_type();

  switch (term_type) {

  default:
    child_print("Something broke");
    exit(EXIT_FAILURE);
    break;

  case '1':
    child_print("Exiting with EXIT_SUCCESS");
    exit(EXIT_SUCCESS);
    break;

  case '2':
    child_print("Exiting with EXIT_FAILURE");
    exit(EXIT_FAILURE);
    break;

  case '3':
    child_print("Exiting with Exit Code 42");
    exit(42);
    break;

  case '4':
    div = 10;
    float f = 1.1;
    child_print("Exiting because of division by zero");
    f = f/0;
    //div = div / 0;
    break;

  case '5':
    child_print("Exiting because of writing somewhere im not permitted to");
    // Einfache Methode:
    /*
    notAllowed  = NULL;
    *notAllowed = 0xFEEDBEEF;
    */

    // Alternative:
    // Versuch, eine Adresse höher zu beschreiben, als Grenze des zugewiesenen
    // Speicherbereiches
    void* programBreak = sbrk(0);
    notAllowed = (int*)programBreak + 1;

    *notAllowed = 0xDEAD;
    break;
  }
}

void
child_print (char* str) {
  printf("Child: %s\n", str);
}

char
get_termination_type () {

  char chosen = 0;

  while (chosen < '1' || chosen > '5') {

    printf("Terminierungsart wählen:\n");
    printf("[1] Normale Terminierung mit EXIT_SUCCESS\n");
    printf("[2] Normale Terminierung mit EXIT_FAILURE\n");
    printf("[3] Normale Terminierung mit frei wählbarem Exit-Code\n");
    printf("[4] Abnormale Terminierung aufgrund Division durch 0 bei Integer Zahlen\n");
    printf("[5] Abnormale Terminierung  durch Schreiben in nicht zulässigen Speicherbereich\n");
    printf("===========================\n");

    chosen = getchar();

  }

  // return chosen - '0';
  return chosen;
}

// AUSGABE
// ./a.out
/*
  Terminierungsart wählen:
  [1] Normale Terminierung mit EXIT_SUCCESS
  [2] Normale Terminierung mit EXIT_FAILURE
  [3] Normale Terminierung mit frei wählbarem Exit-Code
  [4] Abnormale Terminierung aufgrund Division durch 0 bei Integer Zahlen
  [5] Abnormale Terminierung  durch Schreiben in nicht zulässigen Speicherbereich
  ===========================
*/

// > 1
/*
  Child: Exiting with EXIT_SUCCESS
  Parent: Child exited with Error Code 0
*/

// > 2
/*
  Child: Exiting with EXIT_FAILURE
  Parent: Child exited with Error Code 1
*/

// > 3
/*
  Child: Exiting with Exit Code 42
  Parent: Child exited with Error Code 42
*/

// > 4
/*
  Child: Exiting because of division by zero
  Parent: Child exited by Signal 124
  Parent: Child produced a core dump
  Parent: Child exited with Error Code 0
*/
// => nicht wie erwartet der Fehlercode 8, sondern 0
// Bei Test auf Rechner eines Kommilitonen kam 8 als
// Ausgabe

// > 5
/*
  Child: Exiting because of writing somewhere im not permitted to
  Parent: Child exited by Signal 11
  Parent: Child produced a core dump
*/
