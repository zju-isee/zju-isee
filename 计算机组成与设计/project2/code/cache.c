/*
 * cache.c
 */


#include <stdlib.h>
#include <stdio.h>
#include <math.h>

#include "cache.h"
#include "main.h"

/* cache configuration parameters */
static int cache_split = 0;
static int cache_usize = DEFAULT_CACHE_SIZE;
static int cache_isize = DEFAULT_CACHE_SIZE; 
static int cache_dsize = DEFAULT_CACHE_SIZE;
static int cache_block_size = DEFAULT_CACHE_BLOCK_SIZE;
static int words_per_block = DEFAULT_CACHE_BLOCK_SIZE / WORD_SIZE;
static int cache_assoc = DEFAULT_CACHE_ASSOC;
static int cache_writeback = DEFAULT_CACHE_WRITEBACK;
static int cache_writealloc = DEFAULT_CACHE_WRITEALLOC;

/* cache model data structures */
static Pcache icache;
static Pcache dcache;
static cache c1;
static cache c2;
static cache_stat cache_stat_inst;
static cache_stat cache_stat_data;

static int count;

/************************************************************/
void set_cache_param(param, value)
  int param;
  int value;
{

  switch (param) {
  case CACHE_PARAM_BLOCK_SIZE:
    cache_block_size = value;
    words_per_block = value / WORD_SIZE;
    break;
  case CACHE_PARAM_USIZE:
    cache_split = FALSE;
    cache_usize = value;
    break;
  case CACHE_PARAM_ISIZE:
    cache_split = TRUE;
    cache_isize = value;
    break;
  case CACHE_PARAM_DSIZE:
    cache_split = TRUE;
    cache_dsize = value;
    break;
  case CACHE_PARAM_ASSOC:
    cache_assoc = value;
    break;
  case CACHE_PARAM_WRITEBACK:
    cache_writeback = TRUE;
    break;
  case CACHE_PARAM_WRITETHROUGH:
    cache_writeback = FALSE;
    break;
  case CACHE_PARAM_WRITEALLOC:
    cache_writealloc = TRUE;
    break;
  case CACHE_PARAM_NOWRITEALLOC:
    cache_writealloc = FALSE;
    break;
  default:
    printf("error set_cache_param: bad parameter value\n");
    exit(-1);
  }

}
/************************************************************/

/************************************************************/
void init_cache_part(cache *c, int size)
{
  c->size = size / WORD_SIZE;
  c->associativity = cache_assoc;
  c->n_sets = c->size / (c->associativity*words_per_block);
  c->index_mask_offset = LOG2(cache_block_size);
  c->index_mask = ((1 << LOG2(c->n_sets))-1) << c->index_mask_offset;
  c->LRU_head = (Pcache_line *)malloc(sizeof(Pcache_line)*c->n_sets);
  c->LRU_tail = (Pcache_line *)malloc(sizeof(Pcache_line)*c->n_sets);
  c->set_contents = (int *)malloc(sizeof(int)*c->n_sets);
  c->contents = 0;

  for (int i = 0; i < c->n_sets; i++) {
    c->LRU_head[i] = NULL;
    c->LRU_tail[i] = NULL;
    c->set_contents[i] = 0;
  }
}


void init_cache()
{
  /* initialize the cache, and cache statistics data structures */
  cache_stat_inst.accesses = 0;
  cache_stat_inst.copies_back = 0;
  cache_stat_inst.demand_fetches = 0;
  cache_stat_inst.misses = 0;
  cache_stat_inst.replacements = 0;

  cache_stat_data.accesses = 0;
  cache_stat_data.copies_back = 0;
  cache_stat_data.demand_fetches = 0;
  cache_stat_data.misses = 0;
  cache_stat_data.replacements = 0;

  if (!cache_split) {
    init_cache_part(&c1, cache_usize);
  } else {
    init_cache_part(&c1, cache_isize);
    init_cache_part(&c2, cache_dsize);
  }
}
/************************************************************/

/************************************************************/
void perform_access(addr, access_type)
  unsigned addr, access_type;
{
  /* handle an access to the cache */
  if (cache_split) {
    icache = &c1;
    dcache = &c2;
  } else {
    icache = &c1;
    dcache = &c1;
  }

  switch (access_type)
  {
  case 0:
  {
    int index = (addr & (dcache->index_mask)) >> (dcache->index_mask_offset);
    unsigned addr_tag = addr >> (LOG2(dcache->n_sets)+dcache->index_mask_offset);
    Pcache_line p = dcache->LRU_head[index];
    Pcache_line p_prev = p;

    while (p) {
      if (p->tag == addr_tag) {
        cache_stat_data.accesses += 1;
        delete(&dcache->LRU_head[index], &dcache->LRU_tail[index], p);
        insert(&dcache->LRU_head[index], &dcache->LRU_tail[index], p);
        break;
      } else {
        p_prev = p;
        p = p->LRU_next;        
      }
    }

    if (p == NULL) {
      cache_stat_data.misses += 1;

      Pcache_line item = (cache_line *)malloc(sizeof(cache_line));
      item->dirty = 0;
      item->LRU_next = NULL;
      item->LRU_prev = NULL;
      item->tag = addr_tag;

      if (dcache->set_contents[index] < dcache->associativity) {
        insert(&dcache->LRU_head[index], &dcache->LRU_tail[index], item);
        dcache->set_contents[index] += 1;
        dcache->contents += 1;
        cache_stat_data.demand_fetches += words_per_block;
      } else {
        if (cache_writeback && p_prev->dirty == 1) {
          cache_stat_data.copies_back += words_per_block;
        }
        cache_stat_data.demand_fetches += words_per_block;
        cache_stat_data.replacements += 1;
        delete(&dcache->LRU_head[index], &dcache->LRU_tail[index], p_prev);
        insert(&dcache->LRU_head[index], &dcache->LRU_tail[index], item);
      }
      cache_stat_data.accesses += 1;
    }  
    break;
  }
  case 1:
  {
    int index = (addr & (dcache->index_mask)) >> (dcache->index_mask_offset);
    unsigned addr_tag = addr >> (LOG2(dcache->n_sets)+dcache->index_mask_offset);
    Pcache_line p = dcache->LRU_head[index];
    Pcache_line p_prev = p;

    while (p) {
      if (p->tag == addr_tag) {
        cache_stat_data.accesses += 1;
        if (!cache_writeback) {
          cache_stat_data.copies_back += 1;
        } 
        delete(&dcache->LRU_head[index], &dcache->LRU_tail[index], p);
        insert(&dcache->LRU_head[index], &dcache->LRU_tail[index], p);
        p->dirty = 1;
        break;
      } else {
        p_prev = p;
        p = p->LRU_next;        
      }
    }

    if (p == NULL) {
      cache_stat_data.misses += 1;

      if (cache_writealloc) {       
        Pcache_line item = (cache_line *)malloc(sizeof(cache_line));
        item->dirty = 1;
        item->LRU_next = NULL;
        item->LRU_prev = NULL;
        item->tag = addr_tag;

        if (dcache->set_contents[index] < dcache->associativity) {
          insert(&dcache->LRU_head[index], &dcache->LRU_tail[index], item);
          dcache->set_contents[index] += 1;
          dcache->contents += 1;
          cache_stat_data.demand_fetches += words_per_block;
        } else {
          if (cache_writeback && p_prev->dirty == 1) {
            cache_stat_data.copies_back += words_per_block;
          }
          cache_stat_data.demand_fetches += words_per_block;
          cache_stat_data.replacements += 1;
          delete(&dcache->LRU_head[index], &dcache->LRU_tail[index], p_prev);
          insert(&dcache->LRU_head[index], &dcache->LRU_tail[index], item);
        }
        if (!cache_writeback) {
          cache_stat_data.copies_back += 1;
        }
      } else {
        cache_stat_data.copies_back += 1;
      }
      cache_stat_data.accesses += 1;
    }
    break;
  }
  case 2:
  {
    int index = (addr & (icache->index_mask)) >> (icache->index_mask_offset);
    unsigned addr_tag = addr >> (LOG2(icache->n_sets)+icache->index_mask_offset);
    Pcache_line p = icache->LRU_head[index];
    Pcache_line p_prev = p;

    while (p) {
      if (p->tag == addr_tag) {
        cache_stat_inst.accesses += 1;
        delete(&icache->LRU_head[index], &icache->LRU_tail[index], p);
        insert(&icache->LRU_head[index], &icache->LRU_tail[index], p);
        break;
      } else {
        p_prev = p;
        p = p->LRU_next;        
      }
    }

    if (p == NULL) {
      cache_stat_inst.misses += 1;

      Pcache_line item = (cache_line *)malloc(sizeof(cache_line));
      item->dirty = 0;
      item->LRU_next = NULL;
      item->LRU_prev = NULL;
      item->tag = addr_tag;

      if (icache->set_contents[index] < icache->associativity) {
        insert(&icache->LRU_head[index], &icache->LRU_tail[index], item);
        icache->set_contents[index] += 1;
        icache->contents += 1;
        cache_stat_inst.demand_fetches += words_per_block;
      } else {
        if (cache_writeback && p_prev->dirty == 1) {
          cache_stat_data.copies_back += words_per_block;
        }
        cache_stat_inst.demand_fetches += words_per_block;
        cache_stat_inst.replacements += 1;
        delete(&icache->LRU_head[index], &icache->LRU_tail[index], p_prev);
        insert(&icache->LRU_head[index], &icache->LRU_tail[index], item);
      }
      cache_stat_inst.accesses += 1;
    }
    break;
  default:
    break;
  }
  } 
}
/************************************************************/

