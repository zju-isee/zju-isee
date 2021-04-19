#include "BinomialHeap.h"

// 交换函数
void swap1(unsigned int *a, unsigned int *b) {
    unsigned int temp = *a;
    *a = *b;
    *b = temp; 
}

void swap2(int *a, int *b) {
    int temp = *a;
    *a = *b;
    *b = temp; 
}

void swap3(BinoNode *a, BinoNode *b) {
    BinoNode temp = *a;
    *a = *b;
    *b = temp; 
}

// 建堆，值为key，边为vertex
BinoHeap BinoHeapCreate(unsigned int key, int vertex) {
    BinoHeap binoHeap = (BinoHeap)malloc(sizeof(struct BinomialNode));
    binoHeap->Degree = 0;
    binoHeap->Vertex = vertex;
    binoHeap->Key = key;
    binoHeap->Left = binoHeap->Parent = binoHeap->NextSibling = NULL;
    return binoHeap;
}

// 连接两个度相同的堆，把bh2接到bh1上，bh1的key小于bh2的key
void BinoHeapLink(BinoHeap bh1, BinoHeap bh2) {
    bh2->Parent = bh1;
    bh2->NextSibling = bh1->Left;
    bh1->Left = bh2;
    bh1->Degree += 1;
}

// 堆中插入值为key的结点
BinoHeap BinoHeapInsert(BinoHeap binoHeap, unsigned int key, int vertex, BinoNode *Position) {
    BinoHeap newNode = BinoHeapCreate(key, vertex);
    Position[vertex] = newNode;
    return BinoHeapUnion(binoHeap, newNode);
}

// 合并两个有序二项堆，按度数递增
BinoHeap BinoHeapMerge(BinoHeap bh1, BinoHeap bh2) {
    BinoHeap dummy = BinoHeapCreate(0, 0);  // 一个哑巴结点，便于后续操作，可以不用讨论两个结点为空的情况
    BinoHeap prev = dummy;

    // 归并排序
    while (bh1 && bh2) {
        if (bh1->Degree < bh2->Degree) {
            prev->NextSibling = bh1;
            bh1 = bh1->NextSibling;
        } else {
            prev->NextSibling = bh2;
            bh2 = bh2->NextSibling;
        }
        prev = prev->NextSibling;
    }

    // 合并后两个堆最多只有一个没有合并完
    prev->NextSibling = bh1 == NULL ? bh2 : bh1;

    BinoHeap binHeap = dummy->NextSibling;  // 要返回的头结点
    dummy->NextSibling = NULL;  // 让哑巴结点指向的下一个为空
    free(dummy);                // 释放哑巴结点的空间
    return binHeap;
}

// 合并两个堆，算法参考自算法导论
// http://staff.ustc.edu.cn/~csli/graduate/algorithms/book6/chap20.htm
BinoHeap BinoHeapUnion(BinoHeap bh1, BinoHeap bh2) {
    BinoHeap binoHeap = BinoHeapMerge(bh1, bh2);
    if (binoHeap == NULL) return binoHeap;

    BinoHeap prev = NULL;
    BinoHeap p = binoHeap;
    BinoHeap next = p->NextSibling;
    
    while (next) {
        if (p->Degree != next->Degree || (next->NextSibling != NULL && next->NextSibling->Degree == p->Degree)) {
            // p和next度数不同或者度数相同但是存在至少三个结点度数相同的情况
            prev = p;
            p = next;
        } else if (p->Key <= next->Key) { // p和next度数相同但是p的key小于next的key，需要把next挂到p上
            p->NextSibling = next->NextSibling;
            BinoHeapLink(p, next);
        } else { // p和next度数相同但是p的key大于next的key，需要把p挂到next上
            if (prev == NULL) { // prev为空，则二项堆头结点为next
                binoHeap = next;
            } else {
                prev->NextSibling = next;
            }
            BinoHeapLink(next, p);  // 把p挂到next上
            p = next;  // 现在处理next结点
        }
        next = p->NextSibling;
    }
    return binoHeap;
}

// 找到最小结点所在位置及其前一个位置
void BinoHeapFindMin(BinoHeap binoHeap, BinoNode *prev, BinoNode *pos) {
    if (binoHeap == NULL) return;
    BinoNode p, p_prev;
    unsigned int min = INF;   // 最小值初始化为INF
    p = binoHeap;    // 指向链表头结点
    p_prev = NULL;   // p的前一个
    while (p) {
        if (p->Key < min) {
            min = p->Key;
            *prev = p_prev;
            *pos = p;
        }
        p_prev = p;
        p = p->NextSibling;
    }
}

// 反转堆的孩子结点，此处头结点为被删除结点的左孩子
BinoHeap BinoHeapReverse(BinoHeap binoHeap) {
    // 先判断是否为空或者只有一个结点
    if (binoHeap == NULL) return binoHeap;
    BinoHeap prev = NULL;
    BinoHeap p = binoHeap;
    while (p) {
        p->Parent = NULL;
        BinoHeap next = p->NextSibling;
        p->NextSibling = prev;  // 头插
        prev = p;
        p = next;
    }
    return prev;
}

// 删除最小结点并返回被删除结点后的堆
BinoNode BinoHeapDeleteMin(BinoHeap binoHeap, BinoNode prev, BinoNode pos) {
    if (binoHeap == NULL) return NULL;
    if (prev == NULL) {
        binoHeap = binoHeap->NextSibling;  // 恰好是根链表的头节点
    } else {
        prev->NextSibling = pos->NextSibling;
    }
    pos->Left = BinoHeapReverse(pos->Left);
    BinoHeap p = pos->Left;
    pos->Left = NULL;
    free(pos);   // 释放空间
    pos = NULL;
    return BinoHeapUnion(binoHeap, p);
}

// 将堆的值更新为newKey，就是一个上滤操作
BinoHeap BinoHeapDecreaseKey(BinoHeap binoHeap, BinoNode pos, unsigned int newKey, BinoNode *Position) {
    if (binoHeap == NULL) return binoHeap;  // 先判断堆为空
    pos->Key = newKey;   // 更新key
    BinoHeap p = pos->Parent;   // p是pos的父亲结点
    while (p && pos->Key < p->Key) {   // pos是需要上滤的结点
        swap3(&Position[p->Vertex], &Position[pos->Vertex]);
        swap1(&p->Key, &pos->Key);
        swap2(&p->Vertex, &pos->Vertex);
        pos = p;
        p = pos->Parent;
    }

    return binoHeap;
}

// 释放链表空间，每个链表自Left指针开始都是单链表，因此可以递归释放单链表
void BinoHeapDispose(BinoHeap binoHeap) {
    if (binoHeap == NULL) return;  // 递归终点
    if (binoHeap->Left == NULL) {
        BinoHeap temp;
        while (binoHeap) {
            temp = binoHeap;
            binoHeap = binoHeap->NextSibling;
            free(temp);
            binoHeap = NULL;  // 让其指向空
        }
    } else {
        BinoHeapDispose(binoHeap->Left);  // 递归释放
    }
}

// 判断堆是否为空
int BinoHeapIsEmpty(BinoHeap binoHeap) {
    return binoHeap == NULL;
}

