/*
 * @Description: 二项堆实现，算法结构参考自算法导论二项堆实现
 *               http://staff.ustc.edu.cn/~csli/graduate/algorithms/book6/chap20.htm
 * @version: 
 * @Author: hxy
 * @Date: 2021-04-06 07:43:38
 * @LastEditors: hxy
 * @LastEditTime: 2021-04-08 17:40:07
 */
#ifndef __BINOMIAL_HEAP_H__
#define __BINOMIAL_HEAP_H__

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#ifndef __INF__
#define INF 0xFFFFFFFF
#endif

typedef struct BinomialNode *BinoHeap, *BinoNode;
struct BinomialNode {
    int Vertex;           /* 顶点值 */
    unsigned int Key;     /* 从源到顶点目前最短距离 */
    int Degree;           /* 结点的度 */
    BinoNode Parent;      /* 结点的父亲 */
    BinoNode Left;        /* 结点的左孩子 */
    BinoNode NextSibling; /* 结点的兄弟 */
};

// 交换函数
void swap1(unsigned int *a, unsigned int *b);
void swap2(int *a, int *b);
void swap3(BinoNode *a, BinoNode *b);

// 建堆，值为key，目的为vertex
BinoHeap BinoHeapCreate(unsigned int key, int vertex);

// 堆中插入值为key的结点
BinoNode BinoHeapInsert(BinoHeap binoHeap, unsigned int key, int vertex, BinoNode *Position);

// 连接两个度相同的堆
void BinoHeapLink(BinoHeap bh1, BinoHeap bh2);

// 合并两个二项堆，按度数递增
BinoHeap BinoHeapMerge(BinoHeap bh1, BinoHeap bh2);

// 合并两个堆
BinoHeap BinoHeapUnion(BinoHeap bh1, BinoHeap bh2);

// 找到最小结点所在位置
void BinoHeapFindMin(BinoHeap binoHeap, BinoNode *prev, BinoNode *pos);

// 反转堆的孩子结点
BinoHeap BinoHeapReverse(BinoHeap binoHeap);

// 删除最小结点并返回被删除的最小结点
BinoNode BinoHeapDeleteMin(BinoHeap binoHeap, BinoNode prev, BinoNode pos);

// 将堆的值更新为newKey
BinoHeap BinoHeapDecreaseKey(BinoHeap BinoHeap, BinoNode pos, unsigned int newKey, BinoNode *Position);

// 释放链表空间，每个链表自Left指针开始都是单链表，因此可以递归释放单链表
void BinoHeapDispose(BinoHeap binoHeap);

// 判断堆是否为空
int BinoHeapIsEmpty(BinoHeap binoHeap);

#endif