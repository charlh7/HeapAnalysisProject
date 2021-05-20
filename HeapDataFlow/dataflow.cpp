
#include "dataflow.h"

std::vector<Instruction*> getLDirect(std::vector<Instruction*> instList, std::vector<Instruction*> ptrList, Instruction* inst){

	std::vector<Instruction*> ptrUseList;
	for(unsigned j = 0; j < inst->getNumOperands(); j ++){
		auto *currentOp = inst->getOperand(j);
		llvm::Instruction* valInst = dyn_cast<llvm::Instruction>(currentOp);
		for(unsigned i = 0; i < ptrList.size(); i++){
			if(currentOp == ptrList[i]){
				ptrUseList.push_back(ptrList[i]);
			}
		}
	}
	return ptrUseList;
}

std::vector<Instruction*> getLKill(std::vector<Instruction*> instList, std::vector<Instruction*> ptrList, Instruction* inst){
	
}

std::vector<Instruction*> getLTransfer(std::vector<Instruction*> instList, std::vector<Instruction*> ptrList, Instruction* inst){


}

  // Add code for your dataflow abstraction here.

//Need to define Generated, Killed, In, and Out

//Generated: New Definitions in Current BasicBlock

//Get the total number of defined values
unsigned valueCount(Function &F, std::vector<Instruction*> &instVector){
	unsigned valTotal = 0;
	for(Function::iterator firstBB = F.begin(), lastBB = F.end(); firstBB != lastBB; firstBB++){
		BasicBlock* bb = &*firstBB;
		valTotal += addBBVals(bb, instVector);
	}	
	
	return valTotal;
}

unsigned addBBVals(BasicBlock* BB, std::vector<Instruction*> &instVector){
	unsigned valCount = 0;
	for(BasicBlock::iterator firstInst = BB->begin(), lastInst = BB->end(); firstInst != lastInst; firstInst++){
		Instruction* inst = &*firstInst;
		if (isa<PointerType>(inst->getType())) {
			valCount++;
			instVector.push_back(inst);
	  	}
		
	}
	return valCount;
}

void outputBitVector(BitVector &bVector){
	//unsigned bSize = bVector->size();
	std::cout << "{";
	for(unsigned i = 0; i < bVector.size(); i++){
		bool currBool = bVector.test(i);
		std::cout << currBool; 
		if(i + 1 < bVector.size()){
			std::cout << ", ";
		} 
		else{
			std::cout << "}\n";
		}
	}
}

void outputValuesFromBVector(BitVector &bVector, std::vector<Instruction*> &instVector){
	std::cout << "{";
	for(unsigned i = 0; i < bVector.size(); i++){
		if(bVector.test(i)){
			std::cout << getShortValueName(instVector[i]);
			//This snippet just makes the vector output look better
			if(i + 1 < bVector.size()){
				std::cout << ", ";
			} 
			else{
				std::cout << "}\n";
				break;
			}
		}
		//End of vector
		if(i + 1 >= bVector.size()){
			std::cout << "}\n";
		}
		
		
	}
}

std::string getShortValueName(Value * v) {
    if (v->getName().str().length() > 0) {
      return "%" + v->getName().str();
    }
    else if (isa<Instruction>(v)) {
      std::string s = "";
      raw_string_ostream * strm = new raw_string_ostream(s);
      v->print(*strm);
      std::string inst = strm->str();
      size_t idx1 = inst.find("%");
      size_t idx2 = inst.find(" ",idx1);
      if (idx1 != std::string::npos && idx2 != std::string::npos) {
	      return inst.substr(idx1,idx2-idx1);
      }
      else {
	      return "\"" + inst + "\"";
      }
    }
    else if (ConstantInt * cint = dyn_cast<ConstantInt>(v)) {
      std::string s = "";
      raw_string_ostream * strm = new raw_string_ostream(s);
      cint->getValue().print(*strm,true);
      return strm->str();
    }
    else {
      std::string s = "";
      raw_string_ostream * strm = new raw_string_ostream(s);
      v->print(*strm);
      std::string inst = strm->str();
      return "\"" + inst + "\"";
    }
  }


