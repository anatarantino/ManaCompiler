#ifndef MANACOMPILER_LIST_H
#define MANACOMPILER_LIST_H

typedef struct node {
    char * data;
    char type[10]; //char *, int, textlist, numlist
    struct node * next;
}node;

typedef node * list;

list * create_list(char * list_nama);

int add_to_list(char * data, char * type, list * list_name);
int add_to_text_list(char * data,list * list_name);

int remove_from_list(char * data, list * list_name);
int remove_from_text_list(char * data,list * list_name);

void print_list(list * list_name);

int find(char * data, list * list);

void free_list(list * list);



#endif //MANACOMPILER_LIST_H
