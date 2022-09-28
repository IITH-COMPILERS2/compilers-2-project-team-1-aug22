Parser:
	flex -o project.lex.c project.l
	bison -o project.tab.c -vd project.y
	gcc -o project project.lex.c project.tab.c -lm -ll
	clear
	./project < testCases/test1.cop
	./project < testCases/test2.cop
	
clean:
	rm *.yy.c ||:
	rm *.out ||:
	rm -rf outputs ||:
	rm *.tab.c ||:
	rm *.tab.h ||:
	rm *.output ||:
	rm project ||:
	rm *.lex.c ||:
