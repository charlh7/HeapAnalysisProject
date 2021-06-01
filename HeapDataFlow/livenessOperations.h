#ifndef __HEAP_LIVENESS_OPS_H__
#define __HEAP_LIVENESS_OPS_H__

#include "accessGraph.h"
#include "dataflow.h"

class InstAGInfo {
	//InOutBB InOutBB();
	public:
		InstAGInfo(std::vector<accessGraph*> AGList, std::vector<Instruction*> rList){

            rootList = rList;

            for(unsigned i = 0; i < AGList.size(); i++){
                //accessGraph* newAG = new accessGraph(AGList[i]->getHead()->inst);
                //ELOut.push_back(newAG);
			}
			updating = false;
			//ELOut = AGList;
			//std::vector<accessGraph*> unusedAGsInit;
			//unusedAGs = unusedAGsInit;
			//std::vector<accessGraph*> usedAGs
		};

		BitVector instType;
		bool updating;
		int instNumber;

		std::vector<Instruction*> rootList;

		std::vector<Instruction*> statementInsts;

		std::vector<accessGraph*> *AGList;
		std::vector<accessGraph*> usedAGs;
		std::vector<accessGraph*> unusedAGs;

		std::vector<accessGraph*> ELGen;
		std::vector<accessGraph*> LDirect;
		std::vector<accessGraph*> LTransfer;
		accessGraph* Gy;
		accessGraph* Gx;

		//std::vector<std::vector<gEdge*>> ELKillPath;
		std::vector<gEdge*> ELKillPath;
		std::vector<accessGraph*> ELIn;
		std::vector<accessGraph*> ELOut;

		BasicBlock* thisBlock;
		Instruction* thisInst;
		std::vector<InstAGInfo*> successors;

		std::vector<accessGraph*> getELIn();
		std::vector<accessGraph*> getELOut();
		accessGraph* getELOutFromRoot(Instruction* root);
		accessGraph* getELInFromRoot(Instruction* root);
		accessGraph* getELGenFromRoot(Instruction* root);
		void getSuccessors();
};

std::string findRootTag(std::vector<Instruction*> rootList, Instruction* inst);

std::vector<accessGraph*> getELGen( std::vector<accessGraph*> AGList, std::vector<Instruction*> rootList, InstAGInfo *instInfo, Instruction* inst);
std::vector<Instruction*> extractStatementInsts(Instruction* rootInst, std::vector<Instruction*> statementInsts);

std::vector<accessGraph*> getLDirect( std::vector<accessGraph*> AGList, std::vector<Instruction*> rootList, InstAGInfo *instInfo, Instruction* inst);

std::vector<accessGraph*> getLDirectAssignment( std::vector<accessGraph*> AGList, std::vector<Instruction*> rootList, InstAGInfo *instInfo, Instruction* inst);
Instruction* findStoreInst(std::vector<Instruction*> instList);
std::vector<Instruction*> extractAssignmentStatementInsts(Instruction* rootInst, std::vector<Instruction*> &statementInsts);

std::vector<accessGraph*> getLDirectFunctionCall(std::vector<accessGraph*> AGList, std::vector<Instruction*> rootList, InstAGInfo *instInfo, Instruction* inst);
std::vector<Instruction*> extractFCallStatementInsts(Instruction* rootInst, std::vector<Instruction*> &statementInsts);
void getPathsFromInst(accessGraph* AG, std::vector<gEdge*> &newEdgeList,  Instruction* inst);


std::vector<accessGraph*> getLDirectReturn(std::vector<accessGraph*> AGList, std::vector<Instruction*> rootList, InstAGInfo *instInfo, Instruction* inst);
std::vector<accessGraph*> getLDirectUse( std::vector<accessGraph*> AGList, std::vector<Instruction*> rootList, InstAGInfo *instInfo, Instruction* inst);
std::vector<Instruction*> extractStatementInsts(Instruction* rootInst, std::vector<Instruction*> statementInsts);
bool isAUser(Instruction* inst, Instruction* user);
unsigned getNumMemNodes(std::vector<Instruction*> statementInsts, std::vector<Instruction*> &nodeInsts, Instruction* rootInst);
accessGraph* addPathToAccessGraph(InstAGInfo *instInfo, std::vector<Instruction*> nodeInsts, Instruction* root, unsigned numNodes);
std::string createTag(InstAGInfo *instInfo, unsigned nodeNum);

std::vector<accessGraph*> getLTransfer( std::vector<accessGraph*> AGList, std::vector<Instruction*> rootList, InstAGInfo *instInfo, Instruction* inst);
std::vector<accessGraph*> getLTransferAssignment( std::vector<accessGraph*> AGList, std::vector<Instruction*> rootList, InstAGInfo *instInfo, Instruction* inst);
//std::vector<accessGraph*> getLTransferFunctionCall(InstAGInfo *instInfo, std::vector<accessGraph*> AGList, std::vector<accessGraph*> usedAGs, BitVector instTypes, Instruction* inst);
//std::vector<accessGraph*> getLTransferReturn(InstAGInfo *instInfo, std::vector<accessGraph*> AGList, std::vector<accessGraph*> usedAGs, BitVector instTypes, Instruction* inst);
//std::vector<accessGraph*> getLTransferUse(InstAGInfo *instInfo, std::vector<accessGraph*> AGList, std::vector<accessGraph*> usedAGs, BitVector instTypes, Instruction* inst);

accessGraph* makeGraphFromBase(accessGraph* AG, Instruction* inst);
accessGraph* makeGraphFromPath(accessGraph* AG, Instruction* inst);
bool findPreviousNode(accessGraph* AG, Instruction* inst, gNode* &prevNode);
bool AGInList(std::vector<accessGraph*> AGList, accessGraph* AG, unsigned &index);
bool AGInList(std::vector<accessGraph*> AGList, accessGraph* AG);

//---------- ELKill ---------------

std::vector<gEdge*> getELKill( std::vector<accessGraph*> AGList, std::vector<Instruction*> rootList, InstAGInfo *instInfo, Instruction* inst);
std::vector<Instruction*> extractKillStatementInsts(Instruction* rootInst, std::vector<Instruction*> &statementInsts);
std::vector<gEdge*> getELKillAssignment(std::vector<accessGraph*> AGList, std::vector<Instruction*> rootList, InstAGInfo *instInfo, Instruction* inst);
std::vector<gEdge*> getELKillFunctionCall(std::vector<accessGraph*> AGList, std::vector<Instruction*> rootList, InstAGInfo *instInfo, Instruction* inst);

#endif
