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
#define TBS print_tabs()

using namespace llvm;

int tabs = 0;
const int width = 4;
Function *fooFunc;
static LLVMContext Context;
static IRBuilder<> Builder(Context);
static Module *ModuleOb = new Module("CoPro", Context);

Function *createFunc(IRBuilder <> &Builder, string Name) {
	FunctionType *functype = FunctionType::get(Builder.getInt32Ty(), false);
	Function *foofunc = Function::Create(
		functype, Function::ExternalLinkage, Name, ModuleOb);
	return foofunc;
}

BasicBlock *createBB(Function *foofunc, string Name) {
	return BasicBlock::Create(Context, Name, foofunc);
}

void BasicBuildLLVMMain(Module * TheModule)
{
    fooFunc = createFunc(Builder,"main");
    BasicBlock  *entry = createBB(fooFunc,"entry");
    Builder.SetInsertPoint(entry);
}

void BasicBuildLLVMMain(Module * TheModule, string name)
{
    fooFunc = createFunc(Builder,name);
    BasicBlock  *entry = createBB(fooFunc,"entry");
    Builder.SetInsertPoint(entry);
}

void print_tabs() {
	for (int i = 0; i < tabs; i++)
		for (int j = 0; j < width; j++)
			cout<<" ";
}

class AstNode {
	virtual Value *codegen(){}
};
class Node {

	public:
		int num;
		string val;
		class Location* loc;
		class Variable* var;
		class Variables* vars;
		class Statement* stmt;
		class Conditional_expr* cond_expr;
		class Assignment_expr* ass_expr;
		class Declaration* decl;
		class LoopStatement* loopstmt;
		class IfElseStatement* ifelsestmt;
		class Print* print;
		class Read* read;
		class Statements* stmts;
		class Block* block;
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
struct six_tuple{
	int a, h, b, g, f, c;
};

class Location: public AstNode {
	private:
		string identifier;
		string type;
		int int_val;
		double dob_val;
		string string_val;
		struct six_tuple tup_val;
		bool flag;
	public:
		Location(int value) {
			this->type = string("int");
			this->int_val = value;
		}
		Location(double value) {
			this->type = string("double");
			this->dob_val = value;
		}
		Location(string value, bool flag) {
			if(flag){
				this->type = string("string");
				this->string_val = value;
			} else{
				this->type = string("variable");
				this->identifier = value;
			}
		}
		Location(struct six_tuple value) {
			this->type = string("tuple");
			this->tup_val = value;
		}
		string getType(){
			return this->type;
		}
		string getIdentifier(){
			return this->identifier;
		}
		void traverse(){
			TBS;
			cout << "</Location ";
			if(type == "int")
				cout << int_val << ">\n";
			else if(type == "double")
				cout << dob_val << ">\n";
			else if(type == "string")
				cout << string_val << ">\n";
			else if(type == "variable")
				cout << identifier << ">\n";
		}

		void interpret();
		Value *codegen(){
			if(type != "variable"){
				Value *v = ConstantInt::get(Context, APInt(32, int_val));
				return v;
			}
			else{
				Value* v = ModuleOb->getNamedGlobal(identifier);
				return v;
			}
		}
};

class Variables: public AstNode {
	private:
		vector<Variable*> variables;
	public:
		Variables(){}

		void store(class Variable* variable){
			this->variables.push_back(variable);
		}

