/*
 * @Description: 
 * @version: 
 * @Author: hxy
 * @Date: 2021-04-06 09:53:18
 * @LastEditors: hxy
 * @LastEditTime: 2021-04-07 10:35:57
 */
#include "BinaryHeap.h"

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

// 建堆，堆的初始容量为顶点的个数，大小为0，key为INF
BinHeap BinHeapCreate(int capacity) {
    BinHeap binHeap = (BinHeap)malloc(sizeof(struct BinaryHeap));
    binHeap->Size = 0;             // 堆的初始大小为-
    binHeap->Capacity = capacity;  // 最大堆容量
    binHeap->Key = (unsigned int *)calloc(capacity + 1, sizeof(unsigned int)); 
    binHeap->Vertex = (int *)calloc(capacity + 1, sizeof(int));                 
    binHeap->Position = (int *)calloc(capacity + 1, sizeof(int));               
    memset(binHeap->Key, INF, sizeof(unsigned int) * (capacity + 1));           // 初始key为INF
    memset(binHeap->Vertex, 0, sizeof(int) * (capacity + 1));                   
    memset(binHeap->Position, 0, sizeof(int) * (capacity + 1));
    return binHeap;
}

// 将新的key和顶点插入至堆的末尾
BinHeap BinHeapInsert(BinHeap binHeap, unsigned int key, int vertex) {
    ++binHeap->Size;
    binHeap->Vertex[binHeap->Size] = vertex;
    binHeap->Position[vertex] = binHeap->Size;
    return BinHeapDecreaseKey(binHeap, binHeap->Size, key);    // 降key
}

// 从pos的位置开始向下调整堆，维护最小堆的性质
BinHeap BinHeapDownAdjust(BinHeap binHeap, int pos) {
    int i = pos;        // 要被调整的结点
    int j = pos * 2;    // 结点的左孩子
    while (j <= binHeap->Size) {
        if (j + 1 <= binHeap->Size && binHeap->Key[j+1] < binHeap->Key[j]) {
            j = j + 1;
        }
        if (binHeap->Key[j] < binHeap->Key[i]) {
            swap2(&binHeap->Position[binHeap->Vertex[i]], &binHeap->Position[binHeap->Vertex[j]]);   // 更新位置
            swap2(&binHeap->Vertex[i], &binHeap->Vertex[j]);     // 交换元素
            swap1(&binHeap->Key[i], &binHeap->Key[j]);
            i = j;
            j = i * 2; 
        } else {
            break;
        }
    }
    return binHeap;
}

// 删除堆顶元素
void BinHeapDeleteMin(BinHeap binHeap, unsigned int *min, int *v) {
    *min = binHeap->Key[1];     // 记录目前最短距离
    *v = binHeap->Vertex[1];    // 记录目前最短距离对应的顶点
    binHeap->Position[*v] = 0;  // 清除位置
    binHeap->Key[1] = binHeap->Key[binHeap->Size];        // 将堆末尾元素放到堆顶
    binHeap->Vertex[1] = binHeap->Vertex[binHeap->Size];
    binHeap->Size--;
    binHeap->Position[binHeap->Vertex[1]] = 1;    // 更新对应顶点在堆中的下标为1
    binHeap = BinHeapDownAdjust(binHeap, 1);      // 调整堆
}

// 将位置pos处的key将为新的key
BinHeap BinHeapDecreaseKey(BinHeap binHeap, int pos, unsigned int newKey) {
    binHeap->Key[pos] = newKey;
    int i = pos, j = i / 2;  // j是i的父亲结点
    while (i > 1 && binHeap->Key[j] > binHeap->Key[i]) { // 如果父亲结点的值更大，需要将儿子结点上滤
        swap2(&binHeap->Position[binHeap->Vertex[i]], &binHeap->Position[binHeap->Vertex[j]]);
        swap2(&binHeap->Vertex[i], &binHeap->Vertex[j]);
        swap1(&binHeap->Key[i], &binHeap->Key[j]);
        i = j;
        j = i / 2;
    }
    return binHeap;
}

// 释放空间
void BinHeapDispose(BinHeap binHeap) {
    free(binHeap->Key);
    free(binHeap->Vertex);
    free(binHeap->Position);
    free(binHeap);
}

// 判断堆是否为空
int BinHeapIsEmpty(BinHeap binHeap) {
    return binHeap->Size == 0;
}
