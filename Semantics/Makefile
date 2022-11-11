# # flex_file := project.l
# # bison_file := project.y
# TEST_OBJS := test1.cop test2.cop test3.cop

Tests: Semantic
	@rm -rf SymbolTables_ASTs 
	@mkdir SymbolTables_ASTs
	@./util_files/project < testCases/test1.cop > SymbolTables_ASTs/1.txt
	@./util_files/project < testCases/test2.cop > SymbolTables_ASTs/2.txt
	@./util_files/project < testCases/test3.cop > SymbolTables_ASTs/3.txt

Semantic:
	@rm -rf util_files
	@mkdir util_files
	@flex -o util_files/project.lex.cpp project.l
	@bison -o util_files/project.tab.cpp -vd project.y
	@g++ -o util_files/project util_files/project.lex.cpp util_files/project.tab.cpp -lm -ll

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
