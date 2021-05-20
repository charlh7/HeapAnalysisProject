#include "accessGraph.h"

accessGraph::accessGraph(){
	head = NULL;
	lastNode = NULL;
	iterationCount = 0;
	headRemoved = false;
//	std::vector<gNode*> nodeList;
//	nodes = nodeList;
//	std::vector<gEdge*> edgeList;
//	edges = edgeList;

	//errs() << "edges size in empty constr:" << edges.size() << "\n";
}

accessGraph::accessGraph(llvm::Instruction* p){
    std::vector<gNode*> nodeList;
	nodes = nodeList;
	std::vector<gEdge*> edgeList;
	edges = edgeList;
	headRemoved = false;

	//errs() << "edges size in inst constr:" << edges.size() << "\n";
	if(p != NULL){
		head = new gNode(p);
		nodes.push_back(head);

		lastNode = head;
		iterationCount = 0;
	}
	else{
		head = NULL;
	}
}


bool accessGraph::operator==(accessGraph g2){
//    errs() << "equal operator\n";

    if(head->inst == g2.getHead()->inst){

        if(nodes.size() == g2.getNodeList().size()){
            for(unsigned i = 0; i < nodes.size(); i++){
                if(*nodes[i] != *g2.getNodeList()[i]){
//                    errs() << "Nodes not equal in AG ==\n";
                    return false;
                }

            }

        }
        else{
            return false;
        }

        if(edges.size() == g2.getEdgeList().size()){
            for(unsigned i = 0; i < edges.size(); i++){
                if(*edges[i] != *g2.getEdgeList()[i]){
//                    errs() << "Edges not equal in AG == \n";
//
//                    errs() << "edge1 | head:" << *edges[i]->head->inst <<  " tail:" << *edges[i]->tail->inst << "\n";
//
//                    errs() << "edge1 tags | head:" << edges[i]->head->tag <<  " tail:" << edges[i]->tail->tag << "\n";
//
//                    errs() << "edge2 | head:" << *g2.getEdgeList()[i]->head->inst <<  " tail:" << *g2.getEdgeList()[i]->tail->inst << "\n";
//
//                    errs() << "edge2 tags | head:" << g2.getEdgeList()[i]->head->tag <<  " tail:" << g2.getEdgeList()[i]->tail->tag << "\n";
                    return false;
                }

            }

        }
        else{
            return false;
        }


    }


//    if(head->inst == g2->getHead()->inst){
//
//        if(nodes.size() == g2->getNodeList().size()){
//            for(unsigned i = 0; i < nodes.size(); i++){
//                if(nodes[i] != g2->getNodeList()[i]){
//                    errs() << "Nodes not equal in AG ==\n";
//                    return false;
//                }
//
//            }
//
//        }
//
//        if(edges.size() == g2->getEdgeList().size()){
//            for(unsigned i = 0; i < edges.size(); i++){
//                if(edges[i] != g2->getEdgeList()[i]){
//                    errs() << "Edges not equal in AG == \n";
//                    return false;
//                }
//
//            }
//
//        }
//
//
//    }


    return true;
}

accessGraph* accessGraph::copyGraph(){



    if(head->inst != NULL){
        accessGraph* copyAG = new accessGraph(head->inst);
//        errs() << "head tag: " << head->tag << "\n";
        copyAG->setHeadTag(head->tag);
//        errs() << "copy head tag: " << copyAG->getHead()->tag << "\n";


        for(unsigned i = 0; i < nodes.size(); i++){

            if(!copyAG->findInstNode(nodes[i]->inst)){
                gNode* newNode = new gNode(nodes[i]->inst);
                newNode->tag = nodes[i]->tag;
                copyAG->addNode(newNode);
            }


        }

        for(unsigned i = 0; i < edges.size(); i++){
            gNode* nodeA;
            nodeA = copyAG->getNode(edges[i]->head->inst);

            if(Instruction* instB = edges[i]->tail->inst){
                gNode* nodeB = copyAG->getNode(instB);
                gEdge* newEdge = new gEdge(nodeA, nodeB);
                copyAG->addEdge(newEdge);
            }
        }
        return copyAG;
    }




    return new accessGraph;



}

bool accessGraph::isEmpty(){
    return nodes.empty() && edges.empty();
}

int accessGraph::getStatementType(){
    return statementType;
}

void accessGraph::setStatementType(int newType){
    statementType = newType;
}


gNode* accessGraph::getHead(){
    //errs() << "getting head\n";
	return head;
}


gNode* accessGraph::getNode(Instruction* inst){
    for(unsigned i = 0; i < nodes.size(); i++){
        if(nodes[i]->inst == inst){
            return nodes[i];
        }
    }
    errs() << "node for inst: " << *inst << " doesn't exist\n";
    return NULL;
}

void accessGraph::setHeadTag(std::string newTag){
    head->tag = newTag;
}


void accessGraph::setHead(gNode* newHead){
	//head = newHead;
	if(nodes.empty()){
		//errs() << "B4 addNode\n";

		addNode(newHead->inst);
		head = newHead;
		//errs() << "After addNode\n";
	}
	else{
		head = newHead;
		if(not(checkForPointer(head->inst))){
			nodes.push_back(head);
		}

	}
}

std::vector<gNode*> accessGraph::getNodeList(){

	return nodes;
}

gNode* accessGraph::getLastNode(){
    //std::vector<gNode*>::iterator lNode = nodes.end();
    //lNode--;
    //errs() << **lNode->inst << "\n";
    return nodes[nodes.size()-1];//*nodes.end()-1;
}

std::vector<gEdge*> accessGraph::getEdgeList(){

	return edges;
}

void accessGraph::setRemainder(bool remainderStatus){
	remainderGraph = remainderStatus;
}

bool accessGraph::isRemainder(){
	return remainderGraph;
}





// ------------------- Union ------------------------------

accessGraph* accessGraph::getUnion(accessGraph* AG){
	accessGraph* newAG = new accessGraph(NULL);

	if(AG == NULL){
        return this;
	}

	else if((head == NULL) and (AG->getHead() == NULL)){
        //errs() << "first if\n";
		return newAG;
	}
	else if(head == NULL){
        //errs() << "2nd if\n";
		return AG;
	}
	else if(AG->getHead() == NULL){
        //errs() << "3rd if\n";
		return this;
	}
	else{
//        errs() << ">>>else stmt\n";
		if(head->inst == AG->getHead()->inst){
			//errs() << "Same Head\n ";
			std::string unionTag;
			if(head->tag != "none"){
                unionTag = head->tag;
			}
			else if(AG->getHead()->tag != "none"){
                unionTag = AG->getHead()->tag;
			}
			newAG->setHead(head);
			newAG->setHeadTag(unionTag);
			newAG->getNode(head->inst)->tag = unionTag;

//			errs() << "new tag: " << newAG->getHead()->tag << "\n";


			//Copy Edges
			//errs() << "Union head: " << *newAG->getHead()->inst << "\n";
			for(unsigned i = 0; i < edges.size(); i++){
				if(not newAG->checkForEdge(edges[i])){
					//errs() << "Adding Edge:  " << *edges[i]->head->inst << " " << *edges[i]->tail->inst << "\n";
					newAG->addEdge(edges[i]);
				}

				//newAG->
			}

			for(unsigned i = 0; i < AG->getEdgeList().size(); i++){
				if(not newAG->checkForEdge(AG->getEdgeList()[i])){
					//errs() << "Adding Edge:  " << *AG->getEdgeList()[i]->head->inst << " " << *AG->getEdgeList()[i]->tail->inst << "\n";
					newAG->addEdge(AG->getEdgeList()[i]);

				}
			}

		}
		else{
			//errs() << "Different Head\n ";
		}

	}


	return newAG;
}

// ------------------- Path Removal ------------------------------

void accessGraph::removePath(std::vector<gEdge*> path){
	//accessGraph* newAG = new accessGraph(NULL);
	errs() << "Removing Path\n";
	headRemoved = false;
	if(path.size() > 0){

//		for(unsigned i = 0; i < path.size(); i++){
////			errs() << "current Edge: " << *path[i]->head->inst << ", " << *path[i]->tail->inst << "\n";
//		}
		if(checkForPath(path)){
			deletePath(path);
			errs() << "Deleted Path\n";
			updateNodes();
		}

		errs() << "nodes size after update: " << nodes.size() << "\n";
	}
	//return newAG;
}

bool accessGraph::isHeadEdge(gEdge* e){

    return e->head->inst == head->inst && e->tail->inst == NULL;

}

void accessGraph::deletePath(std::vector<gEdge*> path){

//	if (path.size() <= (edges.size() + 1)){
//		for(unsigned i = 0; i < path.size(); i++){
//			removeEdge(path[i]);
//		}
//	}

    if(path.size() == 1 && isHeadEdge(path[0])){
//        errs() << "Head removal Detected\n";
        removeAll();
        headRemoved = true;
    }

	else if (path.size() <= (edges.size() + 1)){
		for(unsigned i = 0; i < path.size(); i++){
			removeEdge(path[i]);
		}
	}
}

void accessGraph::removeEdge(gEdge* e){

    if(isHeadEdge(e)){
        errs() << "Head removal Detected\n";
        removeAll();
        headRemoved = true;

    }
    else{
        for(std::vector<gEdge*>::iterator i = edges.begin(); i != edges.end(); i++){
            gEdge* currentEdge = *i;

            if((e->head == currentEdge->head) and (e->tail == currentEdge->tail)){
                //errs() << "Edge Erased\n";
                edges.erase(i);
            }
        }
    }

}


void accessGraph::removeAll(){


	while(edges.size() > 0){
        edges.erase(edges.begin());
	}
	while(nodes.size() > 0){
        nodes.erase(nodes.begin());
	}

    errs() << "Nodes Removed\n";
}


void accessGraph::updateNodes(){
	std::vector<gNode*> newNodeList;
	std::vector<gNode*> deleteList;
	for(unsigned i = 0; i < edges.size(); i++){
		if( not checkForNode(newNodeList, edges[i]->head)){
			newNodeList.push_back(edges[i]->head);
		}
		//else{ deleteList.push_back(edges[i]->head);}
		if( not checkForNode(newNodeList, edges[i]->tail)){
			newNodeList.push_back(edges[i]->tail);
		}
		//else{deleteList.push_back(edges[i]->tail);}
	}
	//errs() << "New Node List:\n";
//	for(unsigned i = 0; i < newNodeList.size(); i++){
		//errs() << *newNodeList[i]->inst << "\n";
//	}
    if(!headRemoved){
        newNodeList.push_back(head);
    }

	//Free memory for deleted nodes
	nodes = newNodeList;
}


// ------------------- Factorization ------------------------------
//The node list contains terminating nodes for paths that should be shared between this AG and
//the other given AG
std::vector<accessGraph*> accessGraph::getFactorization(accessGraph* AG, /*std::vector<gNode*> nodeList*/ gNode* endNode){
	std::vector<accessGraph*> remainderGraphs;


	//errs() << "End Node: ";
    //errs() << "Got Corresponding Edges\n";
	//errs() << "Corresponding Edges:\n";



	//getFactorEdges(cEdges, endNode);
	//getFactorEdges(AG->getEdgeList(), endNode);

    //errs() << "end Node inst: " << *endNode->inst << "\n";
    std::vector< std::vector<gEdge*> > remainderPaths;

    if(edges.size() > 0){
        std::vector<gEdge*> cEdges = getCEdges(AG);
        //errs() << "Corresponding Edges:\n";
        for( unsigned i = 0; i < cEdges.size(); i++){
            //errs() <<  *cEdges[i]->head->inst << " " << *cEdges[i]->tail->inst << "\n";
            //errs() << cEdges[i]->head

        }

        //errs() << "Getting Remainder Paths\n";
        //errs() << "Cedges size(): " << cEdges.size() << "\n";

        remainderPaths = getRemainderPaths(cEdges, endNode); //Remove corresponding nodes

        //errs() << "Finished Finding remainder paths\n";

        for(unsigned p = 0; p < remainderPaths.size(); p++){
            //errs() << "Creating new remainder path\n";
            gNode* newHead = remainderPaths[p][0]->tail;
            //errs() << "new Head: " << *newHead->inst << "\n";
            accessGraph* newAG = new accessGraph(newHead->inst);

            for(unsigned i = 1; i < remainderPaths[p].size(); i++){
                //errs() << "Creating new edge\n";
                newAG->addEdge(remainderPaths[p][i]);
            }
            //errs() << "Done Creating Edges\n";
            remainderGraphs.push_back(newAG);
        }
    }
    else{
        //errs() << ">>> Empty edges in Factorization\n";

    }



	//errs() << "Done finding Remainders\n";
	//errs() << " - - - - - - - - - - - - - -\n\n";
	//accessGraph* newAG = new accessGraph(NULL);

	return remainderGraphs;
}



//Get corresponding nodes

std::vector<gEdge*> accessGraph::getCEdges(accessGraph* AG){
	std::vector<gEdge*> cNodes;
	if(head->inst == AG->getHead()->inst){
		for(unsigned i = 0; i < AG->getEdgeList().size(); i++){
			if(checkForEdge(AG->getEdgeList()[i])){
				cNodes.push_back(AG->getEdgeList()[i]);
			}
		}
	}
	return cNodes;
}

std::vector<gEdge*> accessGraph::constructPath(std::vector<gEdge*> remainderList, gEdge* outgoingEdge){
	std::vector <gEdge*> newPath;
	//errs() << "Added to path: " << *outgoingEdge->head->inst << ", " << *outgoingEdge->tail->inst << "\n";
	newPath.push_back(outgoingEdge);
	gNode* currentNode = outgoingEdge->tail;
	gEdge* foundEdge;
	while(checkEdgeHeadsInList(remainderList, outgoingEdge->tail, foundEdge)){
	//if(checkEdgeHeadsInList(remainderList, outgoingEdge->tail, foundEdge)){
		if(checkEdgeInList(newPath, foundEdge)){
			errs() << "Attempted to add duplicate edge to new Path\n";
			break;
		}
		//errs() << " >>> edge connected to: " << *outgoingEdge->tail->inst << " found\n";
		//errs() << "Added to path: " << *foundEdge->head->inst << ", " << *foundEdge->tail->inst << "\n";
		//errs() << " Connected Edge: " << *foundEdge->head->inst << ", " << *foundEdge->tail->inst << "\n";
		newPath.push_back(foundEdge);
		currentNode = foundEdge->tail;
	}

	return newPath;
}

std::vector< std::vector<gEdge*> > accessGraph::getRemainderPaths(std::vector<gEdge*> removeList, gNode* endNode){
	//errs() << "Top of function\n";

	std::vector<gEdge*> remainderEdges;
	std::vector<gEdge*> outgoingEdges;
    //errs() << "remainder and outgoing Edge Lists created\n";
	std::vector< std::vector<gEdge*> > remainderPaths;

	//std::vector<gEdge*> currentEdges = edges;
	//errs() << "RemoveList size: " << removeList.size() << "\n";
    //errs() << "Edges size: " << edges.size() << "\n";
    //outputGraph();

	for(unsigned i = 0; i < edges.size(); i++){
        //errs() << "B4 checkEdgeInList\n";
		if(not checkEdgeInList(removeList, edges[i])){
            //errs() << "B4 Comparison\n";
			if (edges[i]->head->inst == endNode->inst){
				//errs() << "adding outgoing edge <<< \n";
				outgoingEdges.push_back(edges[i]);
			}
			else{
				//errs() << "adding remainder edge <<< \n";
				remainderEdges.push_back(edges[i]);
			}
            //errs() << "After Comparison\n";
		}
	}
    //errs() << "Finished getting edges\n";
	for(unsigned i = 0; i < outgoingEdges.size(); i++){
		remainderPaths.push_back(constructPath(remainderEdges, outgoingEdges[i]));
	}



	/*errs() << "Remainder Edges: \n";
	errs() << "Remainder size: " << remainderEdges.size() << "\n";
	for(unsigned i = 0; i < remainderEdges.size(); i++){
		errs() << *remainderEdges[i]->head->inst << " " << *remainderEdges[i]->tail->inst << " \n";
	}*/


	return remainderPaths;

}

bool checkEdgeHeadsInList(std::vector<gEdge*> edgeList, gNode* e, gEdge* &edgeFound){
	for(unsigned i = 0; i < edgeList.size(); i++){
		if(edgeList[i]->head->inst == e->inst){
			edgeFound = edgeList[i];
			return true;

		}
	}
	return false;
}

bool checkEdgeInList(std::vector<gEdge*> edgeList, gEdge* e){
	for(unsigned i = 0; i < edgeList.size(); i++){
		if((edgeList[i]->head->inst == e->head->inst) and (edgeList[i]->tail->inst == e->tail->inst)){

			return true;

		}
	}
	return false;
}

bool accessGraph::checkNodes(std::vector<gNode*> nodeList){
	for( unsigned i = 0; i < nodeList.size(); i++){
		if(not checkForPointer(nodeList[i]->inst)){
			return false;
		}
	}
	return true;
}


// -------------------   Extension   ------------------------------

accessGraph* accessGraph::getExtension(std::vector<gNode*> nodeList, std::vector<accessGraph*> remainders){
	accessGraph* newAG = new accessGraph(head->inst);
	//errs() << "Extension<<<<<<<<<<<<<<<<<\n";
	//errs() << "newAG B4:\n";
	//newAG->outputGraph();

	//First, Create a copy of the current graph using getUnion
	newAG = newAG->getUnion(this);
//	errs() << "newAG After Union:\n";
//	newAG->outputGraphByInst();
	//errs() << "-------\n";

	gNode* currentNode;
	for( unsigned i = 0; i < nodeList.size(); i++){
		currentNode = nodeList[i];
		//errs() << "Current Node: " << *currentNode->inst << "\n";
		//errs()
		if(newAG->findNode(currentNode) && remainders.size() > 0){
			//errs() << "Current Node after find node: " << currentNode << "\n";
			newAG->extendNode(currentNode, remainders);
		}
	}
	return newAG;
}

bool accessGraph::findNode(gNode* &n){

	for( unsigned i = 0; i < nodes.size(); i++){
		if(nodes[i]->inst == n->inst){
			//foundNode = nodes[i];
			//errs() << "Node Found\n";
			n = nodes[i];
			return true;
		}
	}
	return false;
}

void accessGraph::extendNode(gNode* currentNode, std::vector<accessGraph*> remainders){

	for(unsigned i = 0; i < remainders.size(); i++){
        accessGraph* currRem = remainders[i];

        if(currRem->getNodeList().size() == 1){
            addNode(currentNode, currRem->getNodeList()[0]);
        }
        else{
            if(currRem->getEdgeList().size() > 0){
                //Connect the currentNode to the first node in the remainder's edge list
                gNode* remStartingNode = currRem->getEdgeList()[0]->head;
                addNode(currentNode, remStartingNode);
            }
            //Add the rest of the edges from the currRem to the currentNode
            for(unsigned j = 0; j < currRem->getEdgeList().size(); j++){
				addEdge(currRem->getEdgeList()[j]);
			}

        }
	}

}


// ----------------------------------------------------------------


void accessGraph::addEdge(gEdge* e){
	//errs() << "Edge Found: " << checkForEdge(e) << "\n";
	//errs() << "True: " << true << "\n";
	if(not checkForEdge(e)){
		//edges.push_back(e);
		addNode(e->head, e->tail);
		/*errs() << " \n---- B4 update ----\n\n";
		outputGraph();
		updateNodes();
		errs() << "After update\n";
		outputGraph();
		errs() << "\n================\n";*/
	}

}
//--------------- Check Functions ----------------

bool accessGraph::checkForEdge(gEdge* e){
	//errs() << "Checking for Edge: " << *e->head->inst << " " << *e->tail->inst <<  " in edgelist <<<\n";
	for( unsigned i = 0; i < edges.size(); i++){
		//errs() <<  *edges[i]->head->inst << " " << *edges[i]->tail->inst << "\n";
		if((edges[i]->head->inst == e->head->inst) and (edges[i]->tail->inst == e->tail->inst)){
			//errs() << "Edge found\n";
			return true;
		}

	}
	return false;
}

bool accessGraph::checkForPath(std::vector<gEdge*> path){
	bool pathExists;

//	errs() << "first edge head inst: " << *path[0]->head->inst << "\n";
//	if(isHeadEdge(path[0])){
//        errs() << "Head only edge found\n";
//	}
//    errs() << "first edge tail inst: " << *path[0]->tail->inst << "\n";
	for(unsigned i = 0; i < path.size(); i++){
//        if(path[i]->head)
		if(!(isHeadEdge(path[i])) && !(checkForEdge(path[i]))){
			return false;
		}
	}
	return true;
}

//--------------- Adding Node ----------------

void accessGraph::addNode(gNode* headNode, gNode* newNode){

	if(head == NULL){
		//errs() << "Null head found\n";
		gEdge* newEdge = new gEdge();
		newEdge->head = headNode;
		newEdge->tail = newNode;
		head = headNode;
		if(not checkForPointer(newNode->inst)){
			nodes.push_back(newNode);
		}

		edges.push_back(newEdge);
	}

	else if(checkForPointer(headNode->inst)){

		gEdge* newEdge = new gEdge();
		newEdge->head = headNode;
		newEdge->tail = newNode;

		edges.push_back(newEdge);

		if(not(checkForPointer(newNode->inst))){
			nodes.push_back(newNode);
		}
	}

}

void accessGraph::addNode(gNode* node){
//	if(not checkForPointer(node->inst)){
//		nodes.push_back(node);
//		gEdge* newEdge = new gEdge();
//		newEdge->head = lastNode;
//		newEdge->tail = node;
//		lastNode = newEdge->tail;
//		edges.push_back(newEdge);
//	}
    nodes.push_back(node);
}

void accessGraph::addNode(llvm::Instruction* inst){
	//errs() << "creating new node\n";
	gNode* newNode = new gNode(inst);
	//errs() << "B4 if statement\n";
	if(head != NULL and (not( findInstNode(inst) ))){
			gEdge* newEdge = new gEdge();

			if(edges.empty()){

				newEdge->head = head;
				newEdge->tail = newNode;

			}
			else{
				gEdge* newEdge = new gEdge();
				gNode* currentNode = head;
				newEdge->head = lastNode;
				newEdge->tail = newNode;
				/*while(!currentNode->succ.empty()){
					currentNode = currentNode->succ[0];
				}
				currentNode->succ.push_back(newNode);*/
			}
			lastNode = newNode;
			edges.push_back(newEdge);
			nodes.push_back(newNode);
		//}

	}
	else{
		//errs() << "head is null\n";
		head = newNode;
		nodes.push_back(newNode);
		lastNode = head;
	}
}



bool accessGraph::findInstNode(llvm::Instruction* inst){
	//errs() << "finding inst node\n";
	for (unsigned i = 0; i < nodes.size(); i++){
		//errs() << *nodes[i]->inst << "\n";
		if(nodes[i]->inst == inst){
			//errs() << "node found <<< \n";
			return true;
		}
	}

	return false;
}

void accessGraph::outputGraph(){

	if(nodes.empty()){
		errs() << "No nodes in graph!\n";
	}
	else{
		errs() << "Access Graph Contents: \n";
		errs() << "Node List:" << "\n";
		for(unsigned i = 0; i < nodes.size(); i++){
//			errs() << *nodes[i]->inst << "\n";
			errs() << nodes[i]->tag << "\n";
		}
		errs() << "Edges size: " << edges.size() << "\n";
		for(unsigned i = 0; i < edges.size(); i++){
//			errs() << *edges[i]->head->inst << "---> " << *edges[i]->tail->inst << "\n";
			errs() << edges[i]->head->tag << "---> " << edges[i]->tail->tag << "\n";
		}

	}

	errs() << "\n============================\n\n";

}

void accessGraph::outputGraphByInst(){

	if(nodes.empty()){
		errs() << "No nodes in graph!\n";
	}
	else{
		errs() << "Access Graph Contents: \n";
		errs() << "Node List:" << "\n";
		for(unsigned i = 0; i < nodes.size(); i++){
			errs() << *nodes[i]->inst << "\n";
		}
		errs() << "Edges size: " << edges.size() << "\n";
		for(unsigned i = 0; i < edges.size(); i++){
			errs() << *edges[i]->head->inst << "---> " << *edges[i]->tail->inst << "\n";
		}

	}

	errs() << "\n============================\n\n";

}

bool accessGraph::checkForPointer(Instruction* ptr){
	for(unsigned i = 0; i < nodes.size(); i++){
		if(ptr == nodes[i]->inst){
			return true;

		}
	}
	return false;
}

bool checkForNode(std::vector<gNode*> nodes, gNode* node){
	for(unsigned i = 0; i < nodes.size(); i++){
		if(node->inst == nodes[i]->inst){
			return true;
		}
	}
	return false;
}

void accessGraph::makeGraph(){
	//errs() << "\n ------------------------ \n ";
	//errs() << "\nHead: " << *head->inst << "\n";
	iterationCount = 0;
	for(Value::user_iterator firstUser = head->inst->user_begin(); firstUser != head->inst->user_end(); firstUser++){
		//auto *currentUser = &firstUser;

		llvm::Instruction* userInst = dyn_cast<llvm::Instruction>(*firstUser);
		//errs() << "User: " << *userInst << "\n";

		if ( ( isa<PointerType>(userInst->getType()) )
			or (isa<StoreInst>(userInst))
			or (isa<LoadInst>(userInst)) ){
			if(!checkForPointer(userInst)){
                    if(isa<StoreInst>(userInst)){
                        trackStorage(userInst);
                    }

                    createNode(head, userInst);
			}

		}


	}
	iterationCount = 0;

}

void accessGraph::trackStorage(Instruction* inst){

    //Instruction* prevInst = inst->user_back();
    errs() << "Current Inst: " << *inst << "\n";
    //if(inst->getNumUses() > 0){
    //    llvm::Instruction* userInst = dyn_cast<llvm::Instruction>(*inst->user_begin());
    //    errs() << "Prev Inst: " << *userInst << "\n";
    //}
    if(isa<llvm::LoadInst>(inst->getOperand(0))){
        errs() << "Memory Assignment\n";
    }
    /*for(unsigned j = 0; j < inst->getNumOperands(); j ++){
        llvm::Instruction* valInst = dyn_cast<llvm::Instruction>(inst->getOperand(j));
        if()
    }*/
    //errs() << "Num Uses: " << inst->getNumUses() << "\n";

}

void accessGraph::createNode(gNode* parentInst, llvm::Instruction* childInst){
	if(iterationCount < 10){

		//First, create the new edge for the childPointer
		gNode* newNode = new gNode(childInst);
		gEdge* newEdge = new gEdge();
		newEdge->head = parentInst;
		newEdge->tail = newNode;
		edges.push_back(newEdge);
		nodes.push_back(newNode);

		std::vector<Instruction*> childPtrs;
		//errs() << "\nChild: " << *childInst << "\n";
		for(Value::user_iterator firstUser = childInst->user_begin(); firstUser != childInst->user_end(); firstUser++){

			llvm::Instruction* userInst = dyn_cast<llvm::Instruction>(*firstUser);
			//errs() << "User: " << *userInst << "\n";

			if ( ( isa<PointerType>(userInst->getType()) )
				or (isa<StoreInst>(userInst))
				or (isa<LoadInst>(userInst)) ){
				childPtrs.push_back(userInst);

				//iterateAgain = true;
			}

		}
		if(childPtrs.size() > 0){
			for(unsigned i = 0; i < childPtrs.size(); i++){
				if(!checkForPointer(childPtrs[i])){
					createNode(newNode, childPtrs[i]);
				}

			}
		}

	iterationCount++;
	}
	//bool iterateAgain = false;

}
/*
//bool checkNodes(

*/
void createAccessGraphs(Function &F, std::vector<Instruction*> ptrList, std::vector<accessGraph*> &AGList){

		Function::BasicBlockListType& bbList = F.getBasicBlockList();
		/*
		for (unsigned i = 0; i < ptrList.size(); i++){
			Instruction* currentPtr = ptrList[i];
			errs() << "Current Ptr: " << *currentPtr << "\n";
			//Iterate pointer's users
			for(Value::user_iterator firstUser = currentPtr->user_begin(); firstUser != currentPtr->user_end(); firstUser++){
				//auto *currentUser = &firstUser;

				llvm::Instruction* userInst = dyn_cast<llvm::Instruction>(*firstUser);
				errs() << "User: " << *userInst << "\n";


			}

		}*/

		//-------------------------------------

		for(Function::BasicBlockListType::iterator firstBB = bbList.begin(), lastBB = bbList.end(); firstBB != lastBB; firstBB++){

			BasicBlock* bb = &*firstBB;
			for (BasicBlock::iterator i = bb->begin(); i != bb->end(); i++){

				Instruction* inst = &*i;
				//bool pType = isa<PointerType>(inst->getType());

				//errs() << "Current inst: " << *inst << "\n";

                if(isa<AllocaInst>(inst) and isa<PointerType>(inst->getType())){

                    accessGraph *newAG = new accessGraph(inst);
                    AGList.push_back(newAG);
                }
				/*if ( ( isa<PointerType>(inst->getType()) and (not checkForAG(AGList, inst))
                    and (isa<AllocaInst>(inst)) )
					){

					/*if(isa<GetElementPtrInst>(inst)){
						accessGraph* parentAG = AGList[findAG(AGList, inst)];
						//errs() << "found parent AG\n";
						parentAG->addNode(inst);
					}
					else if (isa<PHINode>(inst)){
						//errs() << "Found phi node\n";
					 	handlePHINode(AGList, inst);

					}
					//else{
						accessGraph *newAG = new accessGraph(inst);
						newAG->makeGraph();
						AGList.push_back(newAG);
					//}

				}*/

				//errs() << "Type: " << *inst->getType() << "\n";
				//errs() << *inst << "\n";
				//errs() << "Pointertype" << pType << "\n";

			}
		}

}

void handlePHINode(std::vector<accessGraph*> AGList, Instruction* inst){
	llvm::PHINode* valInst = dyn_cast<llvm::PHINode>(inst);



	for(llvm::PHINode::block_iterator i = valInst->block_begin();  i != valInst->block_end();i ++){
		auto *currentOp = &*i;


		//errs() << "phi operand: " << **currentOp << "\n";
	}
	for(unsigned i = 0;  i < valInst->getNumIncomingValues();i ++){


		//errs() << "handling phi operand\n";
		auto *currentOp = valInst->getIncomingValue(i);

		//Get list of users of the phi value


		//for(succ_iterator fSucc = succ_begin(currentBB->thisBlock), lSucc = succ_end(currentBB->thisBlock); fSucc != lSucc; fSucc++){		}

		//auto *testOp = valInst(i);
		//errs() << "phi test op :" << *testOP << "\n";
		//errs() << " incoming phi operand: " << *currentOp << "\n";
		//llvm::Instruction* valInst = dyn_cast<llvm::Instruction>(currentOp);
	}
}

unsigned findAG(std::vector<accessGraph*> AGList, Instruction* inst){

		for(unsigned j = 0; j < inst->getNumOperands(); j ++){
			auto *currentOp = inst->getOperand(j);
			llvm::Instruction* valInst = dyn_cast<llvm::Instruction>(currentOp);

			//errs() << "getElementPtr op: " << *valInst << "\n";
			//errs() << "AGList size: " << AGList.size() << "\n";
			for( unsigned i = 0; i < AGList.size(); i++){
				if(AGList[i]->findInstNode(valInst)){
					return i;
				}
			}
		}
		errs() << "-------------- ERROR --------------- \n";
		return AGList.size() + 1;
    }

bool checkForAG(std::vector<accessGraph*> AGList, Instruction* inst){
	for( unsigned i = 0; i < AGList.size(); i++){
		if(AGList[i]->findInstNode(inst)){
			//errs() << "already found: " << *inst << "\n";
			return true;
		}
	}
	return false;
}

