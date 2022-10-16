Semantic:
	flex -o project.lex.cpp project.l
	bison -o project.tab.cpp -vd project.y
	g++ -o project project.lex.cpp project.tab.cpp -lm -ll
	clear
	rm -rf SymbolTables_ASTs 
	mkdir SymbolTables_ASTs
	./project < testCases/test1.cop > SymbolTables_ASTs/1.txt
	./project < testCases/test2.cop > SymbolTables_ASTs/2.txt
	./project < testCases/test3.cop > SymbolTables_ASTs/3.txt

clean:
	rm *.yy.c ||:
	rm *.out ||:
	rm *.txt ||:
	rm -rf SymbolTables_ASTs ||:
	rm *.tab.* ||:
	rm *.output ||:
	rm project ||:
	rm *.lex.* ||:
