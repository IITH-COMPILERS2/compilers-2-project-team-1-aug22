Parser:
	flex -o project.lex.cpp project.l
	bison -o project.tab.cpp -vd project.y
	g++ -o project project.lex.cpp project.tab.cpp -lm -ll
	clear
	./project < testCases/test1.cop
	./project < testCases/test2.cop
	./project < testCases/test3.cop
	
clean:
	rm *.yy.c ||:
	rm *.out ||:
	rm -rf outputs ||:
	rm *.tab.* ||:
	rm *.output ||:
	rm project ||:
	rm *.lex.* ||:
