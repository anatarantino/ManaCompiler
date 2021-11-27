#include "numberList.h"
#include <stdio.h>
#include <stdlib.h>
#include <stdio.h>

number_list * create_number_list(int number){
    struct number_node * new_node;
    number_list * new_list = (number_list *)malloc(sizeof (number_list));
    *new_list = (struct number_node *)malloc(sizeof (struct number_node));
    new_node = *new_list;
    new_node->number = number;
    new_node->next = NULL;
    return new_list;
}

int add_to_number_list(int number, number_list * number_list) {
    struct number_node *new_node, *current, *prev = NULL;
    if(number_list == NULL){
        fprintf(stderr,"Error adding to list: list doesn't exist.\n");
        return 0;
    }
    current = *number_list;

    new_node = malloc(sizeof (struct number_node));
    new_node->number = number;

    new_node->next = current;
    *number_list = new_node;
    return 1;
}

int remove_from_number_list(int number, number_list * number_list) {
    if (number_list == NULL){
        fprintf(stderr, "Error removing from list: list does not exist.\n" );
        return 0;
    }
    struct number_node * current = *number_list;

    if(current->number == number){
        if(current->next == NULL){ //it's the only item
            fprintf(stderr, "Error deleting number. This list can't be empty.\n");
            return 0;
        }else{
            *number_list = current->next;
            free(current);
            return 1;
        }
    }
    struct number_node * prev = current;
    current = current->next;

    //loop through list to find node
    while(current != NULL) {
        if(current->number == number){
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
    struct number_node * current = *number_list;
    while(current != NULL){
        if(current->next != NULL){
            printf("%d, ",current->number);
        }else{ //it's the last item
            printf("%d\n",current->number);
        }
        current = current->next;
    }
}

int find_number(int number, number_list * number_list){
    struct number_node * current = *number_list;
    while(current != NULL){
        if(current->number == number){
            return 1;
        }
        current = current->next;
    }
    return 0;
}

void free_number_list(number_list * number_list) {
    struct number_node * current = *number_list;
    struct number_node * next;
    while(current != NULL){
        next = current->next;
        free(current);
        current = next;
    }
    free(number_list);
}

