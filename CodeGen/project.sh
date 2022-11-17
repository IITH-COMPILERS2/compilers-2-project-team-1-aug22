./project < $1 2> dump.ll
llvm-as dump.ll -o dump.bc
lli dump.bc
llc dump.ll
g++ -no-pie dump.s -o codegen_output
