#include "RadixHeap.h"

#define MAX_ARC 131072
#define LL_INF 0x3f3f3f3f3f3f3f3f

// 建堆，节点个数为n，最大边长为C
Heap CreateHeap(int n, int C) {
    int i;

    Heap H = (Heap)malloc(sizeof(struct HeapStruct));
    H->B = (int)ceil(log(C + 1) / log(2)) + 2; // number of buckets
    H->bucket = (Node *)calloc(1 + H->B, sizeof(Node));
    H->num_v = n;

    // size[i] = 1, i == 1
    //           2^(i-1), 2 <= i <= B - 1
    //           nC + 1, i == B
    H->size = (long long *)malloc((1 + H->B) * sizeof(long long));
    H->size[1] = 1; 
    if (H->B > 1) H->size[2] = 1;
    for (i = 3; i < H->B; i++) H->size[i] = 2 * H->size[i - 1];
    H->size[H->B] = (long long)n * C + 1;

    // u[i] = 2^(i-1)-1, 1 <= i < B
    //        nC + 1, i == B
    H->u = (long long *)malloc((1 + H->B) * sizeof(long long));
    H->u[0] = -1;
    H->u[1] = 0;
    for (i = 2; i < H->B; i++) H->u[i] = (H->u[i - 1] + 1) * 2 - 1;
    H->u[H->B] = (long long)n * C + 1;

    H->location = (int *)calloc(1 + n, sizeof(int));
    H->map = (Node *)calloc(1 + n, sizeof(Node));

#ifdef __DEBUG__
    printf("u:");
    for (i = 0; i <= H->B; i++) printf("%d/%lld ", i, H->u[i]);
    printf("\n");
#endif

    return H;
}

// 将NewNode插入到第i个桶中
void InsertIntoBucket(Node NewNode, int i, Heap H)
{
    if (H->bucket[i] == NULL) { // empty bucket
        NewNode->left = NewNode->right = NewNode;
        H->bucket[i] = NewNode;
    }
    else { // bucket contains at least one node
        NewNode->left = H->bucket[i];
        NewNode->right = H->bucket[i]->right;
        NewNode->left->right = NewNode;
        NewNode->right->left = NewNode;
    }
    // update location[] and map[] of vertex
    H->location[NewNode->vertex] = i;
    H->map[NewNode->vertex] = NewNode;

#ifdef __DEBUG__
    printf("Inserted %d<-(%d,%lld)->%d into bucket %d\n", NewNode->left->vertex, 
                                    NewNode->vertex, NewNode->key, NewNode->right->vertex, i);
#endif

}

// 将OldNode从第j个桶中删除
void RemoveFromBucket(Node OldNode, int j, Heap H)
{
#ifdef __DEBUG__
    printf("Removing (%d,%lld) from bucket %d\n", OldNode->vertex, OldNode->key, j);
#endif

    if (OldNode == OldNode->right) { // this bucket contained only OldNode
        H->bucket[j] = NULL;
    }
    else { // this bucket contained more than one nodes
        OldNode->left->right = OldNode->right;
        OldNode->right->left = OldNode->left;
        if (H->bucket[j] == OldNode) // OldNode used to be head of doubly-linked list
            H->bucket[j] = OldNode->right;
    }
    // wipe location[] and map[] of vertex
    H->location[OldNode->vertex] = 0;
    H->map[OldNode->vertex] = NULL;
}

// 插入键为key的vertex
void Insert(int vertex, long long key, Heap H)
{
    int i;
    for (i = H->B; i >= 1; i--) { // find the bucket whose range key falls in
        if (H->u[i - 1] < key) break;
    }
    Node NewNode = (Node)malloc(sizeof(struct NodeStruct));
    if (!NewNode) {
        fprintf(stderr, "Memory allocation failed.");
        exit(0);
    }
    NewNode->vertex = vertex;
    NewNode->key = key;
    InsertIntoBucket(NewNode, i, H);
}


// 找到vertex在堆中对应的key；若vertex不在堆中，返回LL_INF
long long GetKey(int vertex, Heap H)
{
#ifdef __DEBUG__
    if (H->map[vertex]) printf("key[%d] = %lld\n", vertex, H->map[vertex]->key);
    else printf("key[%d] not found\n", vertex);
#endif

    return H->map[vertex] ? H->map[vertex]->key : LL_INF;
}

// 将vertex在堆中对应的key减为new_key
void DecreaseKey(int vertex, long long new_key, Heap H)
{
    Node NewNode = H->map[vertex];
    int j = H->location[vertex], i;
    
#ifdef __DEBUG__
    printf("Decreasing key (%d, %lld)\n", vertex, new_key);
#endif
    RemoveFromBucket(NewNode, j, H); // first remove NewNode from its bucket
    
    // reinsert NewNode with decreased key
    for (i = j; i >= 1; i--) { // key is decreased -- start from bucket j
        if (H->u[i - 1] < new_key) break;
    }
    NewNode->key = new_key;
    InsertIntoBucket(NewNode, i, H); // reinsert into appropriate bucket
#ifdef __DEBUG__
    printf("Decrease complete\n");
#endif
}

// 删除并返回最小值
Node DeleteMin(Heap H)
{
    Node MinNode;

    if (H->bucket[1]) { // bucket 1 is nonempty: return any vertex in bucket 1
#ifdef __DEBUG__
        printf("Deletemin() = (%d, %lld) in bucket 1\n", H->bucket[1]->vertex, H->bucket[1]->key);
#endif
        MinNode = H->bucket[1];
        RemoveFromBucket(MinNode, 1, H);
    }
    else {
        int j, i;
        Node ThisNode, NextNode;

        for (j = 2; j <= H->B; j++) { // find nonempty bucket j with smallest index
            if (H->bucket[j]) break;
        }
        if (!H->bucket[j]) { // all buckets are empty
            fprintf(stderr, "DeleteMin on empty heap.");
            return NULL;
        }

        // MinNode is the smallest node in bucket j, i.e. H->bucket[j]
        MinNode = H->bucket[j];
        for (ThisNode = H->bucket[j]->right; ThisNode != H->bucket[j]; ThisNode = ThisNode->right) {
            if (ThisNode->key < MinNode->key)
                MinNode = ThisNode;
        }
#ifdef __DEBUG__
        printf("Deletemin() = (%d, %lld)\n", MinNode->vertex, MinNode->key);
#endif
        // update u[0..j-1]
        H->u[0] = MinNode->key - 1;
        H->u[1] = MinNode->key;
        for (i = 2; i <= j - 1; i++) {
            H->u[i] = (H->u[i - 1] + H->size[i]) < (H->u[j]) ? (H->u[i - 1] + H->size[i]) : (H->u[j]);
        }
#ifdef __DEBUG__
        printf("u:");
        for (i = 0; i <= H->B; i++) printf("%d/%lld ", i, H->u[i]);
        printf("\n");
#endif
        // reinsert each node in bucket j
        H->bucket[j] = NULL; // remove all nodes in bucket j

        // reinsertions will mess up the linked list, therefore to store NextNode is needed
        for (ThisNode = MinNode->right, NextNode = ThisNode->right; ThisNode != MinNode;  
                                        ThisNode = NextNode, NextNode = ThisNode->right) {
            int jj = j, ii;

            // find new bucket whose range ThisNode->key falls in
            for (ii = jj; ii >= 1; ii--) {
                if (H->u[ii - 1] < ThisNode->key) break;
            }
#ifdef __DEBUG__
            printf("Re");
#endif
            InsertIntoBucket(ThisNode, ii, H);
        }
        
    }
#ifdef __DEBUG__
    printf("End of DeleteMin()\n");
#endif
    return MinNode;
}

// 释放空间
void DisposeHeap(Heap H)
{
    int i;
    Node ThisNode, NextNode;
    free(H->bucket);
    free(H->location);
    for (i = 1; i <= H->num_v; i++) {
        if (H->map[i]) free(H->map[i]);
    }
    free(H->map);
    free(H->size);
    free(H->u);
    free(H);
}

