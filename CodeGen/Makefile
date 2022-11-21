# # flex_file := project.l
# # bison_file := project.y
# TEST_OBJS := test1.cop test2.cop test3.cop

FLAGS=-Wno-deprecated -w -g -std=c++14
CFLAGS=-lfl `llvm-config --cppflags --cxxflags mcjit native --ldflags --libs core` -ltinfo -lpthread -ldl

Tests: Semantic
	@rm -rf SymbolTables_ASTs
	@rm -rf llvmOutputs
	@rm -rf AssemblyFiles
	@rm -rf llvmObjects
	@rm -rf gccObjects
	@mkdir SymbolTables_ASTs
	@mkdir llvmOutputs
	@mkdir AssemblyFiles
	@mkdir llvmObjects
	@mkdir gccObjects
	@./util_files/project < testCases/test2.cop > SymbolTables_ASTs/2.txt 2> llvmOutputs/2.ll
	@./util_files/project < testCases/test3.cop > SymbolTables_ASTs/3.txt 2> llvmOutputs/3.ll
	@./util_files/project < testCases/test1.cop > SymbolTables_ASTs/1.txt 2> llvmOutputs/1.ll
	@llc -o AssemblyFiles/1.s llvmOutputs/1.ll
	@llc -o AssemblyFiles/2.s llvmOutputs/2.ll
	@llc -o AssemblyFiles/3.s llvmOutputs/3.ll
	@llvm-as -o llvmObjects/1.bc llvmOutputs/1.ll
	@llvm-as -o llvmObjects/2.bc llvmOutputs/2.ll
	@llvm-as -o llvmObjects/3.bc llvmOutputs/3.ll
	@g++ -no-pie AssemblyFiles/1.s -o gccObjects/1.out
	@g++ -no-pie AssemblyFiles/2.s -o gccObjects/2.out
	@g++ -no-pie AssemblyFiles/3.s -o gccObjects/3.out
	

Semantic:
	@rm -rf util_files
	@mkdir util_files
	@flex -o util_files/project.lex.cpp project.l
	@bison -o util_files/project.tab.cpp -vd project.y
	@g++ $(FLAGS) util_files/project.lex.cpp util_files/project.tab.cpp -lm -ll $(CFLAGS) -o util_files/project

clean:
	@rm *.yy.c ||:
	@rm *.out ||:
	@rm *.txt ||:
	@rm -rf SymbolTables_ASTs ||:
	@rm -rf llvmOutputs ||:
	@rm -rf AssemblyFiles ||:
	@rm -rf llvmObjects ||:
	@rm -rf gccObjects ||:
	@rm *.tab.* ||:
	@rm *.output ||:
	@rm project ||:
	@rm *.lex.* ||:
	@rm -rf util_files ||:
	@rm *.s ||:
	@rm *.bc ||:
	@rm *.ll ||:
