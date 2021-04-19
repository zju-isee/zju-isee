#ifndef ____RADIX_HEAP_H_____
#define ____RADIX_HEAP_H_____

#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#define MAX_ARC 131072
#define LL_INF 0x3f3f3f3f3f3f3f3f


// Definition of Radix Heap
typedef struct HeapStruct *Heap;
typedef struct NodeStruct *Node;
struct HeapStruct {
    int B, num_v;  // B: number of buckets; num_v: number of vertice
	long long *size;  // size[i]: the maximum size of bucket i
    long long *u;     // u[i]: the upper limit of bucket i
    int *location;  // place[v]: the bucket to which vertex v belongs
    Node *map;      // map[v]: the node representing vertex v
    Node *bucket;   // bucket[1..B]
};
struct NodeStruct {
    Node left, right; // circular doubly-linked list
    int vertex;
    long long key;
};

// 建堆，节点个数为n，最大边长为C
Heap CreateHeap(int n, int C);

// 将NewNode插入到第i个桶中
void InsertIntoBucket(Node NewNode, int i, Heap H);

// 将OldNode从第j个桶中删除
void RemoveFromBucket(Node OldNode, int j, Heap H);

// 插入键为key的vertex
void Insert(int vertex, long long key, Heap H);

// 找到vertex在堆中对应的key；若vertex不在堆中，返回LL_INF
long long GetKey(int vertex, Heap H);

// 将vertex在堆中对应的key减为new_key
void DecreaseKey(int vertex, long long new_key, Heap H);

// 删除并返回最小值
Node DeleteMin(Heap H);

// 释放空间
void DisposeHeap(Heap H);


#endif