#include "RadixHeap.h"
#include <stdio.h>
#include <stdlib.h>

FILE *mapFile, *queryFile, *AnsFile;

/****** Definitions and operations of the graph ******/
typedef struct AdjvStruct *PtrToAdjv;
struct AdjvStruct {      /* Stores a directed edge */
    int Adjv;            /* The end vertex of the directed edge */
    long long Weight; /* The weight of the directed edge */
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
void AddEdge(int start, int end, long long weight, Graph G)
{
    PtrToAdjv current = (PtrToAdjv)malloc(sizeof(struct AdjvStruct));
    if (!current) {
        fprintf(stderr, "Memory allocation failed.");
        exit(0);
    }
    current->Adjv = end;
    current->Weight = weight;
    current->Next = G->V[start];
    G->V[start] = current; /* insert to the front of the linked list */
#ifdef __DEBUG__
    fprintf(AnsFile, "(%d, %d)[%lld] added\n", start, end, weight);
#endif
}

/***** Implementation of Dijkstra Algorithm *****/
long long Dijkstra(int start, int end, Graph G)
{
    Heap H = CreateHeap(G->Nv, MAX_ARC);
    long long dist_end = LL_INF;
    
    // Known[i]: whether the shortest distance to i is known
    int *Known = (int *)calloc(G->Nv + 1, sizeof(int)); // Known[1..Nv] = 0
    
    Insert(start, 0, H);
    
    while (1) {
        Node v = DeleteMin(H); // v is smallest unknown distance vertex
        PtrToAdjv edge;
        
        // fprintf(AnsFile, "%d(%lld)\n", v->vertex, v->key);

        if (v->vertex == end) { // if v is the queried vertex, the answer is found
            dist_end = v->key;
            break;
        }
        
        Known[v->vertex] = 1; // v is known
        for (edge = G->V[v->vertex]; edge; edge = edge->Next) {
            if (!Known[edge->Adjv]) { // adjv is not known
                long long dist_adjv = GetKey(edge->Adjv, H);
                if (dist_adjv == LL_INF) { // if adjv not in heap, insert it
                    Insert(edge->Adjv, v->key + edge->Weight, H);
                }
                else if (v->key + edge->Weight < dist_adjv) { // if adjv in heap, try relaxing this edge
                    DecreaseKey(edge->Adjv, v->key + edge->Weight, H);
                }
            }
        }
        free(v);
    }
    
    free(Known);
    DisposeHeap(H);      
    return dist_end; 
}
        
int main()
{
    int num_vertex, num_edge, from, to;
    long long length;
    char line_type[3], temp_str[101];
    Graph G;

    // try opening the files
    mapFile = fopen("map.txt", "r");
    queryFile = fopen("query.txt", "r");
    AnsFile = fopen("rh_ans.txt", "w");
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
            fscanf(mapFile, "%d%d%lld", &from, &to, &length);
            AddEdge(from, to, length, G);
        }
    }

    // process queries
    while (fscanf(queryFile, "%d%d", &from, &to) == 2) {
        fprintf(AnsFile, "%lld\n", Dijkstra(from, to, G));
    }

	fclose(mapFile);
	fclose(queryFile);
	fclose(AnsFile);
	
    return 0;
}