		vector<class Variable*> getVariables(){
			return this->variables;
		}
};

class Statement: public AstNode {
	public:
		string stmt_type;
	public:
		Statement(){}
		void setType(string stmt_type){
			this->stmt_type = stmt_type;
		}
		virtual string getType(){
			return this->stmt_type;
		}
		virtual void traverse(){}
		int interpret();
		virtual Value *codegen(){}
};

class Conditional_expr: public Statement {
	private:
		class Conditional_expr* lhs;
		string operand;
		class Conditional_expr* rhs;
		class Location* loc;
	public:
		Conditional_expr(class Conditional_expr* lhs, string operand, class Conditional_expr* rhs){
			this->stmt_type = "Cond";
			this->lhs = lhs;
			this->operand = operand;
			this->rhs = rhs;
		}
		Conditional_expr(class Location* loc){
			this->stmt_type = "Unary_Cond";
			this->loc = loc;
		}
		string getType(){
			return this->stmt_type;
		}
		Location* getLocation(){
			return this->loc;
		}
		void traverse(){
			TBS;
			cout << "<Conditional>\n";
			tabs++;
			if(lhs && rhs){
				lhs->traverse();
				tabs++;
				TBS;
				cout << "Operand: " << this->operand << "\n";
				tabs--;
				rhs->traverse();
			}
			if(loc){
				loc->traverse();
			}
			tabs--;
			TBS;
			cout << "</Conditional>\n";
		}
		void interpret();
		Value *codegen(){
			if (this->getType().compare("Unary_Cond") == 0) {
				Value *v = loc->codegen();
				if(loc->getType().compare("variable") == 0)
					v = Builder.CreateLoad(v);
				return v;
			}
			if (this->getType().compare("Cond") == 0) {
				Value *left = lhs->codegen();
				Value *right = rhs->codegen();
				// if (left == 0) 
				// 	return reportError::ErrorV("Error in left operand of " + operand);
				// if (right == 0)
				// 	return reportError::ErrorV("Error in right operand of " + operand);
				Value *v;
				if (operand.compare("+") == 0)
					v = Builder.CreateAdd(left, right, "addtmp");
				else if (operand.compare("-") == 0)
					v = Builder.CreateSub(left, right, "subtmp");
				else if (operand.compare("*") == 0)
					v = Builder.CreateMul(left, right, "multmp");
				else if (operand.compare("/") == 0)
					v = Builder.CreateUDiv(left, right, "divtmp");
				else if (operand.compare("%") == 0)
					v = Builder.CreateURem(left, right, "modtmp");
				else if (operand.compare("||") == 0)
					v = Builder.CreateOr(left, right, "ortmp");
				else if (operand.compare("&&") == 0)
					v = Builder.CreateAnd(left, right, "andtmp");	
				else if (operand.compare("<") == 0)
					v = Builder.CreateICmpULT(left, right, "ltcomparetmp");
				else if (operand.compare(">") == 0)
					v = Builder.CreateICmpUGT(left, right, "gtcomparetmp");
				else if (operand.compare("<=") == 0)
					v = Builder.CreateICmpULE(left, right, "ltcompareequaltmp");
				else if (operand.compare(">=") == 0)
					v = Builder.CreateICmpUGE(left, right, "gtcompareequaltmp");
				else if (operand.compare("==") == 0)
					v = Builder.CreateICmpEQ(left, right, "equalcomparetmp");
				else if (operand.compare("!=") == 0)
					v = Builder.CreateICmpNE(left, right, "notequalcomparetmp");
				return v;
			}
		}
};

class Assignment_expr: public Statement {
	private:
		class Location* loc;
		string operand;
		class Conditional_expr* cond_expr;
	public:
		Assignment_expr(class Location* loc, string operand, class Conditional_expr* cond_expr){
			this->stmt_type = "Ass";
			this->loc = loc;
			this->operand = operand;
			this->cond_expr = cond_expr;
		}
		Assignment_expr(class Conditional_expr* cond_expr){
			this->stmt_type = "Ass";
			this->loc = NULL;
			this->cond_expr = cond_expr;
		}
		string getType(){
			return this->stmt_type;
		}
		void traverse(){
			TBS;
			cout << "<Assignment>\n";
			tabs++;
			if(loc)
				this->loc->traverse();
			this->cond_expr->traverse();
			tabs--;
			TBS;
			cout << "</Assignment>\n";
		}
		void interpret();
		Value *codegen(){
			if(loc){
				Value* lhs = loc->codegen();
				Value *rhs = cond_expr->codegen();
				Value *v = Builder.CreateStore(rhs, lhs);
				return v;
				if(operand == "+="){
					Value* newrhs = Builder.CreateAdd(lhs, rhs, "AddAss");
					Value *v = Builder.CreateStore(newrhs, lhs);
					return v;
				}
				else if(operand == "*="){
					Value* newrhs = Builder.CreateMul(lhs, rhs, "MulAss");
					Value *v = Builder.CreateStore(newrhs, lhs);
					return v;
				}
				else{
					Value *v = Builder.CreateStore(rhs, lhs);
					return v;
				}
			}
			else{
				Value *v = cond_expr->codegen();
				return v;
			}
		}
};

class Variable: public AstNode {
	private:
		string identifier;
		string type;
		bool isAss;
		Location* loc;
		class Assignment_expr* ass_expr;
	public:
		Variable(string id, string ty){
			this->identifier = id;
			this->type = ty;
			this->ass_expr = NULL;
			this->isAss = 0;
		}
		Variable(string id, string ty, class Assignment_expr* ass_expr){
			this->identifier = id;
			this->type = ty;
			this->ass_expr = ass_expr;
			this->isAss = 1;
			this->loc = new Location(this->identifier, 0);
		}
		string getType(){
			return this->type;
		}
		string getIdentifier(){
			return this->identifier;
		}
		void traverse(){
			TBS;
			cout << "<Variable declaration>\n" ;
			tabs++;
			TBS;
			cout << "Identifier: " << this->identifier << "\n";
			if(this->ass_expr){
				this->ass_expr->traverse();
			}
			tabs--;
			TBS;
			cout << "</Variable declaration>\n" ;
		}
		void interpret();
		Value *codegen(){
			if(isAss){
				Value* lhs = loc->codegen();
				Value* rhs = ass_expr->codegen();
				Value* v = Builder.CreateStore(rhs, lhs);
				return v;
			}
			else{
				Value* v = ModuleOb->getNamedGlobal(this->identifier);
				//Value *v = ConstantInt::get(Context, APInt(32, 0));
				return v;
			}
		}
};


class Declaration: public Statement {
	private:
		string type;
		vector<Variable*> variables;
	public:
		Declaration(string type, class Variables* vars){
			this->stmt_type = "Decl";
			this->type = type;
			this->variables = vars->getVariables();
		}
		string getType(){
			return this->stmt_type;
		}
		string getDataType() {
			return this->type;
		}
		vector<class Variable*> getVariables(){
			return this->variables;
		}
		void traverse(){
			TBS;
			cout << "<Declaration DataType: " << this->type << ">\n";
			tabs++;
			for(auto i : variables){
				i->traverse();
			}
			tabs--;
			TBS;
			cout << "</Declaration>\n";
		};
		int interpret();
		Value *codegen(){
			for (int i = 0; i < variables.size(); i++) {
				class Variable *variable = variables[i];
				ModuleOb->getOrInsertGlobal(variable->getIdentifier(), Builder.getInt32Ty());
				GlobalVariable *gvar = ModuleOb->getNamedGlobal(variable->getIdentifier());
				gvar->setLinkage(GlobalValue::CommonLinkage);
				gvar->setAlignment(4);
				ConstantInt* const_int_val = ConstantInt::get(Context, APInt(32,0));
				gvar->setInitializer(const_int_val);
				variables[i]->codegen();
			}
			Value *v = ConstantInt::get(Context, APInt(32, 1));
			return v;
		}
};

class Statements:public AstNode {
	private:
		std::vector<class Statement*> statements;
	public:
		Statements(){}
		void store(class Statement* stmt){
			this->statements.push_back(stmt);
		}
		std::vector<class Statement*> getStatements(){
			return this->statements;
		}
};


class Block:public AstNode {
	private:
		std::vector<class Statement*> block_statements;
	public:
		Block(){}
		Block(class Statements* statements){
			this->block_statements = statements->getStatements();
		}
		std::vector<class Statement*> getBlkStatements(){
			return this->block_statements;
		}
		void traverse(){
			TBS;
			cout << "<Block>\n";
			tabs++;
			//cout << block_statements.size() << "\n";
			for(auto i : block_statements){
				// TBS;
				// cout << i->getType() << "\n";
				i->traverse();
			}
			tabs--;
			TBS;
			cout << "</Block>\n";
		}
		void interpret();
		Value *codegen(){
			Value *v = ConstantInt::get(Context, APInt(32, 0));
			for (int i = 0; i < this->block_statements.size(); i++)
				this->block_statements[i]->codegen();
			return v;
		}
};

class LoopStatement:public Statement {
	private:
		class Conditional_expr* cond_expr;
		class Block* loop_block;
	public:
		LoopStatement(class Conditional_expr* cond_expr, class Block* block){
			this->stmt_type = "loop";
			this->cond_expr = cond_expr;
			this->loop_block = block;
		}
		string getType(){
			return this->stmt_type;
		}
		void traverse(){
			TBS;
			cout << "<Loop>\n";
			tabs++;
			this->cond_expr->traverse();
			this->loop_block->traverse();
			tabs--;
			TBS;
			cout << "</Loop>\n";
		}
		int interpret();
		Value *codegen(){
			Value* v = ConstantInt::get(Context, APInt(32,0));
			BasicBlock *loop = createBB(fooFunc, "loop");
			BasicBlock *after = createBB(fooFunc, "afterloop");
			Value *cond_gen = cond_expr->codegen();
			//cond_gen = Builder.CreateICmpNE(v, ConstantInt::get(Type::getInt32Ty(Context), 0, true));
			Value *loop_condition = Builder.CreateICmpNE(cond_gen, Builder.getInt1(0),"whilecon");
			Builder.CreateCondBr(loop_condition, loop, after);
			Builder.SetInsertPoint(loop);
			Value *value = loop_block->codegen();
			cond_gen = cond_expr->codegen();
			Value *after_loop_condition = Builder.CreateICmpNE(cond_gen, Builder.getInt1(0),"whilecon");
			Builder.CreateCondBr(after_loop_condition, loop, after);
			Builder.SetInsertPoint(after);
			return value;
		}
};

class IfElseStatement:public Statement {
	private:
		class Conditional_expr *cond_expr;
		class Block *if_block;
		class Block *else_block;
		string type;
	public:
		IfElseStatement(class Conditional_expr* cond_expr, class Block* block){
			this->stmt_type = string("if");
			this->type = string("if");
			this->cond_expr = cond_expr;
			this->if_block = block;
		}
		IfElseStatement(class Conditional_expr* cond_expr, class Block* if_blk, class Block* el_blk){
			this->stmt_type = string("ifelse");
			this->type = string("ifelse");
			this->cond_expr = cond_expr;
			this->if_block = if_blk;
			this->else_block = el_blk;
		}
		string getType(){
			return this->stmt_type;
		}
		void traverse(){
			TBS;
			cout << "<IfElse>\n";
			tabs++;
			this->cond_expr->traverse();
			if(type == "if"){
				this->if_block->traverse();
			}
			else if(type == "ifelse"){
				this->if_block->traverse();
				this->else_block->traverse();
			}
			tabs--;
			TBS;
			cout << "</IfElse>\n";
		}
		int interpret();
		Value *codegen(){
			Value* v = ConstantInt::get(Context, APInt(32,0));
			Value* condition = this->cond_expr->codegen();
			BasicBlock* ifblock = createBB(fooFunc,"if");
			BasicBlock* elseblock = createBB(fooFunc,"else");
			BasicBlock* mergeblock = createBB(fooFunc,"ifmerge");
			//condition = Builder.CreateICmpNE(v, ConstantInt::get(Type::getInt32Ty(Context), 0, true));
			Builder.CreateCondBr(condition, ifblock, elseblock);
			Builder.SetInsertPoint(ifblock);
			Value *ifval  = if_block->codegen();
			Builder.CreateBr(mergeblock);
			ifblock = Builder.GetInsertBlock();
			Builder.SetInsertPoint(elseblock);
			Value* elseval;
			if (this->type.compare("ifelse") == 0) {
				elseval = else_block->codegen();
			}
			Builder.CreateBr(mergeblock);
			elseblock = Builder.GetInsertBlock();
			Builder.SetInsertPoint(mergeblock);
			return v;
		}
};

class Print:public Statement {
	private:
		string text;
		class Location *value;
		string type;
	public:
		Print(class Location * value){
			this->stmt_type = string("print");
			this->type = string("loc");
			this->value = value;
		}
		Print(string text){
			this->stmt_type = string("print");
			this->type = string("str");
			this->text = text;
		}
		void traverse(){}
		int interpret();
		Value *codegen(){
			Value* v;
			vector <Value *> args;
			vector <Type *> type;
			string s;
			if (this->type.compare("str")==0) {
				s = text+"\n";
				Value* x = Builder.CreateGlobalStringPtr(s);
				args.push_back(x);
				type.push_back(x->getType());
			}
			else if (this->type.compare("loc")==0) {
				s = "%d\n";
				Value* x = Builder.CreateGlobalStringPtr(s);
				args.push_back(x);
				type.push_back(x->getType());
				v = value->codegen();
				v = Builder.CreateLoad(v);
				// if (v == 0) {
				// 	errors++;
				// 	reportError::ErrorV("Unknown Variable in PRINT");
				// }
				args.push_back(v);
				type.push_back(v->getType());
			}
			llvm::ArrayRef <Type *> typeargs(type);
			llvm::ArrayRef <Value *> refargs(args);
			llvm::FunctionType *FType = FunctionType::get(Type::getInt32Ty(Context), typeargs, false);
			auto printfunc = ModuleOb->getOrInsertFunction("printf", FType);
			return Builder.CreateCall(printfunc, refargs);
		}
};

class Read:public Statement {
	private:
		class Location *value;
	public:
		Read(class Location * value){
			this->stmt_type = string("read");
			this->value = value;
		}
		void traverse(){}
		int interpret();
		Value *codegen(){
			Value* v;
			vector <Value *> args;
			vector <Type *> type;
			string s = "%d";
			Value* x = Builder.CreateGlobalStringPtr(s);
			args.push_back(x);
			type.push_back(x->getType());
			v = value->codegen();
			args.push_back(v);
			type.push_back(v->getType());
			llvm::ArrayRef <Type *> typeargs(type);
			llvm::ArrayRef <Value *> refargs(args);
			llvm::FunctionType *FType = FunctionType::get(Type::getInt32Ty(Context), typeargs, false);
			auto readfunc = ModuleOb->getOrInsertFunction("scanf", FType);
			return Builder.CreateCall(readfunc,refargs);
		}
};

class Function_Def: public AstNode {
	private:
		string name;
		vector<Variable*> parameters;
		string returnType;
		class Block* block;
		bool isparams;
	public:
		Function_Def(string name, vector<Variable*> parameters, string returnType, class Block* block){
			this->name = name;
			this->parameters = parameters;
			this->returnType = returnType;
			this->block = block;
			this->isparams = 1;
		}
		Function_Def(string name, string returnType, class Block* block){
			this->name = name;
			this->returnType = returnType;
			this->block = block;
			this->isparams = 0;
		}
		void traverse(){
			TBS;
			cout << "<Function>\n";
			TBS;
			cout << "Name: " << this->name << "\n";
			if(isparams){
				TBS;
				cout << "Parameters: ";
				for(auto i : parameters){
					cout << i->getType() << " ";
				}
				cout << "\n";
			}
			TBS;
			cout << "Return Type: " << this->returnType << "\n";
			tabs++;
			this->block->traverse();
			tabs--;
			TBS;
			cout << "</Function>\n";
		};
		int interpret();
		Value *codegen(){
			return this->block->codegen();
		}
};

class Start:public AstNode {
	private:
		class vector<Node*> nodes;
	public:
		Start(){}
		void store(Node* node){
			this->nodes.push_back(node);
		}
		void traverse(){
			cout << "-----------------AST------------------\n";
			TBS;
			cout << "<Start>\n";
			tabs++;
			for(auto i : nodes){
				//TBS;
				//cout << i->val << "\n";
				// cout << "aa\n";
				if(i){
					if(i->decl)
						i->decl->traverse();
					else if(i->func_def)
						i->func_def->traverse();
				}
			}
			tabs--;
			TBS;
			cout << "</Start>\n";
		};
		int interpret();
		Value *codegen(){
			cout<<"------Code Generation------"<<endl;
			Value *v = ConstantInt::get(Context, APInt(32, 0));
			BasicBuildLLVMMain(ModuleOb);
			//field_declarations->codegen();
			//statements->codegen();
			//cout << nodes.size() << "\n";
			for(auto i : nodes){
				if(i){
					if(i->decl)
						i->decl->codegen();
					if(i->func_def)
						i->func_def->codegen();
				}
			}
			Builder.CreateRet(Builder.getInt32(0));
			//if (errors == 0)
			ModuleOb->print(llvm::errs(), nullptr);
			//else
			//	cout<<"Program has Error: "<<errors<<endl;
			return v;
		}
};


#endif