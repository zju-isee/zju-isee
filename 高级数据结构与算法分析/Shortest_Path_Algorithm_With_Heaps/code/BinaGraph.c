#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "BinaryHeap.h"

/****** Definitions and operations of the graph ******/
typedef struct AdjvStruct *PtrToAdjv;
struct AdjvStruct {      /* Stores a directed edge */
    int Adjv;            /* The end vertex of the directed edge */
    unsigned int Weight; /* The weight of the directed edge */
    PtrToAdjv Next;      /* The next directed edge that shares the intial vertex */
};
typedef struct GraphStruct *Graph;
struct GraphStruct {    /* The structures stores info of the graph */
    int Nv;             /* Number of vertice */
    PtrToAdjv *V;       /* V[i]: the first vertex adjacent to vertex i */
};

/* InitGraph(v)                                 *
 * Returns an initialized graph of v vertices. */
Graph InitGraph(int v)
{
    Graph G = (Graph)malloc(sizeof(struct GraphStruct));
    G->Nv = v;
    G->V = (PtrToAdjv *)calloc(v + 1, sizeof(PtrToAdjv *));
    return G;
}

/* AddEdge(start, end, weight, G)                          *
 * Adds a directed edge from start to end of given weight. */
void AddEdge(int start, int end, unsigned int weight, Graph G)
{
    PtrToAdjv current = (PtrToAdjv)malloc(sizeof(struct AdjvStruct));

    current->Adjv = end;
    current->Weight = weight;
    current->Next = G->V[start];
    G->V[start] = current; /* insert to the front of the linked list */
}

/***** Implementation of Dijkstra Algorithm *****/
unsigned int Dijkstra(int start, int end, Graph G)
{ 
    BinHeap binHeap = BinHeapCreate(G->Nv);
    unsigned int dist_end = 0xFFFFFFFF;
    
    // Known[i]: whether the shortest distance to i is known
    int *Known = (int *)calloc(G->Nv + 1, sizeof(int)); // Known[1..Nv] = 0
    memset(Known, 0, (G->Nv + 1) * sizeof(int));

    binHeap = BinHeapInsert(binHeap, 0, start); // insert the start node to binheap
    
    while (!BinHeapIsEmpty(binHeap)) {
        unsigned int min;
        int v;

        BinHeapDeleteMin(binHeap, &min, &v); // v is the smallest distance vertex


        // debug
        // for(int i = 1; i <= binHeap->Size; ++i) {
        //     printf("to %d: %d \t pos = %d\n", binHeap->Vertex[i], binHeap->Key[i], binHeap->Position[binHeap->Vertex[i]]);
        // }

        // printf("min = %d, v = %d\n", min, v);
        // printf("*******************************************\n\n");

        if (v == end) { // if v is the queried vertex, the answer is found
            dist_end = min;
            break;
        }
     
        Known[v] = 1;    // v is visited
        for (PtrToAdjv edge = G->V[v]; edge; edge = edge->Next) {
            if (!Known[edge->Adjv]) {
                int pos = binHeap->Position[edge->Adjv];    // the position of edge->Adjv int the Key and Vertex array
                // printf("vertex: %d\n", edge->Adjv);
                if (binHeap->Key[pos] == INF) {   // if the vertex is not in binHeap, insert it
                    binHeap = BinHeapInsert(binHeap, min + edge->Weight, edge->Adjv);
                } else {
                    if (binHeap->Key[pos] > min + edge->Weight) { // if the vertex is in binHeap, update its distance
                        binHeap = BinHeapDecreaseKey(binHeap, pos, min + edge->Weight);
                    }
                }
            }
            
        }
    }
    
    free(Known);
    BinHeapDispose(binHeap);      
    return dist_end;
    // return 0xFFFFFFFF; // for debug
}
        
int main()
{
    FILE *mapFile, *queryFile, *AnsFile;
    int num_vertex, num_edge, from, to;
    unsigned int length;
    char line_type[3], temp_str[101];
    Graph G;

    // try opening the files
    mapFile = fopen("map.txt", "r");
    queryFile = fopen("query.txt", "r");
    AnsFile = fopen("ans_bina.txt", "w");
    if (!mapFile || !queryFile || !AnsFile) {
        fprintf(stderr, "Unable to open file"); exit(0);
    }
    
    // input size of graph
    fscanf(mapFile, "%s", line_type);
    while (line_type[0] == 'c') { // processing the format
        fgets(temp_str, 100, mapFile);
        fscanf(mapFile, "%s", line_type);
    }
    fscanf(mapFile, "%s%d%d", temp_str, &num_vertex, &num_edge);
    G = InitGraph(num_vertex);

    // input edges
    while (fscanf(mapFile, "%s", line_type) == 1) {
        if (line_type[0] != 'a') {
            fgets(temp_str, 100, mapFile);
        }
        else { // this line contains a directed edge
            fscanf(mapFile, "%d%d%u", &from, &to, &length);
            AddEdge(from, to, length, G);
        }
    }

    // process queries
    while (fscanf(queryFile, "%d%d", &from, &to) == 2) {
        fprintf(AnsFile, "%u\n", Dijkstra(from, to, G));
    }


    // close files 
    fclose(mapFile);
    fclose(queryFile);
    fclose(AnsFile);

    return 0;
}
