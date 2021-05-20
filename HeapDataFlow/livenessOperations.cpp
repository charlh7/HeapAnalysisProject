#include "livenessOperations.h"

std::string findRootTag(std::vector<Instruction*> rootList, Instruction* inst){

    std::string rootStr = "root";
    for(unsigned i = 0; i < rootList.size(); i++ ){


        if(rootList[i] == inst){
            char rootLetter = 65 + i;
            rootStr += rootLetter;
        }


//        errs() << "root Str: " << rootStr << "\n";
    }
    return rootStr;


}

std::vector<accessGraph*> getELGen( std::vector<accessGraph*> AGList, std::vector<Instruction*> rootList, InstAGInfo *instInfo, Instruction* inst){

	//ELGen is just the union of LDirect and LTransfer

    BitVector instTypes = instInfo->instType;
    std::vector<Instruction*> statementInsts = instInfo->statementInsts;
    std::vector<accessGraph*> usedAGs = instInfo->usedAGs;
    std::vector<accessGraph*> unusedAGs = instInfo->unusedAGs;

    //errs() << "unusedAG size: " << unusedAGs.size() << "\n";
    //errs() << "usedAG size: " << usedAGs.size() << "\n";
    for(unsigned i = 0; i < unusedAGs.size(); i++){
        //errs() << "unusedAG: " << *unusedAGs[i]->getHead()->inst << "\n";
    }


    //errs() << "Current Inst: " << *inst << "\n";
    //errs() << "Getting LDirect\n";
//    std::vector<accessGraph*> LDirectList = getLDirect(AGList, rootList, instInfo, inst);
//    instInfo->LDirect = LDirectList;
//	//errs() << "Getting LTransfer\n";
//	std::vector<accessGraph*> LTransferList = getLTransfer(AGList, rootList, instInfo, inst);
//    instInfo->LTransfer = LTransferList;
	//errs() << "Finished Finding LDirect and LTransfer\n";
	std::vector<accessGraph*> ELGenList;
	//errs() << " >>> Finding ELGen <<< \n";

	//For now, only generate for assignment statements
	//Assignment only applies when there is a pointer on each side of the equal sign

	if(instInfo->updating){
        if(instInfo->ELOut.size() == 0 || instInfo->instType[0] != 1){
            //errs() << "ELOut Empty\n";
            return instInfo->ELGen;
        }
//        else if(instInfo->instType[0] != 1){
//
//        }
        else{
//            errs() << "ELOut nonzero\n";
            std::vector<accessGraph*> LDirectList = instInfo->LDirect;

            std::vector<accessGraph*> LTransferList = getLTransfer(AGList, rootList, instInfo, inst);
            instInfo->LTransfer = LTransferList;

            if(instTypes[0] == 1){

            //errs() << "LDirect Size: " << LDirectList.size() << "\n";
            //errs() << "LTransfer Size: " << LTransferList.size() << "\n";

                for(unsigned i = 0; i < LDirectList.size(); i ++ ){
                    //errs() << "LDirect Statement Type: " << LDirectList[i]->getStatementType() << "\n";
                    //errs() << "LTransfer Statement Type: " << LTransferList[0]->getStatementType() << "\n";

                    if(LDirectList[i]->getStatementType() == LTransferList[0]->getStatementType()){
                        accessGraph* unionedAG = LDirectList[i]->getUnion(LTransferList[0]);
                        //errs() << "Unioned AG: \n";
                        //unionedAG->outputGraph();
                        ELGenList.push_back(unionedAG);
                    }
                    else{
                        ELGenList.push_back(LDirectList[i]);
                    }
                }
            }



            return ELGenList;

        }
	}
    else{

        std::vector<accessGraph*> LDirectList = getLDirect(AGList, rootList, instInfo, inst);
        instInfo->LDirect = LDirectList;


        if(instTypes[0] == 1){
            std::vector<accessGraph*> LTransferList = getLTransfer(AGList, rootList, instInfo, inst);
            instInfo->LTransfer = LTransferList;
            //errs() << "LDirect Size: " << LDirectList.size() << "\n";
            //errs() << "LTransfer Size: " << LTransferList.size() << "\n";

            for(unsigned i = 0; i < LDirectList.size(); i ++ ){
                //errs() << "LDirect Statement Type: " << LDirectList[i]->getStatementType() << "\n";
                //errs() << "LTransfer Statement Type: " << LTransferList[0]->getStatementType() << "\n";

                if(LDirectList[i]->getStatementType() == LTransferList[0]->getStatementType()){
                    accessGraph* unionedAG = LDirectList[i]->getUnion(LTransferList[0]);
                    //errs() << "Unioned AG: \n";
                    //unionedAG->outputGraph();
                    ELGenList.push_back(unionedAG);
                }
                else{
                    ELGenList.push_back(LDirectList[i]);
                }
            }
        }

        //else if(instTypes[2] == )

        else {
            for(unsigned i = 0; i < LDirectList.size() ; i++){
                ELGenList.push_back(LDirectList[i]);
            }

        }


    }

	//errs() << "ELGen Size: " << ELGenList.size() << "\n";

	//errs() << "Finished ELGen\n";*/
	return ELGenList;
}

//------------------- LDirect --------------------------

std::vector<accessGraph*> getLDirect(std::vector<accessGraph*> AGList, std::vector<Instruction*> rootList, InstAGInfo *instInfo, Instruction* inst){
	//LDirect result depends on the instruction type
	//errs() << " >>> Finding LDirect <<< \n";
	//errs() << "Current Inst: " << *inst << "\n";
	std::vector<accessGraph*> LDirectList;
	BitVector instTypes = instInfo->instType;
	//errs() << "insttype: " << instTypes[0] << "\n";

	//Assignment Statement( xStatement = yStatement )

	if(!(instInfo->updating)){
        if(instTypes[0] == 1){
            //errs() << "LDirect Assignment Type\n";
            //errs() << "Inst in LDirect" << *inst << "\n";
            LDirectList = getLDirectAssignment(AGList, rootList, instInfo, inst);
        }
        else if( instTypes[1] == 1){
            //errs() << "LDirect Function Type \n";
            //errs() << "Current Inst in LDirect" << *inst << "\n";
            LDirectList = getLDirectFunctionCall(AGList, rootList, instInfo, inst);
        }
        else if( instTypes[2] == 1){
            //errs() << "LDirect Function Type \n";
            //errs() << "Current Inst in LDirect" << *inst << "\n";
            LDirectList = getLDirectReturn(AGList, rootList, instInfo, inst);
        }
        else if( instTypes[3] == 1){
            //errs() << "LDirect Usage Type \n";
            //errs() << "Inst in LDirect" << *inst << "\n";
            LDirectList = getLDirectUse(AGList, rootList, instInfo, inst);
        }

	}

	//remove nodes with null head
	std::vector<accessGraph*> trimmedLDirect;

	for(unsigned i = 0; i < LDirectList.size(); i++){
        if(LDirectList[i]->getHead() != NULL){
            trimmedLDirect.push_back(LDirectList[i]);
        }
	}




	return trimmedLDirect;
}

std::vector<accessGraph*> getLDirectAssignment(std::vector<accessGraph*> AGList, std::vector<Instruction*> rootList, InstAGInfo *instInfo, Instruction* inst){
	std::vector<accessGraph*> LDirectList;

	BitVector instTypes = instInfo->instType;
    std::vector<Instruction*> statementInsts = instInfo->statementInsts;
    std::vector<accessGraph*> usedAGs = instInfo->usedAGs;
    std::vector<accessGraph*> unusedAGs = instInfo->unusedAGs;

	//std::vector< std::vector<Instruction*> > rootInstLists;
	//errs() << "--- Assignment Statement Type ---\n";
	//errs() << "Statement Insts B4:\n";
	//outputList(statementInsts);

	for(unsigned i = 0; i < usedAGs.size(); i++){
        //errs() << "root: " << *usedAGs[i]->getHead()->inst << "\n";

        //Extract insts relating to each element (in x = y)
        std::vector<Instruction*> rootInsts = extractAssignmentStatementInsts(usedAGs[i]->getHead()->inst, statementInsts);
        //errs() << "Statement Insts After:\n";
        //outputList(statementInsts);
        //rootInstLists.push_back( rootInsts );

        //Determine how many nodes are branching out of the head
        std::vector<Instruction*> nodeInsts;
        int numNodes = getNumMemNodes(rootInsts, nodeInsts, usedAGs[i]->getHead()->inst);

        //errs() << "Nodes branched out: " << numNodes << "\n";

        //If the only node is the head node
        if(numNodes == 0){
            accessGraph* emptyGraph = new accessGraph();
            emptyGraph->setStatementType(usedAGs[i]->getStatementType());
            LDirectList.push_back(emptyGraph);
        }
        else if(numNodes == 1){
            accessGraph* headGraph = new accessGraph(usedAGs[i]->getHead()->inst);
            headGraph->setHeadTag(findRootTag(instInfo->rootList, usedAGs[i]->getHead()->inst));

            headGraph->setStatementType(usedAGs[i]->getStatementType());
            LDirectList.push_back(headGraph);
        }
        else{
            //Subtract one from the node number to get path to the base instead of the full path
            accessGraph* newAG = addPathToAccessGraph(instInfo, nodeInsts, usedAGs[i]->getHead()->inst, numNodes-1);
            newAG->setHeadTag(findRootTag(instInfo->rootList, usedAGs[i]->getHead()->inst));
            newAG->setStatementType(usedAGs[i]->getStatementType());
            LDirectList.push_back(newAG);

        }

        //Need to make graph from base

	}

    /*errs() << "LDirect after Assignment\n";
	for(unsigned i = 0; i < LDirectList.size(); i++){
        LDirectList[i]->outputGraph();
    }*/

	return LDirectList;
}

std::vector<Instruction*> extractAssignmentStatementInsts(Instruction* rootInst, std::vector<Instruction*> &statementInsts){
    std::vector<Instruction*> rootStatementInsts;
    Instruction* endInst = statementInsts[statementInsts.size() - 1];


    Instruction* currentInst = rootInst;
    bool userFound = true;

    while(userFound){
        userFound = false;
        for(unsigned i = 0; i < statementInsts.size(); i++){
            //errs() << "currentInst: " << *statementInsts[i] << "\n";
            if(isAUser(currentInst, statementInsts[i])){
                userFound = true;
                currentInst = statementInsts[i];
                //errs() << "B4 erase\n";
                statementInsts.erase(statementInsts.begin() + i);
                //errs() << "After erase\n";
                rootStatementInsts.push_back(currentInst);
                break;
            }
        }
        //errs() << "------- \n";
        if(currentInst == endInst){
            break;
        }

    }
    //errs() << "Current Root Inst: " << *rootInst << "\n";
    //outputList(rootStatementInsts);
    //errs() << "\n\n";
    return rootStatementInsts;

}

std::vector<Instruction*> extractFCallStatementInsts(Instruction* rootInst, std::vector<Instruction*> &statementInsts){
    std::vector<Instruction*> rootStatementInsts;
    Instruction* endInst = statementInsts[statementInsts.size() - 1];


    Instruction* currentInst = rootInst;
    bool userFound = true;

    while(userFound){
        userFound = false;
        for(unsigned i = 0; i < statementInsts.size(); i++){
            //errs() << "currentInst: " << *statementInsts[i] << "\n";
            if(isAUser(currentInst, statementInsts[i])){
                userFound = true;
                currentInst = statementInsts[i];
                //errs() << "B4 erase\n";
                statementInsts.erase(statementInsts.begin() + i);
                //errs() << "After erase\n";
                rootStatementInsts.push_back(currentInst);
                break;
            }
        }
        //errs() << "------- \n";
        if(currentInst == endInst){
            break;
        }

    }
    //errs() << "Current Root Inst: " << *rootInst << "\n";
    //outputList(rootStatementInsts);
    //errs() << "\n\n";
    return rootStatementInsts;

}

// -------

std::vector<accessGraph*> getLDirectFunctionCall(std::vector<accessGraph*> AGList, std::vector<Instruction*> rootList, InstAGInfo *instInfo, Instruction* inst){
    std::vector<accessGraph*> LDirectList;

    BitVector instTypes = instInfo->instType;
    std::vector<Instruction*> statementInsts = instInfo->statementInsts;
    std::vector<accessGraph*> usedAGs = instInfo->usedAGs;
    std::vector<accessGraph*> unusedAGs = instInfo->unusedAGs;

    //std::vector<accessGraph*> LTransferList;
	std::vector<Instruction*> yStatementInsts;
	accessGraph* yAG;

	std::vector<Instruction*> xStatementInsts;
	accessGraph* xAG;



    for(unsigned i = 0; i < usedAGs.size(); i++){
        //errs() << "root: " << *usedAGs[i]->getHead()->inst << "\n";
        //errs() << "AG Type : " << usedAGs[i]->getStatementType() << "\n";

        //Type 1 corresponds to x for fCalls
        if(usedAGs[i]->getStatementType() == 0){
            std::vector<Instruction*> rootInsts = extractFCallStatementInsts(usedAGs[i]->getHead()->inst, statementInsts);
            yStatementInsts = rootInsts;

            statementInsts.push_back(inst);

            std::vector<Instruction*> nodeInsts;
            unsigned numNodes = getNumMemNodes(rootInsts, nodeInsts, usedAGs[i]->getHead()->inst);

            //errs() << "Statement Insts After Getting y:\n";
            //outputList(statementInsts);

            //errs() << "num Nodes: " << numNodes << "\n";

            //y = mGraph(base(py)) u mGraph(py->*) [basically the entirety of py]
            //for now, y = mGraph(py)
            if(numNodes == 0){
                accessGraph* emptyGraph = new accessGraph();
                emptyGraph->setStatementType(usedAGs[i]->getStatementType());
                yAG = emptyGraph;
            }
            else if(numNodes == 1){
                accessGraph* headGraph = new accessGraph(usedAGs[i]->getHead()->inst);
                headGraph->setStatementType(usedAGs[i]->getStatementType());
                //errs() << "headGraph: \n";
                headGraph->outputGraph();
                yAG = headGraph;

            }
            else{
                //Subtract one from the node number to get path to the base instead of the full path
                accessGraph* newAG = addPathToAccessGraph(instInfo, nodeInsts, usedAGs[i]->getHead()->inst, numNodes-1);
                newAG->setStatementType(usedAGs[i]->getStatementType());

                //errs() << "numNodes >= 2: \n";
                //newAG->outputGraph();

                yAG = newAG;
            }
            LDirectList.push_back(yAG);
        }




        else if(usedAGs[i]->getStatementType() == 1){
            //errs() << "statementInsts size: " << statementInsts.size() << "\n";
            //outputList(statementInsts);
            std::vector<Instruction*> rootInsts = extractFCallStatementInsts(usedAGs[i]->getHead()->inst, statementInsts);
            xStatementInsts = rootInsts;
            //errs() << "statementInsts size After: " << statementInsts.size() << "\n";
            //outputList(statementInsts);

            //errs() << "rootsInsts size: " << rootInsts.size() << "\n";
            //outputList(rootInsts);

            std::vector<Instruction*> nodeInsts;
            int numNodes = getNumMemNodes(rootInsts, nodeInsts, usedAGs[i]->getHead()->inst);

            //errs() << "num Nodes: " << numNodes << "\n";

            if(numNodes == 0){
                accessGraph* emptyGraph = new accessGraph();
                emptyGraph->setStatementType(usedAGs[i]->getStatementType());
                xAG = emptyGraph;
                //LDirectList.push_back(emptyGraph);
            }
            else if(numNodes == 1){
                accessGraph* headGraph = new accessGraph(usedAGs[i]->getHead()->inst);
                headGraph->setStatementType(usedAGs[i]->getStatementType());
                //errs() << "headGraph: \n";
                headGraph->outputGraph();
                xAG = headGraph;

            }
            else{
                //Subtract one from the node number to get path to the base instead of the full path
                accessGraph* newAG = addPathToAccessGraph(instInfo, nodeInsts, usedAGs[i]->getHead()->inst, numNodes-1);
                newAG->setStatementType(usedAGs[i]->getStatementType());

                //errs() << "numNodes >= 2: \n";
                //newAG->outputGraph();

                xAG = newAG;
                //LDirectList.push_back(newAG);

            }
            LDirectList.push_back(xAG);

        }




        //Need to make graph from base
    }


    unsigned AGIndex = 0;
    errs() << "adding extra path nodes\n";
    if(AGInList(AGList, yAG, AGIndex)){

        accessGraph* correspondingAG = AGList[AGIndex];
        std::vector<gEdge*> newEdges;
        getPathsFromInst(correspondingAG, newEdges, inst);
        //errs() << "New Edges:\n";
        for(unsigned i = 0; i < newEdges.size(); i++){
           // errs() << newEdges[i]->head->inst << ", " <<  newEdges[i]->tail->inst << "\n";
        }
        for(unsigned i = 0; i < newEdges.size(); i++){
            if(!(checkEdgeInList(yAG->getEdgeList(), newEdges[i]))){
                yAG->addNode(newEdges[i]->head, newEdges[i]->tail);
            }
        }

    }

    errs() << "done adding extra path nodes\n";
    //Need to handle LDirectz

    //Assuming all variables are global
    /*for(unsigned i = 0; i < unusedAGs.size(); i++){
        //unusedAGs[i]->setStatementType()
        LDirectList.push_back(unusedAGs[i]);
    }*/


    return LDirectList;

}

void getPathsFromInst(accessGraph* AG, std::vector<gEdge*> &newEdgeList,  Instruction* inst){

    //Create an AG with all paths starting at given inst
    //accessGraph* newAG = new accessGraph*(AG->getHead()->inst);

    std::vector<gEdge*> edges = AG->getEdgeList();
    Instruction* currentInst = inst;

    //std::vector<gEdge*> newEdgeList;



    for(unsigned i = 0; i < edges.size(); i++){
        if(edges[i]->head->inst == inst){
            if(!(checkEdgeInList(newEdgeList, edges[i]))){
                newEdgeList.push_back(edges[i]);
                getPathsFromInst(AG, newEdgeList, edges[i]->tail->inst);
            }

        }

    }





}

// -------

