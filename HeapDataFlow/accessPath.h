

#include <iostream>
#include <string>
#include <vector>
#include "llvm/IR/Function.h"
#include "llvm/IR/Instructions.h"
#include "llvm/Support/raw_ostream.h"

#ifndef __ACCESS_PATH_H__
#define __ACCESS_PATH_H__

struct gNode{
	gNode(llvm::Instruction* i){
		inst = i;
		tag = "none";
	};
	~gNode(){};
	std::string tag;
	llvm::Instruction* inst;
	gNode* pred;
	std::vector<gNode*> succ;

};

struct gEdge{
	gEdge(){
		head = NULL;
		tail = NULL;
	}
	gEdge(gNode* h, gNode* t){
		head = h;
		tail = t;
	};
	bool operator==(gEdge* g2){
        if(head->inst != g2->head->inst){
            return false;
        }
        if(tail->inst != g2->tail->inst){
            return false;
        }
        if(head->tag != g2->head->tag){
            return false;
        }
        if(tail->tag != g2->tail->tag){
            return false;
        }
        return true;
	};

	gNode* head;
	gNode* tail;

	gEdge* parent;

	//std::vector
};

#endif
