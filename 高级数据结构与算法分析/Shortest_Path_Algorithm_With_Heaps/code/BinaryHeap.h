/*
 * @Description: 
 * @version: 
 * @Author: hxy
 * @Date: 2021-04-06 09:53:26
 * @LastEditors: hxy
 * @LastEditTime: 2021-04-07 10:32:58
 */
#ifndef __BINARY_HEAP_H__
#define __BINARY_HEAP_H__

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#ifndef __INF__
#define INF 0xFFFFFFFF
#endif

typedef struct BinaryHeap *BinHeap;
struct BinaryHeap {
    int Size;               /* 堆现在的大小 */
    int Capacity;           /* 最大堆容量 */
    unsigned int *Key;      /* 存放目前从源到顶点的最短距离 */
    int *Vertex;            /* 存放key对应的顶点 */
    int *Position;          /* 记录顶点在Key和Vertex数组中的下标 */
};

// 交换函数
void swap1(unsigned int *a, unsigned int *b);
void swap2(int *a, int *b);

// 建堆，堆的初始容量为顶点的个数，大小为0，key为INF
BinHeap BinHeapCreate(int capacity);

// 将新的key和顶点插入至堆的末尾
BinHeap BinHeapInsert(BinHeap binHeap, unsigned int key, int vertex);

// 从pos的位置开始向下调整堆，维护最小堆的性质
BinHeap BinHeapDownAdjust(BinHeap binHeap, int pos);

// 删除堆顶元素
void BinHeapDeleteMin(BinHeap binHeap, unsigned int *min, int *v);

// 将位置pos处的key将为新的key
BinHeap BinHeapDecreaseKey(BinHeap binHeap, int pos, unsigned int newKey);

// 释放空间
void BinHeapDispose(BinHeap binHeap);

// 判断堆是否为空
int BinHeapIsEmpty(BinHeap binHeap);

#endif