//++ Insert Header Here ++//

#include "llvm/ADT/Statistic.h"
#include "llvm/IR/Function.h"
#include "llvm/Pass.h"
#include "llvm/Support/raw_ostream.h"
#include "llvm/Passes/StandardInstrumentations.h"


#include "heapLivenessAnalysis.h"
#include "testAGOperations.h"



namespace {
  // Hello - The first implementation, without getAnalysisUsage.
  struct HeapDataFlow : public FunctionPass {
    static char ID; // Pass identification, replacement for typeid
    HeapDataFlow() : FunctionPass(ID) {}

    bool runOnFunction(Function &F) override {

      errs() << "\n ------- Heap Liveness Analysis Pass ------- \n";

      errs() << "Current Function: " << F.getName() << "\n";

      std::vector<Instruction*> ptrList;
      std::vector<Instruction*> rootList;
      std::vector<accessGraph*> AGList;
      std::vector<Instruction*> instList;

//      if(F.getName() == "testCode"){
        //errs() << "This function <<<\n";


//          errs() << ">>> Checkpoint #1: Find Pointers\n";
          fillInstList(F, ptrList, instList);

          //errs() << "Inst List:\n";
          //outputList(instList);

          //outputList(ptrList);

//          errs() << ">>> Checkpoint #2: Create Access Graphs\n";


          createAccessGraphs(F, ptrList, AGList);

          for(unsigned i = 0; i < AGList.size(); i++){
            rootList.push_back(AGList[i]->getHead()->inst);
          }
          //errs() << "Root List: \n";
          //outputList(rootList);

          //outputRoots(AGList);

          //outputAccessGraphs(AGList);

//          errs() << ">>> Checkpoint #3: Perform Liveness Analysis on Access Graphs\n";
          doAGLivenessAnalysis(F, AGList, rootList, instList);




          //accessGraph*

//      }


      //if(F.getName() == "testCode"){
        //errs() << "This function <<<\n";

    /*
      errs() << ">>> Checkpoint #1: Find Pointers\n";
      fillInstList(F, ptrList, instList);

      //errs() << "Inst List:\n";
      //outputList(instList);

      //outputList(ptrList);

      errs() << ">>> Checkpoint #2: Create Access Graphs\n";
      createAccessGraphs(F, ptrList, AGList);
      outputRoots(AGList);

      //outputAccessGraphs(AGList);

      errs() << ">>> Checkpoint #3: Perform Liveness Analysis on Access Graphs\n";
      doAGLivenessAnalysis(F, AGList, ptrList, instList);

          //accessGraph*
    */


      //}


	  //outputList(ptrList);
	  //outputList(instList);

	  /*testUnion(AGList);
	  testPathRemoval(AGList);
	  testFactorization(AGList);
	  testExtension(AGList);*/

	  //errs() << "Access Graphs after Analysis:\n";

	  /*if(F.getName() == "test_fun"){
        errs() << ">>> Checkpoint #1: Find Pointers\n";
          fillInstList(F, ptrList, instList);

          //errs() << "Inst List:\n";
          //outputList(instList);

          //outputList(ptrList);

          errs() << ">>> Checkpoint #2: Create Access Graphs\n";
          createAccessGraphs(F, ptrList, AGList);
          outputRoots(AGList);

          //outputAccessGraphs(AGList);

          errs() << ">>> Checkpoint #3: Perform Liveness Analysis on Access Graphs\n";
          doAGLivenessAnalysis(F, AGList, ptrList, instList);



	  }*/



	  errs() << "***********************************************************\n";

      return false;
    }

   void fillInstList(Function &F,std::vector<Instruction*> &pointerList, std::vector<Instruction*> &instList){

   		Function::BasicBlockListType& bbList = F.getBasicBlockList();
   		for(Function::BasicBlockListType::iterator firstBB = bbList.begin(), lastBB = bbList.end(); firstBB != lastBB; firstBB++){
   			BasicBlock* bb = &*firstBB;
			for (BasicBlock::iterator i = bb->begin(); i != bb->end(); i++){
   				Instruction* inst = &*i;

   				if( isa<PointerType>(inst->getType()) ){
   					pointerList.push_back(inst);
   				}
   				instList.push_back(inst);
   			}
   		}
   }


    void outputList(std::vector<Instruction*> instList){
		for( unsigned i = 0; i < instList.size(); i++){
			errs() << *instList[i] << "\n";
		}

	}

	void outputRoots(std::vector<accessGraph*> AGList){
        errs() << "\n ---- Roots ---- \n";
        for( unsigned i = 0; i < AGList.size(); i++){
			errs() << *AGList[i]->getHead()->inst << "\n";
		}
	}

	void outputAccessGraphs(std::vector<accessGraph*> AGList){
		errs() << "------- AGList Contents -------\n";
		errs() << "num root nodes: " << AGList.size() << "\n\n";
		for( unsigned i = 0; i < AGList.size(); i++){
			AGList[i]->outputGraph();
		}
	}


  };
}

char HeapDataFlow::ID = 0;
static RegisterPass<HeapDataFlow> X("HeapDataFlow", "Heap Data Flow Pass");

