#include "FibHeap.h"


// 创建堆，图中结点个数为n
FHeap fibHeapCreate(int n)
{
	FHeap fibheap;

	fibheap = (FHeap)malloc(sizeof(struct HeapStruct));

	fibheap->num = 0;
	fibheap->Min = NULL;
	fibheap->map = (int*)calloc(n + 1, sizeof(int));
	fibheap->max_degree = (int)loggr(n);
#ifdef __DEBUG__
	printf("FibHeap created\n");
#endif

	return fibheap;
}

void fibMoveToRootList(Node node, FHeap H) // move an existing node into the root list
{ 
	// make sure node is not originally in the root list!

	if (H->Min == NULL) { // If the heap is now empty
		node->left = node->right = node; // Create a root list for H containing just node
		node->parent = NULL;
		H->Min = node;
	}
	else {
		// insert node into H's root list
		node->left = H->Min;
		node->right = H->Min->right;
		node->left->right = node->right->left = node;
		node->parent = NULL;
		// update Min if needed
		if (node->key < H->Min->key) {
			H->Min = node;
		}
	}
#ifdef __DEBUG__
	printf("(%d, %lld) moved to root list\n", node->vertex, node->key);
#endif
}

void fibRemoveFromRootList(Node node, FHeap H) // remove a root from root list
{
	// make sure node is originally in the root list!
	if (node->parent) {
		fprintf(stderr, "Trying to remove a nonroot node from root list\n");
		return;
	}
	if (node == node->right) { // root list contains node itself
		H->Min = NULL;
	}
	else {
		if (node->left) node->left->right = node->right;
		if (node->right) node->right->left = node->left;
		if (H->Min == node) H->Min = H->Min->right; // update Min if needed (may be the wrong Min)
	}
	// note that node->parent is still NULL, and that H->Min may be corrupted
#ifdef __DEBUG__
	printf("(%d, %lld) removed from root list...\n", node->vertex, node->key);
#endif
}

void fibInsert(int vertex, long long key, FHeap H)	// insert (vertex, key) into H
{
	Node node = (Node)malloc(sizeof(struct NodeStruct));

	node->vertex = vertex;
	node->key = key;
	node->degree = 0;
	node->mark = 0;
	node->child = NULL;
	H->map[vertex] = node;

#ifdef __DEBUG__
	printf("Inserting (%d, %lld)...\n", vertex, key);
#endif

	fibMoveToRootList(node, H);
	H->num++;

#ifdef __DEBUG__
	printf("Inserted %d<=(%d, %lld)=>%d to heap\n", node->left->vertex, node->vertex, node->key, node->right->vertex);
#endif
}

// 删除并返回最小节点
Node fibDeleteMin(FHeap H)
{
#ifdef __DEBUG__
	printf("Deleting Min...\n");
#endif

	Node result = H->Min;
	if (result != NULL) {
		if (result->child) { // add each child of x to the root list
#ifdef __DEBUG__
			printf("Min has children\n");
#endif
			Node ThisNode = result->child, NextNode;
			ThisNode->left->right = NULL; // break the loop
			while (ThisNode) {
#ifdef __DEBUG__
				if (ThisNode->right)
					printf("This child: (%d, %lld)=>%d\n", ThisNode->vertex, ThisNode->key, ThisNode->right->vertex);
				else printf("This child: (%d, %lld)\n", ThisNode->vertex, ThisNode->key);
#endif
				NextNode = ThisNode->right;
				fibMoveToRootList(ThisNode, H);
				ThisNode = NextNode;
			}
			result->child = NULL; // now result has 0 child
		}
		fibRemoveFromRootList(result, H);
		H->num--;
		fibConsolidate(H);

#ifdef __DEBUG__
		printf("DeletingMin() = (%d, %lld)\n", result->vertex, result->key);
#endif
	}
	else {
		fprintf(stderr, "DeleteMin from empty heap.");
	}
	return result;
}

void fibConsolidate(FHeap H) 
{
	Node* A = (Node*)calloc(H->max_degree + 1, sizeof(Node));
#ifdef __DEBUG__
	printf("Consolidating...\n");
#endif

	if (!H->Min) {
#ifdef __DEBUG__
		printf("Nothing to consolidate.\n");
#endif
		return; // if heap is empty, no need to consolidate
	}

	// find two roots x and y in the root list that are of the same degree
	Node ThisNode = H->Min, LastNode = H->Min->left, NextNode;
	int last_node_scanned = 0;
	while (!last_node_scanned) {
		if (ThisNode == LastNode) last_node_scanned = 1;
		NextNode = ThisNode->right;
#ifdef __DEBUG__
		printf("Now checking node %d", ThisNode->vertex);
		if (ThisNode->left) printf(", previous being %d", ThisNode->left->vertex);
		if (NextNode) printf(", next being %d", NextNode->vertex);
		printf("\n");
#endif
		Node x = ThisNode;

		while (A[x->degree]) {
			Node y = A[x->degree]; // another node with the same degree as x
#ifdef __DEBUG__
			printf("%d and %d both have degree %d\n", x->vertex, y->vertex, x->degree);
#endif
			if (x->key > y->key) {
				swapnode(x, y); // x->key <= y->key
			}
			fibRemoveFromRootList(y, H);
			A[x->degree] = NULL;
			// make y a child of x
			if (x->child) {
				y->left = x->child;
				y->right = x->child->right;
				y->left->right = y->right->left = y;
			}
			else {
				y->left = y->right = y;
				x->child = y;
			}
			y->parent = x;
#ifdef __DEBUG__
			printf("Attaching %d under %d\n", y->vertex, x->vertex);
#endif
			x->degree++;
			y->mark = 0;
		}
		A[x->degree] = x;

		ThisNode = NextNode;
	}

	// Reconstruct the root list
#ifdef __DEBUG__
	printf("Reconstructing...");
#endif
	H->Min = NULL;
	for (int i = 0; i <= H->max_degree; i++) {
		if (A[i]) {
			fibMoveToRootList(A[i], H);
		}
	}

	free(A);

#ifdef __DEBUG__
	printf("Consolidated.\n");
#endif
}

long long fibGetKey(int vertex, FHeap H) // get key of vertex from heap
{
	if (H->map[vertex]) return H->map[vertex]->key;
	else return LL_INF;
}

void fibCut(Node x, Node y, FHeap H) // move x from y's child list to the root list
{
#ifdef __DEBUG__
	printf("cutting %d from %d\n", x->vertex, y->vertex);
#endif

	// remove x from y's child list
	if (x == x->right) { // y's child list contains only x
		y->child = NULL;
	}
	else {
		x->left->right = x->right;
		x->right->left = x->left;
		if (y->child == x) {
			y->child = y->child->right;
		}
	}
	// decrement y's degree
	y->degree--;

	fibMoveToRootList(x, H);
	x->mark = 0;
}

void fibCascadeCut(Node y, FHeap H) // Cut x's parent y, and do it recursively on y
{
	Node z = y->parent;
	if (z) {
		if (!y->mark) {
			y->mark = 1;
		}
		else {
			fibCut(y, z, H);
			fibCascadeCut(z, H);
		}
	}
}

void fibDecreaseKey(int vertex, long long new_key, FHeap H) // Decrease the key
{
	Node x = H->map[vertex]; // x is the corresponding node in the heap
	if (new_key > x->key) {
		fprintf(stderr, "new key of %d is greater than current key\n", vertex);
		exit(0);
	}

	x->key = new_key;
	Node y = x->parent;
	if (y && (x->key < y->key)) { // heap property is violated
#ifdef __DEBUG__
		printf("%d and its parent %d violate heap properties. Adjusting...\n", x->vertex, y->vertex);
#endif
		fibCut(x, y, H);
		fibCascadeCut(y, H);
	}
#ifdef __DEBUG__
	else {
		printf("%d<=(%d, %lld)=>%d has no parent, no need to worry.\n", x->left->vertex, x->vertex, x->key, x->right->vertex);
	}
#endif
	if (x->key < H->Min->key) { // update Min if necessary
		H->Min = x;
	}
#ifdef __DEBUG__
	printf("Decreased key (%d, %lld)\n", vertex, new_key);
#endif
}

void fibDisposeNode(Node node) // Dispose a node and its ancestors
{
	if (node->child) {
		Node ThisNode = node->child, NextNode;
		ThisNode->left->right = NULL; // cut the loop;
		while (ThisNode) {
			NextNode = ThisNode->right;
			fibDisposeNode(ThisNode);
			ThisNode = NextNode;
		}
	}
	free(node);
}

void fibDispose(FHeap H) // Dispose the heap
{
	if (H->Min) {
		Node ThisNode = H->Min, NextNode;
		ThisNode->left->right = NULL; // cut the loop
		while (ThisNode) {
			NextNode = ThisNode->right;
			fibDisposeNode(ThisNode);
			ThisNode = NextNode;
		}
	}
	
	free(H->map);
	free(H);
}

