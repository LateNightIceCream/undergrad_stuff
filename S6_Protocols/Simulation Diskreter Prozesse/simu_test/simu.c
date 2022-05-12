#include <stdio.h>
#include <stdlib.h>

#define NUM_ITERATIONS 10
#define MAX_EVENT_LIST_LEN 1000

struct event {
    int appearance_time;
    int type;
};

struct event_list {
    int length;
    int current_pos;
    struct event* list[MAX_EVENT_LIST_LEN];
};

struct queue {
    int length;
};


void init_event_list (struct event_list* e_list);


int sim_time = 0;
int
main () {

    struct event_list event_list;

    struct queue q_A;
    struct queue q_B;

    init_event_list(&event_list);

    int i = 0;
    while (i < NUM_ITERATIONS) {

        // nächstes event laden


        i++;
    }


    return EXIT_SUCCESS;
}

void
init_event_list (struct event_list* e_list) {
    e_list->length      = 0;
    e_list->current_pos = 0;
}

void schedule_next_event (int time, int type, struct event_list* e_list) {

    switch(type) {

        default:
        case 1:

            break;

        case 2:
            break;
    }
}
