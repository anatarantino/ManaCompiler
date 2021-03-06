#ifndef MANACOMPILER_NUMBERLIST_H
#define MANACOMPILER_NUMBERLIST_H

 struct number_node{
    int number;
    struct number_node * next;
};

typedef struct number_node * number_list;

number_list * create_number_list(int number);

int add_to_number_list(int number, number_list * number_list );

int remove_from_number_list(int number, number_list * number_list) ;

void print_number_list(number_list * number_list) ;

int find_number(int number, number_list * number_list);

void free_number_list(number_list * number_list) ;

#endif //MANACOMPILER_NUMBERLIST_H
