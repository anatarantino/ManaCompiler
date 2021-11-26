#ifndef MANACOMPILER_LIST_H
#define MANACOMPILER_LIST_H

enum type{NONE=-1, TEXT=0, NUM};

typedef struct node {
    char * data;
    int type;
    struct node * next;
}node;

typedef node * list;

list * create_list(char * data);

int add_to_list(char * data, int type, list * list);
int add_to_text_list(char * data,list * list);

int remove_from_list(char * data, list * list);

void print_list(list * list);

int find(char * data, list * list, int type);

void free_list(list * list);



#endif //MANACOMPILER_LIST_H
