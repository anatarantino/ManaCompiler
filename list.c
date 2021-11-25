#include "list.h"

typedef struct node {
    char * data;
    char type[10]; //char *, int, textlist, numlist
    struct node * next;
}node;