std::vector<accessGraph*> getLDirectReturn(std::vector<accessGraph*> AGList, std::vector<Instruction*> rootList, InstAGInfo *instInfo, Instruction* inst){
    std::vector<accessGraph*> LDirectList;

    BitVector instTypes = instInfo->instType;
    std::vector<Instruction*> statementInsts = instInfo->statementInsts;
    std::vector<accessGraph*> usedAGs = instInfo->usedAGs;
    std::vector<accessGraph*> unusedAGs = instInfo->unusedAGs;

    std::vector<Instruction*> xStatementInsts;
	accessGraph* xAG;
	for(unsigned i = 0; i < usedAGs.size(); i++){

        if(usedAGs[i]->getStatementType() == 0){
            std::vector<Instruction*> rootInsts = extractFCallStatementInsts(usedAGs[i]->getHead()->inst, statementInsts);
            xStatementInsts = rootInsts;

            statementInsts.push_back(inst);

            std::vector<Instruction*> nodeInsts;
            unsigned numNodes = getNumMemNodes(rootInsts, nodeInsts, usedAGs[i]->getHead()->inst);

            //errs() << "Statement Insts After Getting y:\n";
            //outputList(statementInsts);

            //errs() << "num Nodes: " << numNodes << "\n";

            //y = mGraph(base(py)) u mGraph(py->*) [basically the entirety of py]
            //for now, y = mGraph(py)
            if(numNodes == 0){
                accessGraph* emptyGraph = new accessGraph();
                emptyGraph->setStatementType(usedAGs[i]->getStatementType());
                //errs() << "headGraph: \n";
                emptyGraph->outputGraph();
                xAG = emptyGraph;

            }
            if(numNodes == 1){
                accessGraph* headGraph = new accessGraph(usedAGs[i]->getHead()->inst);
                headGraph->setStatementType(usedAGs[i]->getStatementType());
                //errs() << "headGraph: \n";
                headGraph->outputGraph();
                xAG = headGraph;

            }
            else{
                //Subtract one from the node number to get path to the base instead of the full path
                accessGraph* newAG = addPathToAccessGraph(instInfo, nodeInsts, usedAGs[i]->getHead()->inst, numNodes-1);
                newAG->setStatementType(usedAGs[i]->getStatementType());

                //errs() << "numNodes >= 2: \n";
                newAG->outputGraph();

                xAG = newAG;
            }
            LDirectList.push_back(xAG);
        }

	}

	unsigned AGIndex = 0;
	if(AGInList(AGList, xAG, AGIndex)){

            accessGraph* correspondingAG = AGList[AGIndex];
            std::vector<gEdge*> newEdges;
            getPathsFromInst(correspondingAG, newEdges, inst);
            //errs() << "New Edges:\n";
            for(unsigned i = 0; i < newEdges.size(); i++){
                //errs() << newEdges[i]->head->inst << ", " <<  newEdges[i]->tail->inst << "\n";
            }
            for(unsigned i = 0; i < newEdges.size(); i++){
                if(!(checkEdgeInList(xAG->getEdgeList(), newEdges[i]))){
                    xAG->addNode(newEdges[i]->head, newEdges[i]->tail);
                }
            }

        }



    return LDirectList;

}

// -------

std::vector<accessGraph*> getLDirectUse(std::vector<accessGraph*> AGList, std::vector<Instruction*> rootList, InstAGInfo *instInfo, Instruction* inst){
    std::vector<accessGraph*> LDirectList;

    BitVector instTypes = instInfo->instType;
    std::vector<Instruction*> statementInsts = instInfo->statementInsts;
    std::vector<accessGraph*> usedAGs = instInfo->usedAGs;
    std::vector<accessGraph*> unusedAGs = instInfo->unusedAGs;

    //std::vector< std::vector<Instruction*> > rootInstLists;
    //errs() << "Used AGs: \n";
    for(unsigned i = 0; i < usedAGs.size(); i++){
        //errs() << "root Insts" << "\n";
        std::vector<Instruction*> rootInsts = extractStatementInsts(usedAGs[i]->getHead()->inst, statementInsts);
        //rootInstLists.push_back( rootInsts );

        //errs() << "numNodes\n";
        std::vector<Instruction*> nodeInsts;
        int numNodes = getNumMemNodes(rootInsts, nodeInsts, usedAGs[i]->getHead()->inst);


        //errs() << "addGraph\n";
        if(numNodes > 0){
            //errs() << "about to create new AG\n";
            accessGraph* newAG = addPathToAccessGraph(instInfo, nodeInsts, usedAGs[i]->getHead()->inst, numNodes);
            //errs() << "created new AG\n";
            LDirectList.push_back(newAG);
        }
        else{
            LDirectList.push_back(usedAGs[i]);
        }

        //break;
    }

    //errs() << "Statement Insts:\n";

    //errs() << "LDirectAG's: \n";


    //errs() << "rootInstLists size: " << rootInstLists.size() << "\n";
    //outputList(statementInsts);
    /*for(unsigned i = 0; i < LDirectList.size(); i++){
        LDirectList[i]->outputGraph();
        errs() << "\n";
        //outputList(rootInstLists[i]);
    }*/


    return LDirectList;

}

accessGraph* addPathToAccessGraph(InstAGInfo *instInfo, std::vector<Instruction*> nodeInsts, Instruction* root, unsigned numNodes){

    //First, find correct AG
    accessGraph* rootAG = new accessGraph(root);
    rootAG->setHeadTag(findRootTag(instInfo->rootList, root));
    //errs() << "Made initial graph\n";
//    Instruction* currentInst = root;
    gNode* currentNode = rootAG->getHead();
    for(unsigned i = 0; i < numNodes; i++){
        std::string tagStr = createTag(instInfo, i);

//        gNode* nodeA = new gNode(currentInst);
        gNode* nodeB = new gNode(nodeInsts[i]);
        nodeB->tag = tagStr;

        rootAG->addNode(currentNode, nodeB);
//        currentInst = nodeInsts[i];
        currentNode = rootAG->getNode(nodeInsts[i]);
    }

    return rootAG;
}

std::string createTag(InstAGInfo *instInfo, unsigned nodeNum){


    char charTag = 97 + nodeNum;
    std::string tagStr = charTag + std::to_string(instInfo->instNumber);
    //errs() << "tagStr: " << tagStr << "\n";

    return tagStr;
}

