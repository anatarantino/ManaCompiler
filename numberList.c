#include "numberList.h"
#include <stdio.h>
#include <stdlib.h>
#include <stdio.h>

number_list * create_number_list(int data){
    number_node * new_node;
    number_list * new_list = malloc(sizeof (number_list));
    *new_list = malloc(sizeof (number_node));
    new_node = *new_list;
    new_node->number = data;
    new_node->next = NULL;
    return new_list;
}

int add_to_number_list(int data, number_list * number_list) {
    number_node *new_node, *current, *prev = NULL;
    if(number_list == NULL){
        fprintf(stderr,"Error adding to list: list doesn't exist.\n");
        return 0;
    }
    current = *number_list;
    if(current->data == NULL){ //list is empty
        current->data = data;
        return 1;
    }

    new_node = malloc(sizeof (node));
    new_node->data = data;

    new_node->next = current;
    *number_list = new_node;
    return 1;
}

int remove_from_number_list(int data, number_list * number_list) {
    if (number_list == NULL){
        fprintf(stderr, "Error removing from list: list does not exist.\n" );
        return 0;
    }
    number_node * current = *number_list;

    if(current->data == data){
        if(current->next == NULL){ //it's the only item
            current->data = NULL;
            return 1;
        }else{
            *number_list = current->next;
            free(current);
            return 1;
        }
    }
    number_node * prev = current;
    current = current->next;

    //loop through list to find node
    while(current != NULL) {
        if(current->data == data){
            if(current->next != NULL){
                prev->next = current->next;
                free(current);
                return 1;
            }else{
                prev->next = NULL;
                free(current);
                return 1;
            }
        }
        prev = current;
        current = current->next;
    }

    fprintf(stderr, "Error removing item from list: item does not exist.\n");
    return 0;
}

void print_number_list(number_list * number_list) {
    number_node * current = *number_list;
    while(current != null){
        if(current->next != NULL){
            printf("%d, ",current->data);
        }else{ //it's the last item
            printf("%d\n",current->data);
        }
        current = current->next;
    }
}

int find_number(int data, number_list * number_list){
    number_node * current = *number_list;
    while(current != NULL){
        if(current->data == data){
            return 1;
        }
        current = current->next;
    }
    return 0;
}

void free_number_list(number_list * number_list) {
    number_node * current = *number_list;
    number_node * next;
    while(current != NULL){
        next = current->next;
        free(current);
        current = next;
    }
    free(number_list);
}

