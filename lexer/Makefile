LEXER:
	lex lexer.l
	gcc -o lexer.out lex.yy.c -lfl
	mkdir outputs
	cd outputs
	./lexer.out 1
	./lexer.out 2
	./lexer.out 3
	./lexer.out 4
	./lexer.out 5
	
clean:
	rm *.yy.c ||:
	rm *.out ||:
	rm -rf outputs ||:
