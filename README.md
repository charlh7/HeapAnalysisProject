--------------------------------
LLVM Heap Graph Analysis Project (LHGAP) Description
--------------------------------

The LHGAP project (for LLVM Heap Graph Analysis) that I have been working on
is an intraprocedural heap liveness analysis compiler pass using LLVM
C++ libraries.

The pass provides a graphical representation of live memory on the
heap using access graphs.

This implementation of live heap analysis is based on Khedker, Sanyal,
and Karkare (ACM TOPLAS, 2007)'s heap reference analysis algorithm.

This could potentially lessen the memory used to execute the function
by allowing for faster reuse of the freed memory.

The intraprocedural heap liveness analysis pass is mainly intended to
be used on programs that use data structures like linked lists and
graphs that create heap objects.

The benchmarks used to test the LHGAP pass were selected from the
SV-COMP (International Competition on Software Verification) benchmark
suite, specifically, the benchmarks from the mem-safety set category. 
The results can be found under benchmarkResults/memsafety/textOutput.

I also included a test mirroring example 4-19 from the "Data Flow 
Analysis: Theory and Practice" textbook by Khedker, Sanyal, and Karkare.
This test highlights LHGAP's ability to analyze more complex heap 
graphical structures.


--------------------------------
Installation Instructions
--------------------------------

First, make sure you have LLVM 10.0.1 and Clang installed. Next, you will 
navigate to the llvm/lib/Transforms/ folder within the llvm source directory.
 Copy the HeapDataFlow/ folder into this location.

Next, you will need to add HeapDataFlow to the CMakeLists.txt file located in 
that same directory.

Afterwards, re-build LLVM.

Now, you can navigate to a different directory where you want the test results to appear.
For example, if you downloaded the TestExample4-19 folder, you would navigate to this
directory. To perform the analysis on the test code, you can enter the following lines into
your terminal. "$builddir" should be replaced by your llvm build directory.

++++++++++++++++++++++++++++++++++++++++

clang -Xclang -disable-O0-optnone -O0 -emit-llvm -c  test4-19.c -o test4-19.bc

llvm-dis test4-19.bc

"$builddir"/bin/opt -load "$builddir"/lib/LLVMHeapDataFlow.so -HeapDataFlow test4-19.bc -o testResult.bc

++++++++++++++++++++++++++++++++++++++++

**"$builddir" should be replaced by your llvm build directory.

If you are running the example4-19 test, the results should look similar to the 
screenshot included in the TestExample4-19 directory.







