#ifndef ____FIBHEAP_H_____
#define ____FIBHEAP_H_____

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>
#define LL_INF 0x3f3f3f3f3f3f3f3f
#define min(a, b) ((a) < (b) ? (a) : (b))
#define max(a, b) ((a) > (b) ? (a) : (b))
#define loggr(a) (floor((log((double)a) / log(1.618))))
#define swapnode(a, b) { Node __t; __t = a; a = b; b = __t; }

typedef struct NodeStruct* Node;
typedef struct HeapStruct* FHeap;

struct NodeStruct {
	int vertex;    // 图中结点下标
	long long key;
	int degree;   // 子结点个数
	Node left;
	Node right;
	Node child;   // 指向子结点链表中任意一个
	Node parent;
	int mark;     // x is marked when x has lost a child 
				  // since the last time x was child of another node
};

struct HeapStruct {
	int num;		//堆中节点总数
	int max_degree; // D
	Node Min;		//最小节点
	Node* map;      //图中各个下标对应的堆结点
};

// 创建堆，图中结点个数为n
FHeap fibHeapCreate(int n);

void fibMoveToRootList(Node node, FHeap H); // move an existing node into the root list

void fibRemoveFromRootList(Node node, FHeap H); // remove a root from root list

void fibInsert(int vertex, long long key, FHeap H);	// insert (vertex, key) into H

// 删除并返回最小节点
Node fibDeleteMin(FHeap H);

// Readjust the heap after DeleteMin 
void fibConsolidate(FHeap H);

// Get key of vertex from heap H
long long fibGetKey(int vertex, FHeap H);

void fibCut(Node x, Node y, FHeap H); // move x from y's child list to the root list

void fibCascadeCut(Node y, FHeap H); // Cut x's parent y, and do it recursively on y

void fibDecreaseKey(int vertex, long long new_key, FHeap H); // Decrease the key

void fibDisposeNode(Node node); // Dispose a node and its ancestors

void fibDispose(FHeap H); // Dispose the heap

#endif