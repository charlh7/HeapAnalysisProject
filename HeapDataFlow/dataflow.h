//Helper Functions to assist in Liveness Analysis

#include <vector>
#include "llvm/IR/Instructions.h"

using namespace llvm;

// ECE 5984 S18 Assignment 2: dataflow.h
// Group:
// http://www.cs.cmu.edu/~15745/15745_assignment2/code/Dataflow/
////////////////////////////////////////////////////////////////////////////////

#ifndef __CLASSICAL_DATAFLOW_H__
#define __CLASSICAL_DATAFLOW_H__

#include <stdio.h>
#include <iostream>
#include <queue>
#include <vector>
#include <string>
#include <utility>

#include "llvm/IR/Instructions.h"
#include "llvm/ADT/BitVector.h"
#include "llvm/IR/Constants.h"
#include "llvm/ADT/DenseMap.h"
#include "llvm/IR/ValueMap.h"
#include "llvm/IR/CFG.h"
#include "llvm/Support/raw_ostream.h"

// Add definitions (and code, depending on your strategy) for your dataflow
// abstraction here.

//These two functions work together to perform two tasks:
//	1: count the number of variables defined within the function
//	2: add each binary instruction to a vector (Since we are only interested in Instructions with Binary Operators) 
unsigned valueCount(Function &F, std::vector<Instruction*> &instVector);
unsigned addBBVals(BasicBlock* BB, std::vector<Instruction*> &instVector);

void outputBitVector(BitVector &bVector);
void outputValuesFromBVector(BitVector &bVector, std::vector<Instruction*> &instVector);
//std::string getShortValueName(Value * v);


//Returns a BitVector representing all of the definitions within the current BasicBlock
BitVector getDef(BasicBlock* BB, std::vector<Instruction*> instVector, BitVector &bVector);

//Returns a BitVector representing all uses within the current BasicBlock
BitVector getUse(BasicBlock* BB, std::vector<Instruction*> instVector, BitVector &bVector);
//A helper function that checks all of the operands of each instruction in the defVector
void checkOperands(std::vector<Instruction*> defVector, std::vector<Value*> opVector, BitVector &bVector);
std::vector<Value*> operandsToVector(Instruction *inst);

/*BitVector getIn(BasicBlock* BB, BitVector &origVector, BitVector &defVector, BitVector &useVector, std::vector<Instruction*> instVector, bool loop);

BitVector getOut(BasicBlock* BB, BitVector &origVector, std::vector<Instruction*> instVector);
*/



class BBInfo {
	//InOutBB InOutBB();
	public: 
	BBInfo(BitVector emptyVector); //Initialize all of the In's and Outs to Zero Vector
	BitVector Def;
	BitVector Use;
	BitVector In;
	BitVector Out;
	BasicBlock* thisBlock;
	std::vector<BBInfo*> successors;
	
	void getIn();
	void getOut();
	void getSuccessors();
};


void addSuccessors(BBInfo* currentBB, std::vector<BBInfo*> BBInfoList);

std::string getShortValueName(Value * v);




#endif



