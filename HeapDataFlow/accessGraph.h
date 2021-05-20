//---- Access Graph -----
// Data Structure used to implement representation and operations of access expressions
#ifndef __ACCESS_GRAPH_H__
#define __ACCESS_GRAPH_H__

#include "accessPath.h"
using namespace llvm;


//Access Graph is a set of Access Paths directed graph represented by <n0, N, E>
//Can be denoted with <n0, N, E>, where:
//n0: root variable of the access paths
//N: set of nodes (n0 is an element of N, w/ no in-edges)

//E: set of edges

class accessGraph{


	public:
		accessGraph();
		accessGraph(llvm::Instruction* p);

		bool operator==(accessGraph g2);
		bool operator!=(accessGraph g2){
            return !(*this == g2);

        }

		//Operations that must have the same entry node
		bool isEmpty();
		accessGraph* getUnion(accessGraph* AG);

		accessGraph* copyGraph();

		void removePath(std::vector<gEdge*> path);
		void deletePath(std::vector<gEdge*> path);
		void removeEdge(gEdge* e);
		void removeAll();
		bool isHeadEdge(gEdge* e);
		void updateNodes();

		std::vector<accessGraph*> getFactorization(accessGraph* AG, gNode* endNode);
		bool checkNodes(std::vector<gNode*> nodeList);
		std::vector<gEdge*> getCEdges(accessGraph* AG);
		std::vector<gEdge*> getOutEdges(std::vector<gEdge*> remainderEdges, gNode* endNode);
		//std::vector<gEdge*> getRemainderEdges(std::vector<gEdge*> dividendEdges, std::vector<gEdge*> removeList);
		std::vector< std::vector<gEdge*> > getRemainderPaths(std::vector<gEdge*> removeList, gNode* endNode);

		std::vector<gEdge*> constructPath(std::vector<gEdge*> remainderList, gEdge* outgoingEdge);

		std::vector<gEdge*> getFactorEdges(std::vector<gEdge*> cEdges, gNode* endNode);
		gEdge* findNextEdge(std::vector<gEdge*> edgeList, gNode* currentNode);

		accessGraph* getExtension(std::vector<gNode*> nodeList, std::vector<accessGraph*> remainders);
		bool findNode(gNode* &n);
		void extendNode(gNode* currentNode, std::vector<accessGraph*> remainders);


		gNode* getHead();
		gNode* getNode(Instruction* inst);
		void setHead(gNode* newHead);
		void setHeadTag(std::string newTag);

		int getStatementType();
		void setStatementType(int newType);
		void setRemainder(bool remainderStatus);
		bool isRemainder();
		std::vector<gNode*> getNodeList();
		gNode* getLastNode();
		std::vector<gEdge*> getEdgeList();

		void makeGraph();
		void trackStorage(Instruction* inst);
		void addNode(llvm::Instruction* inst);
		void addNode(gNode* node);
		void addNode(gNode* head, gNode* newNode);
		void addEdge(gEdge* e);
		void createNode(gNode* parentInst, llvm::Instruction* childInst);


		bool checkForPath(std::vector<gEdge*> path);
		bool checkForPointer(Instruction* ptr);
		bool checkForEdge(gEdge* e);

		//Find out if a node exists corresponding to instruction
		bool findInstNode(llvm::Instruction* inst);

		void outputGraph();
		void outputGraphByInst();

	private:
		int iterationCount;
		gNode* head;
		gNode* lastNode;
		std::vector<gNode*> nodes;
		std::vector<gEdge*> edges;
		bool remainderGraph;
		bool headRemoved;

		int statementType; //Statement types include 0, 1, and 2; corresponding to x, y and z
};

void createAccessGraphs(Function &F, std::vector<Instruction*> ptrList, std::vector<accessGraph*> &AGList);

bool checkEdgeInList(std::vector<gEdge*> edgeList, gEdge* e);
bool checkEdgeHeadsInList(std::vector<gEdge*> edgeList, gNode* e, gEdge* &edgeFound);
unsigned findAG(std::vector<accessGraph*> AGList, Instruction* inst);
bool checkForAG(std::vector<accessGraph*> AGList, Instruction* inst);
void handlePHINode(std::vector<accessGraph*> AGList, Instruction* inst);
bool checkForNode(std::vector<gNode*> nodes, gNode* node);

#endif

