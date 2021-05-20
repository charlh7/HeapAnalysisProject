# If we don't need RTTI or EH, there's no reason to export anything
# from the hello plugin.
if( NOT LLVM_REQUIRES_RTTI )
  if( NOT LLVM_REQUIRES_EH )
    set(LLVM_EXPORTED_SYMBOL_FILE ${CMAKE_CURRENT_SOURCE_DIR}/heapDataFlow.exports)
  endif()
endif()

if(WIN32 OR CYGWIN)
  set(LLVM_LINK_COMPONENTS Core Support)
endif()

add_llvm_library( LLVMHeapDataFlow MODULE BUILDTREE_ONLY
  heapDataFlow.cpp
  
  accessGraph.h
  accessGraph.cpp
  accessPath.h
  accessPath.cpp
  dataflow.h
  dataflow.cpp
  heapLivenessAnalysis.h
  heapLivenessAnalysis.cpp
  testAGOperations.h
  testAGOperations.cpp
  livenessOperations.h
  livenessOperations.cpp

  DEPENDS
  intrinsics_gen
  PLUGIN_TOOL
  opt
  )
