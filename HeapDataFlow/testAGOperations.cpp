#include "testAGOperations.h"

void testUnion(std::vector<accessGraph*> AGList){

	if(AGList.size() > 1){
	  	std::vector<gEdge*> testDeletePath;
	  	accessGraph* refGraph = AGList[1];
	  	accessGraph* testGraph1 = new accessGraph(refGraph->getHead()->inst);
	  	testGraph1->addNode(refGraph->getNodeList()[1]);
	  	testGraph1->addNode(refGraph->getNodeList()[2]);
	  	
	  	errs() << "--- Test Graph 1 ---\n";
	  	testGraph1->outputGraph();
	  	
	    accessGraph* testGraph2 = new accessGraph(refGraph->getHead()->inst);
	    //testGraph2->addNode(refGraph->getNodeList()[1]);
	  	//testGraph2->addNode(refGraph->getNodeList()[2]);
	    testGraph2->addNode(refGraph->getNodeList()[3]);
	    testGraph2->addNode(refGraph->getNodeList()[4]);
	    
	    errs() << "--- Test Graph 2 ---\n";
	  	testGraph2->outputGraph();
	  	
	  	accessGraph* unionGraph = testGraph1->getUnion(testGraph2);
	  	errs() << "--- Union Graph --- \n";
	  	unionGraph->outputGraph();
	  	
	}
}

void testPathRemoval(std::vector<accessGraph*> AGList){
 
	if(AGList.size() > 1){
		std::vector<gEdge*> testDeletePath;
		accessGraph* testGraph = AGList[1];
		errs() << "Before Removal: \n";
		testGraph->outputGraph();

		testDeletePath.push_back(testGraph->getEdgeList()[0]);
		testDeletePath.push_back(testGraph->getEdgeList()[1]);
		testGraph->removePath(testDeletePath);
		errs() << "\nAfter Removal: \n";
		testGraph->outputGraph();

	}
}

void testFactorization(std::vector<accessGraph*> AGList){

	if(AGList.size() > 1){
		accessGraph* refGraph = AGList[1];
		accessGraph* testGraph1 = new accessGraph(refGraph->getHead()->inst);

		testGraph1->addEdge(refGraph->getEdgeList()[0]);
		testGraph1->addEdge(refGraph->getEdgeList()[1]);
		gEdge* newEdge = new gEdge(refGraph->getNodeList()[2], refGraph->getNodeList()[5]);
		gEdge* newEdge2 = new gEdge(refGraph->getNodeList()[2], refGraph->getNodeList()[6]);
		gEdge* newEdge3 = new gEdge(refGraph->getNodeList()[5], refGraph->getNodeList()[6]);

		errs() << "Made it here\n";
		testGraph1->addEdge(newEdge);
		testGraph1->addEdge(newEdge2);
		testGraph1->addEdge(newEdge3);

		accessGraph* testGraph2 = new accessGraph(refGraph->getHead()->inst);

		testGraph2->addEdge(refGraph->getEdgeList()[0]);
		testGraph2->addEdge(refGraph->getEdgeList()[1]);


		//testGraph1->addEdge(refGraph->getEdgeList()[4]);

		//testGraph1->addNode(refGraph->getNodeList()[0], refGraph->getNodeList()[1]);
		//testGraph1->addNode(refGraph->getNodeList()[1], refGraph->getNodeList()[2]);
		//testGraph1->addNode(refGraph->getNodeList()[2], refGraph->getNodeList()[3]);
		//testGraph1->addNode(refGraph->getNodeList()[3], refGraph->getNodeList()[4]);


		errs() << "\n---------- Reference Graph ----------\n";
		refGraph->outputGraph();

		errs() << "\n---------- Test Graph1 ----------\n";
		testGraph1->outputGraph();

		errs() << "\n---------- Test Graph2 ----------\n";
		testGraph2->outputGraph();

		//std::vector<gNode*> factorEndNodes;
		//factorEndNodes.push_back(refGraph->getNodeList()[2]);
		gNode* testEndNode = testGraph1->getNodeList()[2];
		errs() << "test end node: " << *testEndNode->inst << "\n"; 
		//std::vector<accessGraph*>  factors = refGraph->getFactorization(testGraph1, testEndNode);
		std::vector<accessGraph*>  factors = testGraph1->getFactorization(testGraph2, testEndNode);

		for(unsigned i = 0; i < factors.size(); i++){
			errs() << " Remainder Graph: \n";
			factors[i]->outputGraph();
		}

	}
	
}

void testExtension(std::vector<accessGraph*> AGList){

	if(AGList.size() > 1){
	  	accessGraph* refGraph = AGList[1];
	  	accessGraph* testGraph1 = new accessGraph(refGraph->getHead()->inst);
	  	
	  	testGraph1->addEdge(refGraph->getEdgeList()[0]);
	  	testGraph1->addEdge(refGraph->getEdgeList()[1]);
	  	
	  	accessGraph* testGraph2 = new accessGraph(refGraph->getNodeList()[3]->inst);
	  	
	  	testGraph2->addNode(refGraph->getNodeList()[5]);

	  	
	  	errs() << "\n---------- Reference Graph ----------\n";
	  	refGraph->outputGraph();
	  	
	  	errs() << "\n---------- Test Graph1 ----------\n";
	  	testGraph1->outputGraph();
	  	
	  	errs() << "\n---------- Test Graph2 ----------\n";
	  	testGraph2->outputGraph();
	  	
	  	std::vector<gNode*> nodeList;
	  	gNode* testNode = new gNode(*refGraph->getNodeList()[1]);
	  	//gNode* testNode = new gNode(*refGraph->getNodeList()[2]);
	  	//testNode->test = true;
	  	nodeList.push_back(testNode);
	  	
	  	std::vector<accessGraph*> remainderList;
	  	remainderList.push_back(testGraph2);
	  	
	  	
	  	accessGraph* extendedGraph = testGraph1->getExtension(nodeList, remainderList);
	  	
	  	errs() << "After Extension: \n";
	  	testGraph1->outputGraph();
	  	
	  }

}
