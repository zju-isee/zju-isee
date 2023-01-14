
/*
 * main.c
 */


#include <stdlib.h>
#include <stdio.h>
#include "cache.h"
#include "main.h"

static FILE *traceFile;


int main(argc, argv)
  int argc;
  char **argv;
{
  parse_args(argc, argv);
  init_cache();
  play_trace(traceFile);
  print_stats();
}


/************************************************************/
void parse_args(argc, argv)
  int argc;
  char **argv;
{
  int arg_index, i, value;

  if (argc < 2) {
    printf("usage:  sim <options> <trace file>\n");
    exit(-1);
  }

  /* parse the command line arguments */
  for (i = 0; i < argc; i++)
    if (!strcmp(argv[i], "-h")) {
      printf("\t-h:  \t\tthis message\n\n");
      printf("\t-bs <bs>: \tset cache block size to <bs>\n");
      printf("\t-us <us>: \tset unified cache size to <us>\n");
      printf("\t-is <is>: \tset instruction cache size to <is>\n");
      printf("\t-ds <ds>: \tset data cache size to <ds>\n");
      printf("\t-a <a>: \tset cache associativity to <a>\n");
      printf("\t-wb: \t\tset write policy to write back\n");
      printf("\t-wt: \t\tset write policy to write through\n");
      printf("\t-wa: \t\tset allocation policy to write allocate\n");
      printf("\t-nw: \t\tset allocation policy to no write allocate\n");
      exit(0);
    }
    
  arg_index = 1;
  while (arg_index != argc - 1) {

    /* set the cache simulator parameters */

    if (!strcmp(argv[arg_index], "-bs")) {
      value = atoi(argv[arg_index+1]);
      set_cache_param(CACHE_PARAM_BLOCK_SIZE, value);
      arg_index += 2;
      continue;
    }

    if (!strcmp(argv[arg_index], "-us")) {
      value = atoi(argv[arg_index+1]);
      set_cache_param(CACHE_PARAM_USIZE, value);
      arg_index += 2;
      continue;
    }

    if (!strcmp(argv[arg_index], "-is")) {
      value = atoi(argv[arg_index+1]);
      set_cache_param(CACHE_PARAM_ISIZE, value);
      arg_index += 2;
      continue;
    }

    if (!strcmp(argv[arg_index], "-ds")) {
      value = atoi(argv[arg_index+1]);
      set_cache_param(CACHE_PARAM_DSIZE, value);
      arg_index += 2;
      continue;
    }

    if (!strcmp(argv[arg_index], "-a")) {
      value = atoi(argv[arg_index+1]);
      set_cache_param(CACHE_PARAM_ASSOC, value);
      arg_index += 2;
      continue;
    }

    if (!strcmp(argv[arg_index], "-wb")) {
      set_cache_param(CACHE_PARAM_WRITEBACK, value);
      arg_index += 1;
      continue;
    }

    if (!strcmp(argv[arg_index], "-wt")) {
      set_cache_param(CACHE_PARAM_WRITETHROUGH, value);
      arg_index += 1;
      continue;
    }

    if (!strcmp(argv[arg_index], "-wa")) {
      set_cache_param(CACHE_PARAM_WRITEALLOC, value);
      arg_index += 1;
      continue;
    }

    if (!strcmp(argv[arg_index], "-nw")) {
      set_cache_param(CACHE_PARAM_NOWRITEALLOC, value);
      arg_index += 1;
      continue;
    }

    printf("error:  unrecognized flag %s\n", argv[arg_index]);
    exit(-1);

  }

  dump_settings();

  /* open the trace file */
  traceFile = fopen(argv[arg_index], "r");

  return;
}
/************************************************************/

/************************************************************/
void play_trace(inFile)
  FILE *inFile;
{
  unsigned addr, data, access_type;
  int num_inst;

  num_inst = 0;
  while(read_trace_element(inFile, &access_type, &addr)) {

    switch (access_type) {
    case TRACE_DATA_LOAD:
    case TRACE_DATA_STORE:
    case TRACE_INST_LOAD:
      perform_access(addr, access_type);
      break;

    default:
      printf("skipping access, unknown type(%d)\n", access_type);
    }

    num_inst++;
    if (!(num_inst % PRINT_INTERVAL))
      printf("processed %d references\n", num_inst);
  }

  flush();
}
/************************************************************/

/************************************************************/
int read_trace_element(inFile, access_type, addr)
  FILE *inFile;
  unsigned *access_type, *addr;
{
  int result;
  char c;

  result = fscanf(inFile, "%u %x%c", access_type, addr, &c);
  while (c != '\n') {
    result = fscanf(inFile, "%c", &c);
    if (result == EOF) 
      break;
  }
  if (result != EOF)
    return(1);
  else
    return(0);
}
/************************************************************/
