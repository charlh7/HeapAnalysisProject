#ifndef __HEAP_LIVENESS_H__
#define __HEAP_LIVENESS_H__

#include "llvm/IR/Function.h"
#include "llvm/Pass.h"
#include "llvm/Support/raw_ostream.h"
#include "llvm/ADT/BitVector.h"


#include "livenessOperations.h"

using namespace llvm;

struct instStatement{
    instStatement(Instruction* xInst, Instruction* yInst){
        x = xInst;
        y = yInst;
    };
    Instruction* parent;
    Instruction* x;
    Instruction* y;
    BitVector statementType;

};






void outputLiveInfo(std::vector<InstAGInfo*> &InstAGInfoList, int infoTag, int index);
void outputType(InstAGInfo* instInfo);
std::vector<accessGraph*> createAGCopies(std::vector<accessGraph*> AGList);
bool findChanges(std::vector<accessGraph*> AGSet1, std::vector<accessGraph*> AGSet2);

void addSuccessors(InstAGInfo* &currentInst, std::vector<InstAGInfo*> InstAGList, std::vector<Instruction*> instList);
bool checkSuccessor(InstAGInfo* currInst, InstAGInfo* succInst, std::vector<Instruction*> instList);

bool checkForBranchAGInfo(Instruction* inst, InstAGInfo* succInstInfo);
bool nextInstInfoSearch(Instruction* inst, std::vector<InstAGInfo*> InstAGList, InstAGInfo* &foundAG);
unsigned getInstPosition(Instruction* inst, std::vector<Instruction*> instList, bool &found);
Instruction* findNearestInst(Instruction* inst, std::vector<Instruction*> instList);

void doAGLivenessAnalysis2(Function &F, std::vector<accessGraph*> AGList,  std::vector<Instruction*> rootList, std::vector<Instruction*> instList);

//void doAGLivenessAnalysis(Function &F, std::vector<accessGraph*> AGList,  std::vector<Instruction*> rootList, std::vector<Instruction*> instList);
void updateAGs(std::vector<InstAGInfo*> &InstAGInfoList, std::vector<Instruction*> rootList, std::vector<accessGraph*> AGList);

void removeStatementInsts(std::vector<Instruction*> &instList, std::vector<Instruction*> statementInsts);
void outputList(std::vector<Instruction*> instList);
void outputInstAGList(std::vector<InstAGInfo*> instAGList);
void outputAGList(std::vector<accessGraph*> AGList);

BitVector getInstTypes(std::vector<Instruction*> rootList, InstAGInfo* &instInfo,  Instruction* inst);
void findUnusedAGs(std::vector<Instruction*> rootList, std::vector<accessGraph*> usedAGs, std::vector<accessGraph*> &unusedAGs);
bool AGFound(std::vector<accessGraph*> usedAGs, Instruction* rootInst);
bool getAGsUsed(std::vector<accessGraph*> AGList, std::vector<accessGraph*> &usedAGs, std::vector<Instruction*> &statementInsts, Instruction* inst);
bool findRootUser(std::vector<Instruction*> rootList, std::vector<accessGraph*> &usedAGs, std::vector<Instruction*> &statementInsts, Instruction* inst, bool originalInst, unsigned operandNum = 0);
bool checkIfRoot(std::vector<Instruction*> AGList, Instruction* inst);
//bool checkIfRoot(std::vector<accessGraph*> AGList, accessGraph* &AG, Instruction* inst);



bool checkValidAssignment(Instruction* inst);
bool checkValidFunctionCall(Instruction* inst);
bool findCallInst(Instruction* currInst, bool &found, int limitCount);

//---------- ELGEN ---------------

//std::vector<accessGraph*> getELGen(InstAGInfo *instInfo, std::vector<accessGraph*> AGList, std::vector<accessGraph*> usedAGs, BitVector instTypes, Instruction* inst);




//std::vector<accessGraph*> getELIn(std::vector<Instruction*> instList, std::vector<Instruction*> ptrList, Instruction* inst);

//std::vector<accessGraph*> getELOut(std::vector<Instruction*> instList, std::vector<Instruction*> ptrList, Instruction* inst);




#endif
