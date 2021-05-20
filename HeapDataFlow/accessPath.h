

#include <iostream>
#include <string>
#include <vector>
#include "llvm/IR/Function.h"
#include "llvm/IR/Instructions.h"
#include "llvm/Support/raw_ostream.h"

#ifndef __ACCESS_PATH_H__
#define __ACCESS_PATH_H__

using namespace llvm;

struct gNode{
	gNode(llvm::Instruction* i){
		inst = i;
		tag = "none";
	};
	~gNode(){};

	bool operator==(gNode g2){
        if(inst != g2.inst){
            return false;
        }
        if(tag != g2.tag){
            return false;
        }
//
//        if(inst != g2->inst){
//            return false;
//        }
//        if(tag != g2->tag){
//            return false;
//        }


        return true;
	}

	bool operator!=(gNode g2){
        return !(*this == g2);

	}
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
	bool operator==(gEdge g2){
        if(*head != *g2.head){

            errs() << "head different\n";
            return false;
        }
        if(*tail != *g2.tail){
            errs() << "tail different\n";
            return false;
        }

//        if(head != g2->head){
//            return false;
//        }
//        if(tail != g2->tail){
//            return false;
//        }



//        if(head->inst != g2->head->inst){
//            return false;
//        }
//        if(tail->inst != g2->tail->inst){
//            return false;
//        }
//        if(head->tag != g2->head->tag){
//            return false;
//        }
//        if(tail->tag != g2->tail->tag){
//            return false;
//        }
        return true;
	}


	bool operator!=(gEdge g2){
        return !(*this == g2);

	}

	gNode* head;
	gNode* tail;

	gEdge* parent;

	//std::vector
};

#endif
