//Heap Liveness Analysis using Access Graphs
#include "heapLivenessAnalysis.h"



void doAGLivenessAnalysis(Function &F, std::vector<accessGraph*> AGList,  std::vector<Instruction*> rootList, std::vector<Instruction*> instList, AAResults* aliasAnalysis){


    std::vector<accessGraph*> startAGList;


	BitVector defsBitVector(AGList.size());//Create Initial BitVector for AG roots
	std::vector<InstAGInfo*> InstAGInfoList;

	//Reverse Iterate the Instructions
	//Create a InstAGInfo for each valid Instruction

	int instCount = 0;

	std::vector<Instruction*> tempInstList;

	for(unsigned i = 0; i < instList.size(); i++){
        tempInstList.push_back(instList[i]);
        bool aliasFound = findAliases(instList, aliasAnalysis, instList[i]);
	}

	int iCount = 0;
	for(unsigned i = tempInstList.size() - 1; i > 0; i--){


        Instruction* inst = tempInstList[i];
//        errs() << "\n\nCurrentInst : " << *instList[i] << " <<<<<<<<<<<<<<<\n";
//        errs() << "I: " << instCount << "\n";

        InstAGInfo* newInst = new InstAGInfo(AGList, rootList);
        newInst->instNumber = InstAGInfoList.size();
        newInst->rootList = rootList;
        std::vector<accessGraph*> usedAGs;
        std::vector<Instruction*> statementInsts;

        newInst->AGList = &startAGList;

        newInst->instType = getInstTypes(rootList, newInst, inst);
        newInst->statementInsts.push_back(inst);

//        errs() << "stmtInsts Size: " << newInst->statementInsts.size() << "\n";
        newInst->thisInst = inst;


        //Only add instructions that have a valid type
        if( (newInst->instType[0] == 1) or (newInst->instType[1] == 1) or (newInst->instType[2] == 1) or (newInst->instType[3] == 1)){
            InstAGInfoList.push_back(newInst);
        }

        removeStatementInsts(tempInstList, newInst->statementInsts);

        if(i > 0){
            i = tempInstList.size();
        }

        instCount++;
//        iCount++;
//        if(iCount == instList.size()){
//            break;
//        }
        if(i == 0){
            break;
        }

	}


//-------------------------------------------------





	//Fill in instruction "successors" for convinience
	int bCount = 0;
	for(std::vector<InstAGInfo*>::reverse_iterator i = InstAGInfoList.rbegin(); i != InstAGInfoList.rend(); i++){

		addSuccessors(*i, InstAGInfoList, instList);
	}


	//Now, reverse iterate instructions; finding ELGen and ELKillPath, and updating ELIn and ELOut untill there are no changes

    int iterationCount = 0;
    bool changed = true;
    while(changed){
        changed = false;
//        errs() << "\n\n>>>>>>>>>>>>> Iteration: " << iterationCount << "\n";
        for(unsigned i = 0; i < InstAGInfoList.size(); i++){
//            errs() << "****************************************************************************************\n\n";
//            errs() << "Current Inst: " << *InstAGInfoList[i]->thisInst << "\n";
//			errs() << ">>>>>>>>>>>>";
//    		outputType(InstAGInfoList[i]);

            std::vector<accessGraph*> currentIn = createAGCopies(InstAGInfoList[i]->ELIn);
            std::vector<accessGraph*> currentOut = createAGCopies(InstAGInfoList[i]->ELOut);

//                errs() << "Getting ELOut\n";
                InstAGInfoList[i]->getELOut();
//    			errs() << "Getting ELGEN\n";
                InstAGInfoList[i]->ELGen = getELGen(AGList, rootList, InstAGInfoList[i], InstAGInfoList[i]->thisInst);
//                errs() << "Getting ELKill Paths\n";
                InstAGInfoList[i]->ELKillPath = getELKill(AGList, rootList, InstAGInfoList[i], InstAGInfoList[i]->thisInst);

//                errs() << "Getting ELIn\n";
                InstAGInfoList[i]->getELIn();


                if(findChanges(InstAGInfoList[i]->ELOut, currentOut)){
                    changed = true;
//                    errs() << "Changed detected in ELOut\n";
                }
                if(findChanges(InstAGInfoList[i]->ELIn, currentIn)){
                    changed = true;
//                    errs() << "Changed detected in ELIn\n";
                }


        }
        //If the iteration count reaches 20, an unknown error most likely occured
        if(iterationCount == 20){
            errs() << ">>>>>>>>>>>>>Reached iteration count 20\n";
            break;
        }


        iterationCount++;

	}

	errs() << "Finished Liveness Iteration\n";

	//Output the liveIn graphs of the first instruction, which represents the
	// heap liveIn information for the currentfunction.
//	if(InstAGInfoList.size() > 0){
//        errs() << "Function LiveIn Graph: \n";
//        InstAGInfo* firstInst = InstAGInfoList[InstAGInfoList.size()-1];
//        for(unsigned i = 0; i < firstInst->ELIn.size(); i++ ){
//            firstInst->ELIn[i]->outputGraphByInst();
//        }
//
//	}

//	outputLiveInfo(InstAGInfoList, -1);
//	outputLiveInfo(InstAGInfoList, -1);

    int freedInstCount = 0;

    for(unsigned i = 0; i < InstAGInfoList.size(); i++){
        determineFreeableInsts(instList, aliasAnalysis, InstAGInfoList[i]);

        for(unsigned j = 0; j < InstAGInfoList[i]->diffInsts.size(); j++){
//            errs() << "Diff Insts: " << *InstAGInfoList[i]->diffInsts[j] << "\n\n";
//            errs() << "Diff Insts: " << *InstAGInfoList[i]->diffInsts[j] << "\n\n";
            freedInstCount++;
        }


    }

    errs() << "There are << " << freedInstCount << " >> freeable pointers in this function\n\n";



//    determineFreeableInsts(instList, aliasAnalysis, InstAGInfoList);

}


void determineFreeableInsts(std::vector<Instruction*> instList, AAResults* aliasAnalysis, InstAGInfo* AGInfo){

//    InstAGInfoList[1]->output

    std::vector<Instruction*> liveInInsts = getLiveInInstList(AGInfo);
//    errs() << "Done with LiveInlist\n";
    std::vector<Instruction*> liveOutInsts = getLiveOutInstList(AGInfo);

//    errs() << "liveInInsts size: " << liveInInsts.size() << "\n";

//    for(unsigned i = 0; i < liveInInsts.size(); i++){
//        errs() << "liveIn Insts: " << *liveInInsts[i] << "\n";
//
//    }
////
//    for(unsigned i = 0; i < liveOutInsts.size(); i++){
//        errs() << "liveOut Insts: " << *liveOutInsts[i] << "\n";
//
//    }
//
    AGInfo->diffInsts = findInstDifference(liveInInsts, liveOutInsts);


    for(unsigned j = 0; j < AGInfo->diffInsts.size(); j++){
//        errs() << "Inst #: " << i << "\n";
//        errs() << "Diff Insts: " << *AGInfo->diffInsts[j] << "\n\n";
    }

//    for(unsigned i = 0; i < AGInfo->diffInsts.size(); i++){
//        errs() << "Diff Insts: " << *AGInfo->diffInsts[i] << "\n";
//
//    }

//    AGInfo->diffInsts = findInstDifference(liveInInsts, liveOutInsts);

//    for(unsigned i = 0; i < instList.size(); i++){
//        if ( isa<PointerType>(instList[i]->getType()) ){
//            //errs() << "Pointer Inst: " << *instList[i] << "\n";
//        }
//    }

}

std::vector<Instruction*> findInstDifference(std::vector<Instruction*> liveInInsts, std::vector<Instruction*> liveOutInsts){

    std::vector<Instruction*> diffInsts;

    if(liveOutInsts.size() == 0){
        return diffInsts;
    }

    for(unsigned i = 0; i < liveInInsts.size(); i++){

//        errs() << "instFound: " << findInst(liveOutInsts, liveInInsts[i]) << "\n";
        if( ! (findInst(liveOutInsts, liveInInsts[i])) ){
//            errs() << "inst not Found: " << findInst(liveOutInsts, liveInInsts[i]) << " " << *liveInInsts[i] << "\n";

            diffInsts.push_back(liveInInsts[i]);
        }
    }


    return diffInsts;

}

bool findInst(std::vector<Instruction*> instList, Instruction* inst){

    for(unsigned i = 0; i < instList.size(); i++){
        if(instList[i] == inst){

//            errs() << "inst: " << *inst << "found\n";
            return true;
            //errs() << "inst: " << instList[i] << "found\n";
        }
    }
//    errs() << "inst: " << *inst << "not found\n";
    return false;
}

std::vector<Instruction*> getLiveInInstList(InstAGInfo* AGInfo){

    std::vector<Instruction*> liveInsts;
    for(unsigned i = 0; i < AGInfo->ELIn.size(); i++){
        accessGraph* currentAG = AGInfo->ELIn[i];

        for(unsigned j = 0; j < currentAG->getNodeList().size(); j++){
            if(currentAG->getNodeList()[j] != NULL && currentAG->getNodeList()[j]->inst != NULL){

                liveInsts.push_back(currentAG->getNodeList()[j]->inst);
            }
        }

    }
    return liveInsts;
}

std::vector<Instruction*> getLiveOutInstList(InstAGInfo* AGInfo){

    std::vector<Instruction*> liveInsts;
    for(unsigned i = 0; i < AGInfo->ELOut.size(); i++){
        accessGraph* currentAG = AGInfo->ELOut[i];
//        if(currentAG == NULL){
//            errs() << "NULL AG\n";
//        }
//        errs() << "B4 Finding out if NULL\n";
        for(unsigned j = 0; j < currentAG->getNodeList().size(); j++){
//            errs() << "Finding out if NULL\n";
//            if(currentAG->getNodeList()[i] == NULL){
//                errs() << "NULL gNode\n";
//            }
//            else if(currentAG->getNodeList()[i]->inst == NULL){
//
//                errs() << "NULL Inst\n";
//            }

            if(currentAG->getNodeList()[j] != NULL && currentAG->getNodeList()[j]->inst != NULL){

                liveInsts.push_back(currentAG->getNodeList()[j]->inst);
            }
//            if(currentAG->getNodeList()[i]->inst){
//
//                liveInsts.push_back(currentAG->getNodeList()[i]->inst);
//            }

        }

    }
    return liveInsts;
}

bool findAliases(std::vector<Instruction*> instList, AAResults* aliasAnalysis, Instruction* inst){


    for(unsigned i = 0; i < instList.size(); i++){
        bool isNoAlias = aliasAnalysis->isNoAlias(instList[i], inst);
        bool isMustAlias = aliasAnalysis->isMustAlias(instList[i], inst);
        if(isNoAlias){
            //errs() << "inst: " << *inst << " is NoAlias with " << *instList[i] << ".\n";
        }
        if(isMustAlias){
            if(instList[i] != inst){
//                errs() << "inst: " << *inst << " is MustAlias with " << *instList[i] << ".\n";
            }

        }

    }

    return true;


}





void outputLiveInfo(std::vector<InstAGInfo*> &InstAGInfoList, int index){


    if(index != -1){
        errs() << "Current Inst: " << *InstAGInfoList[index]->thisInst << "\n";
        errs() << ">> inst# : " << index << "\n";
//        errs() << ">> "
        outputType(InstAGInfoList[index]);

        //------------------------------------------------------

        //--- Output StatementInsts ----------------------------
        errs() << ">>> StatementInsts: \n";
        if(InstAGInfoList[index]->statementInsts.size() > 0){
            for(unsigned j = 0; j < InstAGInfoList[index]->statementInsts.size(); j++){
//                InstAGInfoList[index]->ELGen[j]->outputGraphByInst();
                errs() << *InstAGInfoList[index]->statementInsts[j] << "\n";
            }
        }



       //------------------------------------------------------


//        if(InstAGInfoList[index]->successors.size() > 0){
//            errs() << ">> Successor inst: " << *InstAGInfoList[index]->successors[0]->thisInst << "\n";
//        }
//        errs() << ">> Successor inst: " << *InstAGInfoList[index]->successors[0]->thisInst << "\n";

        //------------------------------------------------------

//        errs() << ">>> ELOut: \n";
//        errs() << ">>> ELOut size: " << InstAGInfoList[index]->ELOut.size() << "\n";
//        errs() << ">>> ELOut succ size: " << InstAGInfoList[index]->successors.size() << "\n";
//
//        for(unsigned j = 0; j < InstAGInfoList[index]->ELOut.size(); j++){
//        //errs() << "yo\n";
//            InstAGInfoList[index]->ELOut[j]->outputGraphByInst();
//
//        }
//
//
//        //------------------------------------------------------
//
//        errs() << ">>> ELIn: \n";
//        errs() << ">>> ELIn size: " << InstAGInfoList[index]->ELIn.size() << "\n";

//        for(unsigned j = 0; j < InstAGInfoList[index]->ELIn.size(); j++){
//        //errs() << "yo\n";
//            InstAGInfoList[index]->ELIn[j]->outputGraphByInst();
//
//        }
//
//        for(unsigned j = 0; j < InstAGInfoList[index]->ELIn.size(); j++){
//        //errs() << "yo\n";
//            InstAGInfoList[index]->ELIn[j]->outputGraph();
//
//        }



        //------------------------------------------------------

//
//        errs() << ">>> EGen: \n";
//        if(InstAGInfoList[index]->ELGen.size() > 0){
//            for(unsigned j = 0; j < InstAGInfoList[index]->ELGen.size(); j++){
////                InstAGInfoList[index]->ELGen[j]->outputGraphByInst();
//                InstAGInfoList[index]->ELGen[j]->outputGraph();
//            }
//        }

        //------------------------------------------------------

//        errs() << ">>> ELKill: \n";
//        errs() << ">>> ELKill size: " << InstAGInfoList[index]->ELKillPath.size() << "\n";
//
//        if(InstAGInfoList[index]->ELKillPath.size() > 0){
//            for(unsigned j = 0; j < InstAGInfoList[index]->ELKillPath.size(); j++){
//                //InstAGInfoList[i]->ELGen[j]->outputGraph();
//
//                errs() << "ELKill Edge: " << *InstAGInfoList[index]->ELKillPath[j]->head->inst;// << "\n";
//                if(Instruction* tailInst = InstAGInfoList[index]->ELKillPath[j]->tail->inst){
//                    errs() << ", " << *tailInst;// << "\n";
//
//                }
//                errs() << "\n";
//
//            }
//            errs() << "%%%%%%%%%%%%%%%%%%%%%%%%\n";
//        }



        //------------------------------------------------------

//        if(InstAGInfoList[index]->LTransfer.size() > 0){
//                //errs() << ">> head: " << *InstAGInfoList[i]->ELGen[0]->getHead()->inst << "\n";
//
//            errs() << ">> inst: " << index << " " <<  *InstAGInfoList[index]->thisInst << "\n";
//            for(unsigned j = 0; j < InstAGInfoList[index]->LTransfer.size(); j++){
//
//                InstAGInfoList[index]->LTransfer[j]->outputGraph();
//                //errs() << ">>> Inst Types <<<\n"; errs() << "Bit vector value: ";for(unsigned k = 0; k < 4; k++){errs() << InstAGInfoList[k]->instType[k];} errs() << "\n\n";
//            }
//            errs() << "%%%%%%%%%%%%%%%%%%%%%%%%\n";
//        }


//                //Output ELIn
//                errs() << ">>> ELIn After Update: \n";
//                for(unsigned j = 0; j < InstAGInfoList[i]->ELIn.size(); j++){
//                //errs() << "yo\n";
//                    InstAGInfoList[i]->ELIn[j]->outputGraph();
//                }
//
//                errs() << ">>> Previous ELIn: \n";
//                for(unsigned j = 0; j < InstAGInfoList[i-1]->ELIn.size(); j++){
//                //errs() << "yo\n";
//                    InstAGInfoList[i-1]->ELIn[j]->outputGraph();
//                }


    }
    else{
        for(unsigned i = 0; i < InstAGInfoList.size(); i++){
            errs() << "Current Inst: " << *InstAGInfoList[i]->thisInst << "\n";
            errs() << "Inst # " << InstAGInfoList[i]->instNumber << "\n";


            errs() << ">>> ELOut: \n";
            errs() << ">>> ELOut succ size: " << InstAGInfoList[i]->successors.size() << "\n";

            for(unsigned j = 0; j < InstAGInfoList[i]->ELOut.size(); j++){
            //errs() << "yo\n";
                InstAGInfoList[i]->ELOut[j]->outputGraphByInst();
            }

            errs() << ">>> ELIn: \n";
            for(unsigned j = 0; j < InstAGInfoList[i]->ELIn.size(); j++){
            //errs() << "yo\n";
                InstAGInfoList[i]->ELIn[j]->outputGraphByInst();
            }

    //        errs() << "LTransfer Graphs:\n";
    //        outputType(InstAGInfoList[i]);
    //        if(InstAGInfoList[i]->LTransfer.size() > 0){
    //                //errs() << ">> head: " << *InstAGInfoList[i]->ELGen[0]->getHead()->inst << "\n";
    //
    //                errs() << ">> inst: " << i << " " <<  *InstAGInfoList[i]->thisInst << "\n";
    //                for(unsigned j = 0; j < InstAGInfoList[i]->LTransfer.size(); j++){
    //
    //                    InstAGInfoList[i]->LTransfer[j]->outputGraph();
    //                    //errs() << ">>> Inst Types <<<\n"; errs() << "Bit vector value: ";for(unsigned k = 0; k < 4; k++){errs() << InstAGInfoList[k]->instType[k];} errs() << "\n\n";
    //                }
    //                errs() << "%%%%%%%%%%%%%%%%%%%%%%%%\n";
    //            }
    //        outputType(InstAGInfoList[i]);



    //-----------------------------------------------------------------------------------------------
    //        errs() << "LDirect Graphs: \n";
    //        outputType(InstAGInfoList[i]);
    //        if(InstAGInfoList[i]->LDirect.size() > 0){
    //            //errs() << ">> head: " << *InstAGInfoList[i]->ELGen[0]->getHead()->inst << "\n";
    //
    //            errs() << ">> inst: " << i << " " <<  *InstAGInfoList[i]->thisInst << "\n";
    //            for(unsigned j = 0; j < InstAGInfoList[i]->LDirect.size(); j++){
    //
    //                InstAGInfoList[i]->LDirect[j]->outputGraph();
    //                //errs() << ">>> Inst Types <<<\n"; errs() << "Bit vector value: ";for(unsigned k = 0; k < 4; k++){errs() << InstAGInfoList[k]->instType[k];} errs() << "\n\n";
    //            }
    //            errs() << "%%%%%%%%%%%%%%%%%%%%%%%%\n";
    //        }

    //-----------------------------------------------------------------------------------------------
    //        errs() << "LDirect Graphs: \n";
    //        outputType(InstAGInfoList[i]);
    //
    //        if(InstAGInfoList[i]->ELGen.size() > 0){
    //            for(unsigned j = 0; j < InstAGInfoList[i]->ELGen.size(); j++){
    //                InstAGInfoList[i]->ELGen[j]->outputGraph();
    //            }
    //        }

            //-----------------------------------------------------------------------------------------------
        }

    }

}

void outputType(InstAGInfo* instInfo){
    if(instInfo->instType[0] == 1){
            errs() << "AssignmentType\n";
    }
    else if(instInfo->instType[1] == 1){
        errs() << "FunctionType\n";
    }
    else if(instInfo->instType[2] == 1){
        errs() << "ReturnType\n";
    }
    else if(instInfo->instType[3] == 1){
        errs() << "UsageType\n";
    }
}


bool findChanges(std::vector<accessGraph*> AGSet1, std::vector<accessGraph*> AGSet2){
    if(AGSet1.size() != AGSet2.size()){
//        errs() << "Two AG sets are not the same size\n";
        return true;
    }
    else{

        for(unsigned i = 0; i < AGSet1.size(); i++){
            if(*AGSet1[i] != *AGSet2[i]){
//                errs() << "Change detected in the two AG Sets\n";
                return true;
            }
        }

    }
//    errs() << "Two AG sets are identical\n";

    return false;

}

std::vector<accessGraph*> createAGCopies(std::vector<accessGraph*> AGList){
    std::vector<accessGraph*> AGCopyList;

    for(unsigned i = 0; i < AGList.size(); i++){
        accessGraph* copyAG = AGList[i]->copyGraph();
        AGCopyList.push_back(copyAG);
    }


    return AGCopyList;
}


void addSuccessors(InstAGInfo* &currentInst, std::vector<InstAGInfo*> InstAGList, std::vector<Instruction*> instList){
	//The 'successors" of an Instruction are its Users

    int limitCount = 0;
    for(std::vector<InstAGInfo*>::reverse_iterator i = InstAGList.rbegin(); i != InstAGList.rend(); i++){
        if(*i != currentInst){
            if(checkSuccessor(currentInst, *i, instList)){
                currentInst->successors.push_back(*i);
            }
        }

    }

    //errs() << ">>> Done adding successors\n\n";
}

bool checkSuccessor(InstAGInfo* currInst, InstAGInfo* succInst, std::vector<Instruction*> instList){
    //errs() << "curr Inst: " << *currInst->thisInst << "\n";
    //errs() << "succ Inst: " << *succInst->thisInst << "\n";
    //errs() << "currInst statementInsts:" << "\n";
    //outputList(currInst->statementInsts);

    //errs() << "succInst statementInsts:" << "\n";
    //outputList(succInst->statementInsts);

    //First Check if they're in the same BB

    if(currInst->thisInst->getParent() == succInst->thisInst->getParent()){

        //errs() << "------------> Same Parent\n";
        //In this case, just check the order from the inst list
        Instruction* nearestInst = findNearestInst(currInst->thisInst, instList);
        bool found = false;
        unsigned instIndex = getInstPosition(nearestInst, succInst->statementInsts, found);
        return found;
    }
    else{

        //errs() << "------------> Different Parent\n";
        //Check if this is a branch inst
        if(isa<BranchInst>(currInst->thisInst)){

            if(checkForBranchAGInfo(currInst->thisInst, succInst)){
                return true;
            }
        }
        else{
            //If this isn't a branch inst, look for nearest inst that inst in currInst stmtList until reaching a branch
            Instruction* nearestInst = findNearestInst(currInst->thisInst, instList);
            if(isa<BranchInst>(nearestInst)){
                //errs() << "------------> Nearest Inst is a Branch Inst\n";
                bool foundSucc = checkForBranchAGInfo(nearestInst, succInst);
                if(checkForBranchAGInfo(nearestInst, succInst)){
                    //errs() << "succInst is a successor! yay!\n";
                    return true;
                }
            }
            else if(nearestInst == currInst->thisInst){
                //errs() << "------------> This is last inst\n";
            }

        }
    }
    //errs() << "\n";


    return false;


}

bool checkForBranchAGInfo(Instruction* inst, InstAGInfo* succInstInfo){

    //errs() << "branch operands num: " << inst->getNumOperands() << "\n";
    /*(if(inst->getNumOperands() == 1){
        //errs() << "Branch with one operand\n";
        BasicBlock* bb = dyn_cast<llvm::BasicBlock>(inst->getOperand(0));
        Instruction* firstInst = &*bb->begin();

        //errs() << "First bb inst: " << *firstInst << "\n";
        bool found = false;
        //outputList(succInstInfo->statementInsts);
        unsigned instIndex = getInstPosition(firstInst, succInstInfo->statementInsts, found);
        //errs() << "found: " << found << "\n";

        return found;
    }*/
    for(unsigned opNum = 0; opNum < inst->getNumOperands(); opNum++){
        //errs() << "opNum: " << opNum << "\n";
        if(BasicBlock* bb = dyn_cast<llvm::BasicBlock>(inst->getOperand(opNum))){
            Instruction* firstInst = &*bb->begin();

            //errs() << "First bb inst: " << *firstInst << "\n";
            bool found = false;
        //outputList(succInstInfo->statementInsts);
            unsigned instIndex = getInstPosition(firstInst, succInstInfo->statementInsts, found);
            if(found){
                return true;
            }
        }

    }
    return false;
}

Instruction* findNearestInst(Instruction* inst, std::vector<Instruction*> instList){

    bool found;
    unsigned instIndex = getInstPosition(inst, instList, found);

    if((instIndex + 1) != instList.size()){
        Instruction* nearestInst = instList[instIndex + 1];
        return nearestInst;
    }
    else{
        return inst;
    }

}

unsigned getInstPosition(Instruction* inst, std::vector<Instruction*> instList, bool &found){

    for(unsigned i = 0; i < instList.size(); i++){
        if( inst == instList[i]){
            found = true;
            return i;
        }
    }
    return 0;
}

InstAGInfo* findNextInstInfo(InstAGInfo* instInfo, std::vector<InstAGInfo*> InstAGList, std::vector<Instruction*> instList){
    bool branchFound = false;
    InstAGInfo* nextInstInfo = InstAGList[0];
    bool filler = false;
    unsigned instIndex = getInstPosition(instInfo->thisInst, instList, filler);

    while(!(branchFound)){
        Instruction* currInst = instList[instIndex];
        //std::cout << "currInst: " << currInst << "\n";

        if(isa<BranchInst>(currInst)){
            //Handle Branch
            //std::cout << "Branch Found\n";
            break;
        }
        else{
            InstAGInfo* foundAG = instInfo;
            //bool found = false;

            if(nextInstInfoSearch(currInst, InstAGList, foundAG)){
                //std::cout << "found next AGList\n";
                break;
            }
            //find next inst that isn't in current instInfo
        }
        instIndex++;
        //else if(){}
        break;
    }

}

bool nextInstInfoSearch(Instruction* inst, std::vector<InstAGInfo*> InstAGList, InstAGInfo* &foundAG){

    InstAGInfo* foundSucc;
    for(unsigned i = 0; i < InstAGList.size(); i++){
        if(inst != InstAGList[i]->thisInst){
            //Same Parent BB
            if(inst->getParent() == InstAGList[i]->thisInst->getParent()){
                //errs() << "Finding Successor Within BB\n";
                bool found = false;
                unsigned testIndex = getInstPosition(inst, InstAGList[i]->statementInsts, found);
                //errs() << "testIndex: " << testIndex << "\n";
                if(found){
                    foundAG = InstAGList[i];
                    return true;
                }

            }

        }


    }

}



void removeStatementInsts(std::vector<Instruction*> &instList, std::vector<Instruction*> statementInsts){

    //errs() << "StatmentList Size: " << statementInsts.size() << "\n";
    while(statementInsts.size() > 0){
        Instruction* currentInst = statementInsts[0];
//        errs() << "currentInst: " << *currentInst << "\n";
        //for(unsigned i = 0; i <  instList.size(); i++){
        bool found = false;
        for(std::vector<Instruction*>::iterator firstInst = instList.begin(); firstInst != instList.end(); firstInst++){
//            errs() << "inst iterator: " << **firstInst << "\n";
            if(*firstInst == currentInst){
                instList.erase(firstInst);
                statementInsts.erase(statementInsts.begin());
                found = true;
                //errs() << "erased one\n";
                //errs() << instList.size() << "\n";
                break;

            }

        }
        if(!found){
            statementInsts.erase(statementInsts.begin());
        }
        //errs() << "StatmentList Size: " << statementInsts.size() << "\n";
        //break;

    }
    //errs() << "StatmentList Size: " << statementInsts.size() << "\n";

}

void outputList(std::vector<Instruction*> instList){
    errs() << "List Size: " << instList.size() << "\n";
    for( unsigned i = 0; i < instList.size(); i++){
        errs() << *instList[i] << "\n";
    }

}

void outputInstAGList(std::vector<InstAGInfo*> instAGList){
    errs() << "List Size: " << instAGList.size() << "\n";
    for( unsigned i = 0; i < instAGList.size(); i++){
        errs() << *instAGList[i]->thisInst << "\n";
    }

}

void outputAGList(std::vector<accessGraph*> AGList){
    errs() << "List Size: " << AGList.size() << "\n";
    for( unsigned i = 0; i < AGList.size(); i++){
//        errs() << *instAGList[i]->thisInst << "\n";
        AGList[i]->outputGraphByInst();
        AGList[i]->outputGraph();
    }

}



BitVector getInstTypes(std::vector<Instruction*> rootList, InstAGInfo* &instInfo,  Instruction* inst){

	BitVector typeBitVector(4);

//	errs() << "Finding type\n";
	//Assignment Statements: indicated by the StoreInst
	//Function Call: indicated by CallInst followed by StoreInst
	//Return Statement: indicated by ReturnInst
	//Use Statement: indicated by a usage of the root node or one of its edges

	//std::vector<accessGraph*> usedAGs = instInfo->usedAGs;
	//std::vector<accessGraph*> unusedAGs = instInfo->unusedAGs;
	std::vector<Instruction*> statementInsts = instInfo->statementInsts;




	if( (isa<StoreInst>(inst)) and (checkValidFunctionCall(inst)) ) {
	//if(isa<CallInst>(inst)){

        typeBitVector.set(1);
        //instInfo->instType.set(1);
//        errs() << "found function call : " << *inst << "\n";
        findRootUser(rootList, instInfo->usedAGs, instInfo->statementInsts, inst, true);

//        for(unsigned i = 0; i < instInfo->usedAGs.size() ; i++){
//            errs() << "statementType: " << instInfo->usedAGs[i]->getStatementType() << "\n";
//        }

	}

	else if( (isa<StoreInst>(inst) )and (checkValidAssignment(inst)) ){
            //errs() << ">>> Valid Assignment Found: " << *inst << "\n";
            //typeBitVector.set(0);
            //instInfo->instType.set(0);
            findRootUser(rootList, instInfo->usedAGs, instInfo->statementInsts, inst, true);
            //errs() << "Used AG size: " << instInfo->usedAGs.size() << "\n";
            if(instInfo->usedAGs.size() == 2){
                typeBitVector.set(0);
            }

            for(unsigned i = 0; i < instInfo->usedAGs.size() ; i++){
                //errs() << "statementType: " << instInfo->usedAGs[i]->getStatementType() << "\n";
            }
	}/*
    else if(isa<CallInst>(inst)){
        if(checkValidFunctionCall(AGList, usedAGs, inst)){
            typeBitVector.set(1);
        }

	}*/
	else if(isa<ReturnInst>(inst)){

        findRootUser(rootList, instInfo->usedAGs, instInfo->statementInsts, inst, true);
        if(instInfo->usedAGs.size() == 1){
                typeBitVector.set(2);
                //instInfo->instType.set(2);
        }
		//typeBitVector.set(2);
	}
	else if(findRootUser(rootList, instInfo->usedAGs, instInfo->statementInsts, inst, true)){
		typeBitVector.set(3);
		//instInfo->instType.set(3);
	}

	/*if(getAGsUsed(AGList, usedAGs, statementInsts, inst)){
		typeBitVector.set(3);
	}*/

    findUnusedAGs(rootList, instInfo->usedAGs, instInfo->unusedAGs);

    /*for(unsigned i = 0; i < unusedAGs.size(); i++){
        errs() << "unusedAG: " << *unusedAGs[i]->getHead()->inst << "\n";
    }*/
    //errs() << "unusedAG size: " << unusedAGs.size() << "\n";

	//errs() << ">>> Inst Types <<<\n"; errs() << "Bit vector value: ";for(unsigned i = 0; i < 4; i++){errs() << typeBitVector[i];} errs() << "\n\n";
	return typeBitVector;
}

void findUnusedAGs(std::vector<Instruction*> rootList, std::vector<accessGraph*> usedAGs, std::vector<accessGraph*> &unusedAGs){

    for(unsigned i = 0; i < rootList.size(); i++){
        if(!(AGFound(usedAGs, rootList[i]))){
            unusedAGs.push_back(new accessGraph(rootList[i]));
        }
    }
    return;
}

bool AGFound(std::vector<accessGraph*> usedAGs, Instruction* rootInst){

    for(unsigned i = 0; i < usedAGs.size(); i++){
        if(usedAGs[i]->getHead()->inst == rootInst){
            return true;
        }
    }
    return false;
}

bool checkValidFunctionCall(Instruction* inst){
    //Check if Function Call is in the valid form: x = f(y)
    //where x and y are nodes in separate AGs
    bool validFunctionCall = false;
    //errs() << ">>>Checking Function Call\n";
    //errs() << "Inst: " << *inst << "\n";


    if(inst->getNumOperands() >= 2){
        //errs() <<
        if( isa<CallInst>(inst->getOperand(0))){
            validFunctionCall = true;
        }
        else{
            int limitCount = 0;
            bool found = false;
            findCallInst(inst, found, limitCount);

            if(found){
                validFunctionCall = true;
            }
        }
        /*if( (isa<CallInst>(inst->getOperand(0))) and (isa<PointerType>(inst->getOperand(1)->getType())) ){
            //errs() << "Valid Operand Types\n";
            CallInst* callInst = dyn_cast<CallInst>(inst->getOperand(0));
            for(User::op_iterator currentArg = callInst->arg_begin(); currentArg != callInst->arg_end(); currentArg++){

                if(llvm::Instruction* argInst = dyn_cast<llvm::Instruction>(currentArg)){
                    //errs() << "arg is an inst\n";
                    if(isa<PointerType>(argInst->getType())){
                        errs() << "Found a valid pointer arg\n";
                        validFunctionCall = true;
                    }
                }

            }

        }*/

    }
    return validFunctionCall;
}

bool findCallInst(Instruction* currInst, bool &found, int limitCount){

    /*if(limitCount == 10){
        errs() << "limit count reached";
        return false;
    }*/
    if(isa<CallInst>(currInst)){
        //errs() << "Call Inst Found\n";
        found = true;
    }
    else{
        for(unsigned opNum = 0; opNum < currInst->getNumOperands(); opNum++){
            if(isa<CallInst>(currInst->getOperand(opNum))){
                //errs() << "Call Inst Found\n";
                found = true;
            }
            else if(llvm::Instruction* opInst = dyn_cast<llvm::Instruction>(currInst->getOperand(opNum))){
                //if()
                findCallInst(opInst, found, limitCount+1);
            }
        }
    }
    return false;

}


bool checkValidAssignment(Instruction* inst){

    bool valid = true;
    for(unsigned opNum = 0; opNum < inst->getNumOperands(); opNum++){
        if(llvm::Instruction* opInst = dyn_cast<llvm::Instruction>(inst->getOperand(opNum))){
            if( ! isa<PointerType>(opInst->getType())){
                valid = false;
                break;
            }
        }
    }
    return valid;
}

bool findRootUser(std::vector<Instruction*> rootList, std::vector<accessGraph*> &usedAGs, std::vector<Instruction*> &statementInsts, Instruction* inst, bool originalInst, unsigned operandNum){

    //First, look to see if root inst is contained here. Otherwise, look for any other inst
    //used.

    bool rootFound = false;
    //bool anotherInstFound = false;
//    errs() << "Find Root User for Current Inst: " << *inst << "\n";
    for(unsigned opNum = 0; opNum < inst->getNumOperands(); opNum++){
        /*if(statementInsts.size() > 20){
            break;
        }*/
        if(llvm::Instruction* opInst = dyn_cast<llvm::Instruction>(inst->getOperand(opNum))){


            if(checkIfRoot(rootList, opInst)){
                //errs() << "root inst: " << *opInst << "\n";
                accessGraph* AG = new accessGraph(opInst);
                std::string AGTag = findRootTag(rootList, opInst);
                AG->setHeadTag(AGTag);
                rootFound = true;
//                errs() << "opNum: " << opNum << "\n";
//                errs() << "operandNum: " << operandNum << "\n";
                if(originalInst){
                    //errs() << ""
                    AG->setStatementType(opNum);

                }
                else{
                    AG->setStatementType(operandNum);
                }
                /*if((opNum == 0) and (originalInst)){
                    AG->setStatementType(0);
                }
                else if((opNum == 1) and (originalInst)){
                    AG->setStatementType(1);
                }*/
                //errs() << "statementType: " << AG->getStatementType() << "\n";
                usedAGs.push_back(AG);
                //statementInsts.push_back(opInst);

                return true;
            }
            else{
                statementInsts.push_back(opInst);

                //errs() << "opNum: " << opNum << "\n";
                //errs() << "operandNum: " << operandNum << "\n";

                if(originalInst){
                    rootFound = findRootUser(rootList, usedAGs, statementInsts, opInst, false, opNum);
                }
                else{
                    rootFound = findRootUser(rootList, usedAGs, statementInsts, opInst, false, operandNum);
                }



            }
            //errs () << " ================= \n";
            //anotherInstFound = true;
        }


        //break;
        //if(isa<llvm::Instruction>inst->getOperand(opNum))
    }

    return rootFound;

}

//bool checkIfRoot(std::vector<accessGraph*> AGList, accessGraph* &AG, Instruction* inst){
bool checkIfRoot(std::vector<Instruction*> rootList, Instruction* inst){
    //errs() << "checking if root: " << *inst << "\n";
    for(unsigned i = 0; i < rootList.size(); i++){
        //errs() << "AGList Head: " << *AGList[i]->getHead()->inst << "\n";
        if(rootList[i] == inst){
                //usedAGs.push_back(AGList[i]);
                //AG = AGList[i];
                //errs() << "Root Found: " << *inst << "\n";
                return true;
        }
    }

    return false;
}

//------------------- ELGen --------------------------


