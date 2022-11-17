#ifndef OLD_AST
#define OLD_AST

struct node {
    struct node *left; 
    struct node *right; 
    string token; 
};

struct node *head;
void printtree(struct node*);
void printPreorder(struct node *);
struct node* mknode(struct node *left, struct node *right, string token);


void printtree(struct node* tree) {
	cout << "\n\n Preorder traversal of the Parse Tree: \n\n";
	printPreorder(tree);
	cout << "\n\n";
}

void printPreorder(struct node *tree) {
	if(!tree)
		return;
	cout << tree->token << " ";
	if (tree->left) {
		printPreorder(tree->left);
	}
	if (tree->right) {
		printPreorder(tree->right);
	}
}

struct node* mknode(struct node *left, struct node *right, string token) {
	struct node *newnode = (struct node *)malloc(sizeof(struct node));
	string newstr = token;
	newnode->left = left;
	newnode->right = right;
	newnode->token = newstr;
	return(newnode);
}
#endif