unsigned getNumMemNodes(std::vector<Instruction*> statementInsts, std::vector<Instruction*> &nodeInsts, Instruction* rootInst){
    //errs() << "Root Inst Type: " << *rootInst->getType() << "\n";
    int numMemNodes = 0;
    for(unsigned i = 0; i < statementInsts.size(); i++){
        if(rootInst->getType() == statementInsts[i]->getType()){
            //errs() <<
            //errs() << "Same Type Found : " <<  *statementInsts[i] << "\n";
            nodeInsts.push_back(statementInsts[i]);
            numMemNodes++;
        }
    }

    //errs() << "\n\n";
    return numMemNodes;
}

std::vector<Instruction*> extractStatementInsts(Instruction* rootInst, std::vector<Instruction*> statementInsts){

    std::vector<Instruction*> rootStatementInsts;
    //errs() << "statementInsts size: " << statementInsts.size() << "\n";
    Instruction* endInst = statementInsts[statementInsts.size() - 1];
    Instruction* currentInst = rootInst;
    bool userFound = true;
    //errs() << "Extract stmt insts\n";
    while(userFound){
        userFound = false;
        for(unsigned i = 0; i < statementInsts.size(); i++){
            //errs() << "currentInst: " << *statementInsts[i] << "\n";
            if(isAUser(currentInst, statementInsts[i])){
                userFound = true;
                currentInst = statementInsts[i];
                rootStatementInsts.push_back(currentInst);
            }
        }

        if(currentInst == endInst){
            break;
        }

    }

    //errs() << "Current Root Inst: " << *rootInst << "\n";
    //outputList(rootStatementInsts);

    return rootStatementInsts;

}

bool isAUser(Instruction* inst, Instruction* user){

     for(unsigned opNum = 0; opNum < user->getNumOperands(); opNum++){
        if(llvm::Instruction* opInst = dyn_cast<llvm::Instruction>(user->getOperand(opNum))){
            //errs() << "opInst: " << *opInst << "\n";
            if(opInst == inst){
                return true;
            }
        }
    }
    return false;
}

//Find the previous node in the path
bool findPreviousNode(accessGraph* AG, Instruction* inst, gNode* &prevNode){
    bool nodeFound = false;
	//gNode* previousNode;
	//errs() << "\n\n--------- Finding Prev Node ---------------\n";
	//errs() << "Prev Node: " << *inst << "\n";
	//errs() << "Finding prev node in: \n";
	//AG->outputGraph();
	for(unsigned i = 0; i < AG->getEdgeList().size(); i++){

		if(AG->getEdgeList()[i]->tail->inst == inst){
            nodeFound = true;
			prevNode = AG->getEdgeList()[i]->head;
			//errs() << "previousNode: " << *prevNode->inst << "\n";
			break;
			//return previousNode;
		}
	}
	//return previousNode;
	//errs() << " --------- Done Finding Prev Node ------------ \n";
	return nodeFound;
}


bool AGInList(std::vector<accessGraph*> AGList, accessGraph* AG, unsigned &index){
	for(unsigned i = 0; i < AGList.size(); i++){
		if(AGList[i] == AG){
			index = i;
			return true;
		}
//		if(AGList[i]->getHead()->inst != NULL && AG->getHead()->inst != NULL){
//            if(AGList[i]->getHead()->inst == AG->getHead()->inst){
//                index = i;
//                return true;
//            }
//		}
//		else{
//            return false;
//		}



	}
	return false;
}

bool AGInList(std::vector<accessGraph*> AGList, accessGraph* AG){
    for(unsigned i = 0; i < AGList.size(); i++){
		if(AGList[i]->getHead()->inst != NULL && AG->getHead()->inst != NULL){
            if(AGList[i]->getHead()->inst == AG->getHead()->inst){
                return true;
            }
		}
		else{
            return false;
		}

    }
    return false;

}

//------------------- LTransfer --------------------------

std::vector<accessGraph*> getLTransfer(std::vector<accessGraph*> AGList, std::vector<Instruction*> rootList, InstAGInfo *instInfo, Instruction* inst){
	//LTransfer result depends on the instruction type
	//errs() << " \n\n>>> Finding LTransfer <<< \n";
//	errs() << "Current Inst: " << *inst << "\n";
	return getLTransferAssignment(AGList, rootList, instInfo, inst);
}


