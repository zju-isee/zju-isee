#include <stdio.h>
#include <stdlib.h>
#include "FibHeap.h"

/****** Definitions and operations of the graph ******/
typedef struct AdjvStruct* PtrToAdjv;
struct AdjvStruct {      /* Stores a directed edge */
	int Adjv;            /* The end vertex of the directed edge */
	unsigned int Weight; /* The weight of the directed edge */
	PtrToAdjv Next;      /* The next directed edge that shares the intial vertex */
};
typedef struct GraphStruct* Graph;
struct GraphStruct {    /* The structures stores info of the graph */
	int Nv;             /* Number of vertice */
	PtrToAdjv* V;       /* V[i]: the first vertex adjacent to vertex i */
};

/* InitGraph(v)                                 *
 * Returns an initialized graph of v vertices. */
Graph InitGraph(int v)
{
	Graph G = (Graph)malloc(sizeof(struct GraphStruct));
	G->Nv = v;
	G->V = (PtrToAdjv*)calloc(v + 1, sizeof(PtrToAdjv*));
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
int Dijkstra(int start, int end, Graph G)
{
	FHeap H = fibHeapCreate(G->Nv);
	long long dist_end = LL_INF;

	// Known[i]: whether the shortest distance to i is known
	int* Known = (int*)calloc(G->Nv + 1, sizeof(int)); // Known[1..Nv] = 0

	fibInsert(start, 0, H);

	while (1) {
		Node ThisNode = fibDeleteMin(H);
		int v = ThisNode->vertex;
		long long dist_v = ThisNode->key;
		PtrToAdjv edge;

		Known[v] = 1;
		if (v == end) { // if v is the queried vertex, the answer is found
			dist_end = dist_v;
			break;
		}

		for (edge = G->V[v]; edge; edge = edge->Next) {
			if (!Known[edge->Adjv]) { // adjv is not known
				long long dist_adjv = fibGetKey(edge->Adjv, H);
				if (dist_adjv == LL_INF) { // if adjv not in heap, insert it
					fibInsert(edge->Adjv, dist_v + edge->Weight, H);
				}
				else if (dist_v + edge->Weight < dist_adjv) { // if adjv in heap, try relaxing this edge
					fibDecreaseKey(edge->Adjv, dist_v + edge->Weight, H);
				}
			}
		}
	}

	free(Known);
	fibDispose(H);

	return dist_end;
	// return 0xFFFFFFFF; // for debug
}

int main()
{
	FILE* mapFile, * queryFile, * AnsFile;
	int num_vertex, num_edge, from, to;
	int length;
	char line_type[3], temp_str[101];
	Graph G;

	// try opening the files
	mapFile = fopen("..\\data\\map.txt", "r");
	queryFile = fopen("..\\data\\query.txt", "r");
	AnsFile = fopen("..\\data\\fib_ans.txt", "w");
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
			fscanf(mapFile, "%d%d%d", &from, &to, &length);
			AddEdge(from, to, length, G);
		}
	}

	// process queries
	while (fscanf(queryFile, "%d%d", &from, &to) == 2) {
		fprintf(AnsFile, "%d\n", Dijkstra(from, to, G));
	}

	return 0;
}
