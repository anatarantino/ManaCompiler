#include "list.h"
#include <stdlib.h>
#include <string.h>
#include <stdio.h>

list * create_list(char * data){
    node * new_node;
    list * new_list = malloc(sizeof (list));
    *new_list = malloc(sizeof (node));
    new_node = *new_list;
    strcpy(new_node->data, data);
    new_node->type = NULL;
    new_node->next = NULL;
    return new_list;
}

//returns 1 if added and 0 if not
int add_to_list(char * data, char * type, list * list){
    node *new_node, *current, *prev = NULL;
    if(list == NULL){
        fprintf(stderr,"Error adding to list: list doesn't exist.\n");
        return 0;
    }
    current = *list;
    if(current->data == NULL){ //list is empty
        strcpy(current->data, data);
        current->type = type;
        return 1;
    }

    new_node = malloc(sizeof (node));
    strcpy(new_node->data, data);
    strcpy(new_node->type,type);

    new_node->next = current;
    *list = new_node;
    return 1;
}

//TODO: chequear que pasa cuando quiero remover el unico elemento que tiene una lista. Lo que hice fue ponerle que todo este en null pero no se si no habria que borrar la lista
//returns 1 if removed and 0 if not
int remove_from_list(char * data, list * list){

    if (list == NULL){
        fprintf(stderr, "Error removing from list: list does not exist.\n" );
        return 0;
    }
    node * current = *list;

    if(strcmp(current->data, data) == 0){
        if(current->next == NULL){ //it's the only item
            current->data = NULL;
            current->type = NULL;
            return 1;
        }else{
            *list = current->next;
            free(current);
            return 1;
        }
    }
    node * prev = current;
    current = current->next;

    //loop through list to find node
    while(current != NULL) {
        if(strcmp(current->data, data) == 0){
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

int add_to_text_list(char * data,list * list){
    return add_to_list(data, "TEXT_LIST", list);
}


void print_list(list * list){
    node * current = *list;
    while(current != NULL){
        if(current->next != NULL){
            printf("%s, ",current->data);
        }else{ //it's the last item
            printf("%s\n",current->data);
        }
        current = current->next;
    }
}

int find(char * data, list * list, char * type){
    node * current = *list;
    while(current != NULL){
        if(strcmp(current->data,data)==0){
            strcpy(type,current->type);
            return 1;
        }
        current = current->next;
    }
    return 0;
}

void free_list(list * list){
    node * current = *list;
    node * next;
    while(current != NULL){
        next = current->next;
        free(current);
        current = next;
    }
    free(list);

}