std::vector<accessGraph*> getLTransferAssignment( std::vector<accessGraph*> AGList, std::vector<Instruction*> rootList, InstAGInfo *instInfo, Instruction* inst){

	std::vector<accessGraph*> LTransferList;

	std::vector<Instruction*> statementInsts = instInfo->statementInsts;
    std::vector<accessGraph*> usedAGs = instInfo->usedAGs;
    std::vector<accessGraph*> unusedAGs = instInfo->unusedAGs;


	std::vector<Instruction*> yStatementInsts;
	accessGraph* yAG;

	std::vector<Instruction*> xStatementInsts;
	accessGraph* xAG;

//	errs() << "LTransfer Called\n";

	//errs() << "------- Used AGs -------\n";
	if(!(instInfo->updating)){
        for(unsigned i = 0; i < usedAGs.size(); i++){
            //usedAGs[i]->outputGraph();
            //errs() << "root: " << *usedAGs[i]->getHead()->inst << "\n";
            //errs() << "root type: " << usedAGs[i]->getStatementType() << "\n";

            //Due to ordering of args in store inst, the statement type 0 actuallly represents y, and 1 represents x
            if(usedAGs[i]->getStatementType() == 0){
                std::vector<Instruction*> rootInsts = extractAssignmentStatementInsts(usedAGs[i]->getHead()->inst, statementInsts);
                yStatementInsts = rootInsts;

                std::vector<Instruction*> nodeInsts;
                unsigned numNodes = getNumMemNodes(rootInsts, nodeInsts, usedAGs[i]->getHead()->inst);

                //errs() << "Statement Insts After Getting y:\n";
                //outputList(statementInsts);

                if(numNodes == 0){
                    accessGraph* emptyGraph = new accessGraph(usedAGs[i]->getHead()->inst);
                    emptyGraph->setStatementType(usedAGs[i]->getStatementType());
                    yAG = emptyGraph;
                    //LDirectList.push_back(emptyGraph);
                }
                else{
                    //Subtract one from the node number to get path to the base instead of the full path
                    accessGraph* newAG = addPathToAccessGraph(instInfo, nodeInsts, usedAGs[i]->getHead()->inst, numNodes);
                    newAG->setStatementType(usedAGs[i]->getStatementType());
                    yAG = newAG;
                    //LDirectList.push_back(newAG);

                }
                instInfo->Gy = yAG;
            }
            else if(usedAGs[i]->getStatementType() == 1){
                std::vector<Instruction*> rootInsts = extractAssignmentStatementInsts(usedAGs[i]->getHead()->inst, statementInsts);
                xStatementInsts = rootInsts;

                std::vector<Instruction*> nodeInsts;
                unsigned numNodes = getNumMemNodes(rootInsts, nodeInsts, usedAGs[i]->getHead()->inst);

                if(numNodes == 0){
                    accessGraph* emptyGraph = new accessGraph(usedAGs[i]->getHead()->inst);
                    emptyGraph->setStatementType(usedAGs[i]->getStatementType());
                    xAG = emptyGraph;
                    //LDirectList.push_back(emptyGraph);
                }
                else{
                    //Subtract one from the node number to get path to the base instead of the full path
                    accessGraph* newAG = addPathToAccessGraph(instInfo, nodeInsts, usedAGs[i]->getHead()->inst, numNodes);
                    newAG->setStatementType(usedAGs[i]->getStatementType());
                    xAG = newAG;
                    //LDirectList.push_back(newAG);

                }

                instInfo->Gx = xAG;
            }
        }

        if(accessGraph* ELOutx = instInfo->getELOutFromRoot(xAG->getHead()->inst)){
            std::vector<accessGraph*>  ELOutxFactors = ELOutx->getFactorization(xAG, xAG->getLastNode());

            /*errs() << "ELOutx Factors:\n";
            for(unsigned i = 0; i < ELOutxFactors.size(); i++){
                ELOutxFactors[i]->outputGraph();
            }*/

            std::vector<gNode*> yExtensionNodeList;
            yExtensionNodeList.push_back(yAG->getLastNode());
            //errs() << "yAG b4 Extension: \n";
            //yAG->outputGraph();

            accessGraph* extendedAG = yAG->getExtension(yExtensionNodeList, ELOutxFactors);
            //errs() << "yAG After Extension: \n";
            //yAG->outputGraph();
            LTransferList.push_back(extendedAG);
        }
        else{
            LTransferList.push_back(yAG);
        }






	}
//	else{
//
//
//        yAG = instInfo->Gy;
//        xAG = instInfo->Gx;
//
//        if(instInfo->instNumber == 3){
//            errs() << "updating LTransfer\n";
////            std::cout << ">>> ELOut: \n";
////
////
////            for(unsigned j = 0; j < instInfo->ELOut.size(); j++){
////                instInfo->ELOut[j]->outputGraphByInst();
////            }
//////            errs() << "Inst Num 4: " << *inst << "\n";
////            errs() << ">>>>yAG\n";
////            yAG->outputGraphByInst();
////
////            errs() << ">>>>My\n";
////            gNode* testMy = yAG->getLastNode();
////            errs() << "My(Last node in yAG): " << *testMy->inst << "\n";
//
//
////            errs() << ">>>>xAG\n";
////            xAG->outputGraphByInst();
////            errs() << ">>>>Mx\n";
////            gNode* testMx = xAG->getLastNode();
////            errs() << "Mx(Last node in xAG): " << *testMx->inst << "\n";
//
//            if(accessGraph* TestELOutx = instInfo->getELOutFromRoot(xAG->getHead()->inst)){
////                errs() << "Testing ELOutx From Root: \n";
////                TestELOutx->outputGraphByInst();
//
//                std::vector<accessGraph*>  TestELOutxFactors = TestELOutx->getFactorization(xAG, xAG->getLastNode());
////                errs() << "Testing ELOutx Factors in LTransfer:\n";
////                for(unsigned i = 0; i < TestELOutxFactors.size(); i++){
////                    if(!(TestELOutxFactors[i]->isEmpty())){
////                        TestELOutxFactors[i]->outputGraphByInst();
////                    }
////                }
//
//                std::vector<gNode*> TestyExtensionNodeList;
//                TestyExtensionNodeList.push_back(yAG->getLastNode());
//
//                accessGraph* TestextendedAG = yAG->getExtension(TestyExtensionNodeList, TestELOutxFactors);
//
////                errs() << "Testing yAG After Extension: \n";
////                TestextendedAG->outputGraphByInst();
//            }
//
//////            yAG->outputGraph();
//        }

//
//        std::cout << ">>> ELOut: \n";
//
//
//        for(unsigned j = 0; j < instInfo->ELOut.size(); j++){
//        errs() << "yo\n";
//            instInfo->ELOut[j]->outputGraphByInst();
//        }


//        errs() << "B4 if\n";
//        if(xAG == NULL){
//            errs() << "xAG is null\n";
//        }
//        errs() << "xAG node size: " << xAG->getNodeList().size() << "\n";
//        accessGraph* ELOutx = instInfo->getELOutFromRoot(xAG->getHead()->inst); // Error Occurs Here (probably due to xAG not containing anything);
//        //Error Occu
//        errs() << "After getting ELOutx\n";
////        errs() << "instInfoTest " << instInfo->ELOut.size() << "\n";
////        errs() << "Test inst " << xAG->getHead()->inst << "\n";
//
////        errs() << "xAG Nodesize: " << xAG->getNodeList().size() << "\n";
//        if(accessGraph* ELOutx = instInfo->getELOutFromRoot(xAG->getHead()->inst)){
//
//            std::vector<accessGraph*>  ELOutxFactors = ELOutx->getFactorization(xAG, xAG->getLastNode());
//
//            std::vector<gNode*> yExtensionNodeList;
//            yExtensionNodeList.push_back(yAG->getLastNode());
//
//            accessGraph* extendedAG = yAG->getExtension(yExtensionNodeList, ELOutxFactors);
//            LTransferList.push_back(extendedAG);
//        }
//        else{
//            LTransferList.push_back(yAG);
//        }
//
//	}

    /*
    errs() << "Y Head: " << *yAG->getHead()->inst << "\n";
    errs() << "Y Node List Size: " << yAG->getNodeList().size() << "\n";
    errs() << "Y Last Node: " << *yAG->getLastNode()->inst << "\n";
    //yAG->outputGraph();
	//errs() << "Y Statements: \n";
	//outputList(yStatementInsts);

	errs() << "X Head: " << *xAG->getHead()->inst << "\n";
	errs() << "X Node List Size: " << xAG->getNodeList().size() << "\n";
	errs() << "X Last Node: " << *xAG->getLastNode()->inst << "\n";
	//xAG->outputGraph();
	//errs() << "X Statements: \n";
	//outputList(xStatementInsts);*/



    //errs() << "\n\n";
//    errs() << "-----------------------done with LTransfer-----------------------\n";

	return LTransferList;
}


//------------------- ELKill --------------------------

std::vector<gEdge*> getELKill( std::vector<accessGraph*> AGList, std::vector<Instruction*> rootList, InstAGInfo *instInfo, Instruction* inst){
	//ELKill result depends on the instruction type
	std::vector<gEdge*> ELKillPath;

	//AssignmentType
	if(instInfo->instType[0] == 1){
		ELKillPath = getELKillAssignment( AGList, rootList, instInfo, inst);
	}
	else if(instInfo->instType[1] == 1){
		//errs() << "ELKill Function Type \n";
		ELKillPath = getELKillFunctionCall( AGList, rootList, instInfo, inst);
        //errs() << "Current Inst in LTransfer" << *inst << "\n";
	}


	return ELKillPath;

}

std::vector<gEdge*> getELKillAssignment( std::vector<accessGraph*> AGList, std::vector<Instruction*> rootList, InstAGInfo *instInfo, Instruction* inst){
	std::vector<gEdge*> ELKillPath;


	std::vector<Instruction*> statementInsts = instInfo->statementInsts;
    std::vector<accessGraph*> usedAGs = instInfo->usedAGs;
    std::vector<accessGraph*> unusedAGs = instInfo->unusedAGs;

	//accessGraph* xAG;

	for(unsigned i = 0; i < usedAGs.size(); i++){
		//Statement Type 1 represents x for Assignments
		if(usedAGs[i]->getStatementType() == 1){
            //errs() << "Finding Kill Statement Insts\n";
            std::vector<Instruction*> rootInsts = extractKillStatementInsts(usedAGs[i]->getHead()->inst, statementInsts);
            //errs() << "extractKill Inst Path:\n"; outputList(rootInsts);

            std::vector<Instruction*> nodeInsts;
            unsigned numNodes = getNumMemNodes(rootInsts, nodeInsts, usedAGs[i]->getHead()->inst);

            //errs() << "ELKill Num Nodes: " << numNodes << "\n";

            if(numNodes == 1){
                //accessGraph* oneNodeGraph = new accessGraph(usedAGs[i]->getHead()->inst);
                gNode* headNode = new gNode(usedAGs[i]->getHead()->inst);
                gNode* tailNode = new gNode(NULL);
                gEdge* newEdge = new gEdge(headNode, tailNode);
                ELKillPath.push_back(newEdge);
            }
            else{
                accessGraph* newAG = addPathToAccessGraph(instInfo, nodeInsts, usedAGs[i]->getHead()->inst, numNodes);
                ELKillPath = newAG->getEdgeList();
            }
        }

	}

	return ELKillPath;

}

std::vector<Instruction*> extractKillStatementInsts(Instruction* rootInst, std::vector<Instruction*> &statementInsts){
    //Recreate the kill path for x

    std::vector<Instruction*> rootStatementInsts;
    Instruction* currentInst = rootInst;
    //errs() << "CurrentInst: " << *currentInst << "\n";
    Instruction* lastInst = statementInsts[statementInsts.size() - 1];
    Instruction* endInst = dyn_cast<llvm::Instruction>(lastInst->getOperand(1)); //For assignment statements, x corresponds to 2nd operand
    //errs() << "End Inst: " << *endInst << "\n";

    bool userFound = !(currentInst == rootInst);

    //If the x operand is already the root, just add rootInst to rootStatementInsts
    if(!(userFound)){
        rootStatementInsts.push_back(rootInst);
    }

    //Find users in statementInsts, starting at root, and working down towards endInst;
    while(userFound){
        userFound = false;
        for(unsigned i = 0; i < statementInsts.size(); i++){
            //errs() << "currentInst: " << *statementInsts[i] << "\n";
            if(isAUser(currentInst, statementInsts[i])){
                userFound = true;
                currentInst = statementInsts[i];
                rootStatementInsts.push_back(currentInst);
            }
        }

        if(currentInst == endInst){
            break;
        }

    }

    //rootStatementInsts.push_back(endInst);

    return rootStatementInsts;

}

std::vector<gEdge*> getELKillFunctionCall( std::vector<accessGraph*> AGList, std::vector<Instruction*> rootList, InstAGInfo *instInfo, Instruction* inst){
    std::vector<std::vector<gEdge*>> ELKillPathList;

	std::vector<Instruction*> statementInsts = instInfo->statementInsts;
    std::vector<accessGraph*> usedAGs = instInfo->usedAGs;
    std::vector<accessGraph*> unusedAGs = instInfo->unusedAGs;

	std::vector<gEdge*> ELKillPath;

	for(unsigned i = 0; i < usedAGs.size(); i++){
		//Statement Type 1 represents x for Assignments
		if(usedAGs[i]->getStatementType() == 1){
            //errs() << "Finding Kill Statement Insts\n";
            std::vector<Instruction*> rootInsts = extractKillStatementInsts(usedAGs[i]->getHead()->inst, statementInsts);
            //errs() << "extractKill Inst Path:\n"; outputList(rootInsts);

            std::vector<Instruction*> nodeInsts;
            unsigned numNodes = getNumMemNodes(rootInsts, nodeInsts, usedAGs[i]->getHead()->inst);

            //errs() << "ELKill Num Nodes: " << numNodes << "\n";

            if(numNodes == 1){
                //accessGraph* oneNodeGraph = new accessGraph(usedAGs[i]->getHead()->inst);
                gNode* headNode = new gNode(usedAGs[i]->getHead()->inst);
                gNode* tailNode = new gNode(NULL);
                gEdge* newEdge = new gEdge(headNode, tailNode);
                ELKillPath.push_back(newEdge);
            }
            else{
                accessGraph* newAG = addPathToAccessGraph(instInfo, nodeInsts, usedAGs[i]->getHead()->inst, numNodes);
                ELKillPath = newAG->getEdgeList();
            }
        }

	}

    return ELKillPath;
}



//------------------- ELIn --------------------------

std::vector<accessGraph*> InstAGInfo::getELIn(){
	//(ELOut with path removal of ELKill) unioned with ELGen

	std::vector<accessGraph*> unionedGraphs;
	//std::vector<accessGraph*> pathRemovedELOut;

	//errs() << "ELKillPath size: " << ELKillPath.size() << "\n";
	//errs() << "ELOutSize: " << ELOut.size() << "\n";//pathRemovedELOut.push_back(gUnion);
//	}
    //errs() << "ELOut Size: " << ELOut.size() << "\n";
//	errs() << "ELGen Size: " << ELGen.size() << "\n";

	std::vector<accessGraph*> iteratedGraphs;
	for(unsigned i = 0; i < usedAGs.size(); i++){
//        errs() << "unionGraph size:" << unionedGraphs.size() << "\n";
        if(!AGInList(unionedGraphs, usedAGs[i])){
//            errs() << "AG: " << *usedAGs[i]->getHead()->inst << "not in unionedGraphs\n";
            accessGraph* gUnion = new accessGraph(NULL);
            if(accessGraph* ELOutAG = getELOutFromRoot(usedAGs[i]->getHead()->inst)){

                accessGraph* tempAG  = ELOutAG->copyGraph();
                if(instNumber == 1){


                }

                if(ELKillPath.size() > 0){

            //Statement Type needs to be 1 for x in the assignment type

                    if(instNumber == 2){
    //                    errs() << "Statement Type: " << ELOutAG->getStatementType() << "\n";
                    }
                    if(usedAGs[i]->getStatementType() == 1){
                        tempAG->removePath(ELKillPath);

                    }
                }

                if(!tempAG->isEmpty()){
    //                errs() << "temp AG empty\n";

                    gUnion = gUnion->getUnion(tempAG);
                }
            }

            if(accessGraph* ELGenAG = getELGenFromRoot(usedAGs[i]->getHead()->inst)){
//            errs() << ">> Found ELGen AG\n";
//
                if(instNumber == 1){
                    errs() << "Current gUnion Tag B4 ELGen Union: " << gUnion->getHead()->tag << "\n";
                    gUnion->outputGraph();
//                errs() << " ELGEN: \n";
//                ELGenAG->outputGraphByInst();
//                accessGraph* testgUnion = gUnion->getUnion(ELGenAG);
////                errs() << "Test z union:\n";
////                testgUnion->outputGraphByInst();
////                errs() << "head:  " << *testgUnion->getHead()->inst << "\n";
                }


                gUnion = gUnion->getUnion(ELGenAG);

                if(instNumber == 1){
                   errs() << "Current gUnion Tag After ELGen Union: " << gUnion->getHead()->tag << "\n";
                   gUnion->outputGraph();

                }
            }
//            errs() << "current gUnion: \n";

            if(instNumber == 1){
                gUnion->outputGraph();

            }

            if(gUnion->getHead() != NULL){
                unionedGraphs.push_back(gUnion);
            }


            iteratedGraphs.push_back(usedAGs[i]);

        }
        else{
            errs() << "AG: " << *usedAGs[i]->getHead()->inst << "already in unionedGraphs\n";
        }




	}



	for(unsigned i = 0; i < rootList.size(); i++){

        if(accessGraph* ELOutAG = getELOutFromRoot(rootList[i])){
            if(!AGInList(iteratedGraphs, ELOutAG)){
                if(instNumber == 1){
                    ELOutAG->outputGraph();
                }
                unionedGraphs.push_back(ELOutAG);
            }


        }
	}




	ELIn = unionedGraphs;
	return unionedGraphs;
}

//------------------- ELOut --------------------------

std::vector<accessGraph*> InstAGInfo::getELOut(){
	//makeGraph(globalVar) if at Start
	//emptyGraph if at Start and not globalVar
	//union of ELIn(successor bb) for each successor

	//errs() << "succ size: " << successors.size() << "\n";
	if(successors.size() == 1){
		ELOut = successors[0]->ELIn;
	}
	else if(successors.size() > 1){

		std::vector<accessGraph*> unionedGraphs = successors[0]->ELIn;
		for(unsigned i = 1; i < successors.size(); i++){
			std::vector<accessGraph*> newUnionedGraphs;
			for(unsigned j = 0; j < unionedGraphs.size(); j++){
				accessGraph* newUnion = unionedGraphs[j]->getUnion(successors[i]->ELIn[j]);
				newUnionedGraphs.push_back(newUnion);
			}
			unionedGraphs = newUnionedGraphs;
		}
		ELOut = unionedGraphs;
	}
	return ELOut;
}


accessGraph* InstAGInfo::getELOutFromRoot(Instruction* root){
	//std::vector<accessGraph*> ELOutList = getELOut();
	//accessGraph* ELOutFromRoot;
//	errs() << "In get ELOut from Root\n";
//	errs() << "ELOut size: " << ELOut.size() << "\n";
	for(unsigned i = 0; i < ELOut.size(); i++){
		if(ELOut[i]->getHead()->inst == root){
			//ELOutFromRoot = ELOut[i];
			return ELOut[i];
		}
	}
	//errs() << "no ELOut found that matches root\n";
	//ELOutFromRoot =
	return NULL;
}

accessGraph* InstAGInfo::getELGenFromRoot(Instruction* root){
    //accessGraph* ELOutFromRoot;
    //errs() << "Finding ELGen with Root: " << *root << "\n";
	for(unsigned i = 0; i < ELGen.size(); i++){
        //errs() << "Finding ELGen with Root: " << *root << "\n";
        if(ELGen[i]->getHead() == NULL){
            errs() << "NULL Head\n";
        }
		if((ELGen[i]->getHead() != NULL) and (ELGen[i]->getHead()->inst == root)){
			//ELOutFromRoot = ELOut[i];
			return ELGen[i];
		}
	}
    //errs() << "no ELGen found that matches root\n";
	//ELOutFromRoot =
	return NULL;
}