/************************************************************/
void flush()
{

  /* flush the cache */
  for (int i=0; i<c1.n_sets; i++) {
    for (int j=0; j<c1.set_contents[i]; j++) {
      if (cache_writeback && c1.LRU_tail[i]->dirty == 1) 
        cache_stat_data.copies_back += words_per_block;
      delete(&c1.LRU_head[i], &c1.LRU_tail[i], c1.LRU_tail[i]);
    }
    c1.set_contents[i] = 0;
  }
  c1.contents = 0;
  
  for (int i=0; i<c2.n_sets; i++) {
    for (int j=0; j<c2.set_contents[i]; j++) {
      if (cache_writeback && c2.LRU_tail[i]->dirty == 1) 
        cache_stat_data.copies_back += words_per_block;
      delete(&c2.LRU_head[i], &c2.LRU_tail[i], c2.LRU_tail[i]);
    }
    c2.set_contents[i] = 0;
  }
  c2.contents = 0;
}
/************************************************************/

/************************************************************/
void delete(head, tail, item)
  Pcache_line *head, *tail;
  Pcache_line item;
{
  if (item->LRU_prev) {
    item->LRU_prev->LRU_next = item->LRU_next;
  } else {
    /* item at head */
    *head = item->LRU_next;
  }

  if (item->LRU_next) {
    item->LRU_next->LRU_prev = item->LRU_prev;
  } else {
    /* item at tail */
    *tail = item->LRU_prev;
  }
}
/************************************************************/

/************************************************************/
/* inserts at the head of the list */
void insert(head, tail, item)
  Pcache_line *head, *tail;
  Pcache_line item;
{
  item->LRU_next = *head;
  item->LRU_prev = (Pcache_line)NULL;

  if (item->LRU_next)
    item->LRU_next->LRU_prev = item;
  else
    *tail = item;

  *head = item;
}
/************************************************************/

/************************************************************/
void dump_settings()
{
  printf("*** CACHE SETTINGS ***\n");
  if (cache_split) {
    printf("  Split I- D-cache\n");
    printf("  I-cache size: \t%d\n", cache_isize);
    printf("  D-cache size: \t%d\n", cache_dsize);
  } else {
    printf("  Unified I- D-cache\n");
    printf("  Size: \t%d\n", cache_usize);
  }
  printf("  Associativity: \t%d\n", cache_assoc);
  printf("  Block size: \t%d\n", cache_block_size);
  printf("  Write policy: \t%s\n", 
	 cache_writeback ? "WRITE BACK" : "WRITE THROUGH");
  printf("  Allocation policy: \t%s\n",
	 cache_writealloc ? "WRITE ALLOCATE" : "WRITE NO ALLOCATE");
}
/************************************************************/

/************************************************************/
void print_stats()
{
  printf("\n*** CACHE STATISTICS ***\n");

  printf(" INSTRUCTIONS\n");
  printf("  accesses:  %d\n", cache_stat_inst.accesses);
  printf("  misses:    %d\n", cache_stat_inst.misses);
  if (!cache_stat_inst.accesses)
    printf("  miss rate: 0 (0)\n"); 
  else
    printf("  miss rate: %2.4f (hit rate %2.4f)\n", 
	 (float)cache_stat_inst.misses / (float)cache_stat_inst.accesses,
	 1.0 - (float)cache_stat_inst.misses / (float)cache_stat_inst.accesses);
  printf("  replace:   %d\n", cache_stat_inst.replacements);

  printf(" DATA\n");
  printf("  accesses:  %d\n", cache_stat_data.accesses);
  printf("  misses:    %d\n", cache_stat_data.misses);
  if (!cache_stat_data.accesses)
    printf("  miss rate: 0 (0)\n"); 
  else
    printf("  miss rate: %2.4f (hit rate %2.4f)\n", 
	 (float)cache_stat_data.misses / (float)cache_stat_data.accesses,
	 1.0 - (float)cache_stat_data.misses / (float)cache_stat_data.accesses);
  printf("  replace:   %d\n", cache_stat_data.replacements);

  printf(" TRAFFIC (in words)\n");
  printf("  demand fetch:  %d\n", cache_stat_inst.demand_fetches + 
	 cache_stat_data.demand_fetches);
  printf("  copies back:   %d\n", cache_stat_inst.copies_back +
	 cache_stat_data.copies_back);
}
/************************************************************/
