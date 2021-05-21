//Tree Traversal Example Program

//Refenced from Figure 1.1 (pg 2) in 
//"Data Flow Analysis: Theory and Practice" by Uday P. Khedker, Amitabha Sanyal, and Bageshri Karkare

#include <stdio.h>
#include <string.h>
#include <stdlib.h>

typedef struct Node{
	struct Node* rptr;
	struct Node* lptr;
	int data;
	int sum;
}Node;

void createTree(struct Node *head){

	//Creating Tree used in the Book:

	//Level 1: (1)
	//head = x;
	head->data = 1;

	//Level 2: (1) -child-> (2), (2) -sib-> (3), (3) -sib-> (4)
	
	struct Node *node2 = malloc(sizeof (struct Node) ); //x->rptr
	struct Node *node3 = malloc(sizeof (struct Node) );
	struct Node *node4 = malloc(sizeof (struct Node) );
	
	struct Node *node5 = malloc(sizeof (struct Node) ); //x->lptr
	struct Node *node6 = malloc(sizeof (struct Node) );
	struct Node *node7 = malloc(sizeof (struct Node) );
	
	
	node2->data = 2;
	node3->data = 3;
	node4->data = 4;
	
	node5->data = 12;
	node6->data = 13;
	node7->data = 14;
	
	head->rptr = node2;
	head->lptr = node5;
	
	node2->rptr = node3;
	node2->lptr = node6;
	
	node3->rptr = node4;
	node3->lptr = node7;	
	
}

void testCode(struct Node *x, int max){
	struct Node* w;
	struct Node* y;
	w = x;
	
	while(x->data < max){
		x = x->rptr;
	}
	
	y = x->lptr;
	struct Node *z = malloc(sizeof (struct Node) );
	y = y->lptr;
	z->sum = x->lptr->data + y->data; //This just doubles y->data
	
	//printf("x data: %d\n", x->data);
	//printf("y data: %d\n", y->data);
	//printf("z sum: %d\n", z->sum);
	
}

int main(int argc, char **argv){

	int max;
	if(argc == 2){
		//printf("Num args: %i\n", argc);
		printf("Input arg: %s\n", argv[1]);
		max = atoi(argv[1]);
		if(max > 3){
			max = 3;
		}
		printf("Max: %i\n", max);
		
	}
	else{
		printf("No input args - max set to 3\n");
		max = 3;
		
	}
	struct Node *xTree = malloc(sizeof (struct Node));
	createTree(xTree);
	testCode(xTree, max);
	
	return 0;
}
