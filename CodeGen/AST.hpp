#ifndef AST
#define AST

#include <llvm/IR/Module.h>
#include <llvm/IR/Function.h>
#include <llvm/IR/Type.h>
#include <llvm/IR/DerivedTypes.h>
#include <llvm/IR/LLVMContext.h>
#include <llvm/Target/TargetMachine.h>
#include <llvm/IR/PassManager.h>
#include <llvm/IR/Instructions.h>
#include <llvm/IR/CallingConv.h>
#include <llvm/IR/Verifier.h>
#include <llvm/IR/IRBuilder.h>
#include <llvm/Support/TargetSelect.h>
#include <llvm/ExecutionEngine/GenericValue.h>
#include <llvm/ExecutionEngine/MCJIT.h>
#include <llvm/Support/raw_ostream.h>
#include "SymbolTable.hpp"
#include "OldAst.hpp"

using namespace llvm;

class AstNode {
	virtual Value *codegen(){}
};

class Node {
	public:
		int num;
		char* val;
		class Declaration* decl;
		class Function_Def* func_def;
		class Start* start;
};

// union Node {
// 	int num;
// 	char *val;
// 	class Variable *var;
// 	class Variables *vars;
// 	class FieldDeclaration *field;
// 	class FieldDeclarations *fields;
// 	class Location *loc;
// 	class Expression *expr;
// 	class Assignment *assignstmt;
// 	class ForStatement *forstmt;
// 	class WhileStatement *whilestmt;
// 	class IfElseStatement *ifelsestmt;
// 	class GotoStatement *gotostmt;
// 	class Statements *stmts;
// 	class Block *block;
// 	class Print *print;
// 	class ReadLine *read;
// 	class Start *start;
// 	Node() {
// 		start = NULL;
// 		num = 0;
// 		val= NULL;
// 		fields = NULL;
// 		vars = NULL;
// 		stmts = NULL;
// 	}
// 	~Node(){};
// };

class Declaration: public AstNode {
	public:
		Declaration(){
			cout << "declr";
		}
		//  traverse over tree
		void traverse(){
			cout << "declr_trav\n";
		};
		//	interpret main
		int interpret(){};
		//	generate code
		Value *codegen(){
			cout << "hai\n";
		};
};

class Function_Def: public AstNode {
	public:
		Function_Def(){
			cout << "fun\n";
		}
		//  traverse over tree
		void traverse(){
			cout << "fun_trav\n";
		};
		//	interpret main
		int interpret(){};
		//	generate code
		Value *codegen(){
			cout << "hai\n";
		};
};

class Start:public AstNode {
	private:
		// // all declarations --> { declaration block }
		// class FieldDeclarations *field_declarations;
		// // all statements --> { code block }
		// class Statements *statements;
		class Node* n;
	public:
		Start(Node* nodein){
			n = nodein;
		}
		//  traverse over tree
		void traverse(){
			n->decl->traverse();
			n->func_def->traverse();
		};
		//	interpret main
		int interpret(){};
		//	generate code
		Value *codegen(){
			cout << "hai\n";
		};
};


#endif