//---------------------------------------------------------------------------------------

BitVector getDef(BasicBlock* BB, std::vector<Instruction*> instVector, BitVector &bVector){
	BitVector newBVector = bVector;
	//errs() << "bVector size: " << bVector.size() << "\n";
	//errs() << "instVector size: " << instVector.size() << "\n";
	//By looking at the parent BB, I can determined if the instruction was generated there.
	for(unsigned i = 0; i < instVector.size(); i++){
		if(instVector[i]->getParent() == BB){ 
			//std::cout << "true";
			//errs() << "BP1a\n";
			newBVector.set(i);
			//errs() << "BP1b\n";
		}
	}
	
	return newBVector;
}

//---------------------------------------------------------------------------------------

BitVector getUse(BasicBlock* BB, std::vector<Instruction*> instVector, BitVector &bVector){
	BitVector newBVector = bVector;

	for(BasicBlock::iterator firstInst = BB->begin(), lastInst = BB->end(); firstInst != lastInst; firstInst++){
		Instruction* inst = &*firstInst;
		std::vector<Value*> operandVector = operandsToVector(inst);
		checkOperands(instVector, operandVector, newBVector);
	}
	return newBVector;
}

void checkOperands(std::vector<Instruction*> defVector, std::vector<Value*> opVector, BitVector &bVector){
	std::vector<int> useVector;
	
	for(unsigned i = 0; i < defVector.size(); i++){
		Value* instVal = dyn_cast<Value>(defVector[i]);
		for(unsigned j = 0; j < opVector.size(); j++){
			if(instVal == opVector[j]){
				useVector.push_back(i);
				bVector.set(i);
			}
		}
	}
}

std::vector<Value*> operandsToVector(Instruction *inst){
	std::vector<Value*> opVector;
	//Add each operand to a vector
	for(unsigned int i = 0; i < inst->getNumOperands(); i++){
		Value* currentOperand = inst->getOperand(i);
		if( isa<PointerType>(inst->getType()) ){
			opVector.push_back(currentOperand);
		}
	}
	return opVector;
}

//---------------------------------------------------------------------------------------

BBInfo::BBInfo(BitVector emptyVector){
	In = emptyVector;
	Out = emptyVector;
}

void BBInfo::getOut(){
	for(unsigned i = 0; i < successors.size(); i++){
		Out |= successors[i]->In;
		//std::cout << successors[i]->thisBlock->getName().str() << "\n";
	} 
}

void BBInfo::getIn(){
	BitVector UseUnion = Use;
	BitVector tempVector = Out;
	for(unsigned i = 0; i<Def.size(); i++){
		if(Def.test(i) == true){
			tempVector.reset(i);
		}
		
	}
	UseUnion |= tempVector;
	In = UseUnion;
}

void addSuccessors(BBInfo* currentBB, std::vector<BBInfo*> BBInfoList){
	//Check each BB already in the list to see if the currentBB's successors are in the list
	for(succ_iterator fSucc = succ_begin(currentBB->thisBlock), lSucc = succ_end(currentBB->thisBlock); fSucc != lSucc; fSucc++){
		BasicBlock* currentSuccessor = *fSucc;
		for(unsigned i = 0; i < BBInfoList.size(); i++){
			if(currentSuccessor == BBInfoList[i]->thisBlock){
				currentBB->successors.push_back(BBInfoList[i]);
			}
		}		
	}
	/*std::cout << currentBB.thisBlock->getName().str() ;
	std::cout << "Successors: \n";
	for(unsigned i = 0; i < currentBB.successors.size(); i++){
		std::cout << currentBB.successors[i]->thisBlock->getName().str() << "\n";
	}*/
	
}
