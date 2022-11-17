# # flex_file := project.l
# # bison_file := project.y
# TEST_OBJS := test1.cop test2.cop test3.cop

FLAGS=-Wno-deprecated -w -g -std=c++14
CFLAGS=-lfl `llvm-config --cppflags --cxxflags mcjit native --ldflags --libs core` -ltinfo -lpthread -ldl

Tests: Semantic
	@rm -rf SymbolTables_ASTs 
	@mkdir SymbolTables_ASTs
	@./project < testCases/test2.cop > SymbolTables_ASTs/2.txt
	@./project < testCases/test3.cop > SymbolTables_ASTs/3.txt
	@./project < testCases/test1.cop > SymbolTables_ASTs/1.txt

Semantic:
	@rm -rf util_files
	@mkdir util_files
	@flex -o util_files/project.lex.cpp project.l
	@bison -o util_files/project.tab.cpp -vd project.y
	@g++ $(FLAGS) util_files/project.lex.cpp util_files/project.tab.cpp -lm -ll $(CFLAGS) -o project

clean:
	@rm *.yy.c ||:
	@rm *.out ||:
	@rm *.txt ||:
	@rm -rf SymbolTables_ASTs ||:
	@rm *.tab.* ||:
	@rm *.output ||:
	@rm project ||:
	@rm *.lex.* ||:
	@rm -rf util_files ||:
	@rm *.s ||:
	@rm *.bc ||:
	@rm *.ll ||:
