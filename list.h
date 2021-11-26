#ifndef MANACOMPILER_LIST_H
#define MANACOMPILER_LIST_H

typedef struct node {
    char * data;
    char * type;
    struct node * next;
}node;

typedef node * list;

list * create_list(char * data);

int add_to_list(char * data, char * type, list * list);
int add_to_text_list(char * data,list * list);

int remove_from_list(char * data, list * list);

void print_list(list * list);

int find(char * data, list * list, char * type);

void free_list(list * list);



#endif //MANACOMPILER_LIST_H
