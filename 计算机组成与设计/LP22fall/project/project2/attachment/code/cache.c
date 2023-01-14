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
void init_cache_(cache *c, int size)
{

  c->size           = size;
  c->associativity  = cache_assoc;
  c->n_sets         = size/(cache_assoc * cache_block_size);    //set数 = cache的大小/每个set的大小
  c->LRU_head       = (Pcache_line *)malloc(sizeof(Pcache_line)*(c->n_sets));
  c->LRU_tail       = (Pcache_line*)malloc(sizeof(Pcache_line)*(c->n_sets));
  c->set_contents   = (int*)malloc(sizeof(int)*(c->n_sets));
  c->contents       = 0;

  c->index_mask_offset  = LOG2(cache_block_size);
  c->index_mask = ((1<<LOG2(c->n_sets))-1) << c->index_mask_offset ;
  for(int i=0; i< c->n_sets; i++)
  {
      c->LRU_head[i] = NULL;
      c->LRU_tail[i] = NULL;
      c->set_contents[i] = 0;
  }

}
/************************************************************/


/************************************************************/
void init_cache()
{

  if(cache_split)
  {
    init_cache_(&c1, cache_isize);
    init_cache_(&c2, cache_dsize);  // 如果需要cache分离，则c1用作指令cache，c2用作数据cache
  }
  else
    init_cache_(&c1, cache_usize);

  // 把统计量都初始化为0
  cache_stat_inst.accesses        = 0;
  cache_stat_inst.misses          = 0;
  cache_stat_inst.replacements    = 0;
  cache_stat_inst.demand_fetches  = 0;
  cache_stat_inst.copies_back     = 0;
  
  cache_stat_data.accesses        = 0;
  cache_stat_data.misses          = 0;
  cache_stat_data.replacements    = 0;
  cache_stat_data.demand_fetches  = 0;
  cache_stat_data.copies_back     = 0;

}
/************************************************************/

void perform_data_load(cache* dcache, unsigned addr)
{
  int index;
  unsigned int bitsSet, bitsOffset,tagMask,tag;
  int block_size_in_words = cache_block_size/WORD_SIZE;

  // 计算tag
  bitsSet = LOG2(dcache->n_sets);
  bitsOffset = LOG2(cache_block_size);
  tagMask = 0xFFFFFFFF << (bitsOffset + bitsSet);
  // 按位与运算获取地址高位->tag
  tag = addr & tagMask;

  // 取出index对应的bit后，要右移对应的偏移量以得到正确的结果
  index = (addr & dcache->index_mask) >> dcache->index_mask_offset;

  cache_stat_data.accesses++;

  if(dcache->LRU_head[index] == NULL)
  {  
      // 冷启动阶段，cache中一条记录都没有
      cache_stat_data.misses++;
      cache_stat_data.demand_fetches += block_size_in_words;
      
      Pcache_line new_item = malloc(sizeof(cache_line));
      
      new_item->tag = tag;
      new_item->dirty = 0;
      dcache->set_contents[index] = 1;
      insert(&dcache->LRU_head[index], &dcache->LRU_tail[index], new_item);

  }
  else
  {
  	
    if(dcache->set_contents[index] == dcache->associativity)
    {
      // 当前组已满，则首先检查是对应地址的数据是否已经在cache中
      // 若在，cache hit，修改LRU即可
      // 若不在，cache miss，需要替换掉最久之前访问的记录
      
      Pcache_line cache_line = dcache->LRU_head[index];
      int tag_found = FALSE; 

      // 遍历已有的记录，查找对应地址的数据是否已经在cache中
      while(cache_line)
      {
        if(cache_line->tag == tag)
        {
          tag_found = TRUE;
          break;
        }
        cache_line = cache_line->LRU_next;
      }


      if(tag_found) // cache hit，调整LRU，将访问的记录加到链表头（表示最近访问）
      {
      	delete(&dcache->LRU_head[index], &dcache->LRU_tail[index], cache_line);
      	insert(&dcache->LRU_head[index], &dcache->LRU_tail[index], cache_line);
      }
      else
      {
        //  cache miss，替换掉最久之前访问的记录
      	cache_stat_data.demand_fetches += block_size_in_words;
      	cache_stat_data.misses++;
      	cache_stat_data.replacements++;

      	if(dcache->LRU_tail[index]->dirty) // 如果dirty bit=1，说明该数据在cache中被修改过，需要写回内存
          cache_stat_data.copies_back += block_size_in_words;

      	Pcache_line new_item = malloc(sizeof(cache_line));
      	new_item->tag = tag;
      	new_item->dirty = 0;
        
        // 移除最久之前访问的记录
      	delete(&dcache->LRU_head[index], &dcache->LRU_tail[index], dcache->LRU_tail[index]);
        // 将新的记录添加到LRU的链表头
      	insert(&(dcache->LRU_head[index]), &(dcache->LRU_tail[index]), new_item);
      }
    }
    else
    { 
      //  如果尚有valid bit=0的行，那么在cache miss的情况下，优先写入该行
      int tag_found = FALSE; 
      Pcache_line cache_line = dcache->LRU_head[index];

      // 遍历已有的记录，查找对应地址的数据是否已经在cache中
      while(cache_line)
      {
        if(cache_line->tag == tag)
        {
          tag_found = TRUE;
          break;
        }
        cache_line = cache_line->LRU_next;
      }

      if(tag_found) // cache hit，调整LRU，将访问的记录加到链表头（表示最近访问）
      {
      	delete(&dcache->LRU_head[index], &dcache->LRU_tail[index], cache_line);
      	insert(&dcache->LRU_head[index], &dcache->LRU_tail[index], cache_line);
      }
      else // cache miss
      { 

      	cache_stat_data.demand_fetches += block_size_in_words;
      	cache_stat_data.misses++;

      	Pcache_line new_item = malloc(sizeof(cache_line));
      	new_item->tag = tag;
      	new_item->dirty = 0;

        // 将新写入的记录加到LRU链表头
      	insert(&(dcache->LRU_head[index]), &(dcache->LRU_tail[index]), new_item);

      	dcache->set_contents[index]++;  // entry数++
      }
    }
  }
}

void perform_data_store(cache* dcache, unsigned addr)
{
  int index;
  unsigned int bitsSet, bitsOffset,tagMask,tag;
  int block_size_in_words = cache_block_size/WORD_SIZE;

  // 计算tag
  bitsSet = LOG2(dcache->n_sets);
  bitsOffset = LOG2(cache_block_size);
  // 按位与运算获取地址高位->tag
  tagMask = 0xFFFFFFFF << (bitsOffset + bitsSet);
  tag = addr & tagMask;

  // 取出index对应的bit后，要右移对应的偏移量以得到正确的结果
  index = (addr & dcache->index_mask) >> dcache->index_mask_offset;

  cache_stat_data.accesses++;

  if(dcache->LRU_head[index] == NULL)
  {
    // 冷启动阶段，cache中一条记录都没有
		// 使用write-no-allocate策略的时候，如果记录不在cache中，只更新memory，不需要把数据搬到cache中
    // 否则，需要先把数据fetch到cache中，然后再按照write hit的情况来处理
    if(cache_writealloc==0)
    {
      cache_stat_data.copies_back++;
      cache_stat_data.misses++;
    }
    else
    {        
	    cache_stat_data.misses++;
	    cache_stat_data.demand_fetches += block_size_in_words;
	    
	    Pcache_line new_item = malloc(sizeof(cache_line));
	    
	    new_item->tag = tag;
	    new_item->dirty = 1;

	    // 使用write through策略时，更新cache数据时，同时也要更新memory
      if(cache_writeback==0)
      {
        cache_stat_data.copies_back += 1;
        new_item->dirty = 0; // 写回后，dirty bit需要清零
      }

	    dcache->set_contents[index] = 1;
	    insert(&dcache->LRU_head[index], &dcache->LRU_tail[index], new_item);
	  }
	}
  else // cache中有记录
  {     
    // cache非空，则先检查记录是否在cache中
    // 若在，则写入，并根据写回策略决定是否写入memory还是更改dirty bit
	  if(dcache->set_contents[index] == dcache->associativity)
    {
	    // 该组已满

      int tag_found = FALSE; 
      Pcache_line cache_line = dcache->LRU_head[index];

      // 遍历已有的记录，查找对应地址的数据是否已经在cache中
      while(cache_line)
      {
        if(cache_line->tag == tag)
        {
          tag_found = TRUE;
          break;
        }
        cache_line = cache_line->LRU_next;
      }

      if(tag_found) // cache hit，调整LRU，将访问的记录加到链表头（表示最近访问）
      {
      	delete(&dcache->LRU_head[index], &dcache->LRU_tail[index], cache_line);
      	insert(&dcache->LRU_head[index], &dcache->LRU_tail[index], cache_line);
 
	    	// dirty bit置1
	    	dcache->LRU_head[index]->dirty = 1;

        // 使用write through策略时，更新cache数据时，同时也要更新memory
        if(cache_writeback==0)
        {
          cache_stat_data.copies_back += 1;
          dcache->LRU_head[index]->dirty = 0; // 写回后，dirty bit需要清零
        }
	    }
      else
      {
        // cache miss
        // 如果使用write no allocate策略的时候，如果记录不在内存中，只更新memory，不需要把数据搬到cache中
        // 否则，需要从memory中fetch数据，而又因为该组已满，所以需要执行LRU替换
        if(cache_writealloc==0)
        {
          cache_stat_data.copies_back += 1;
          cache_stat_data.misses++;
        }
	    	else
        {
          cache_stat_data.demand_fetches += block_size_in_words;
          cache_stat_data.misses++;
          cache_stat_data.replacements++;

          Pcache_line new_item = malloc(sizeof(cache_line));
          new_item->tag = tag;
          new_item->dirty = 1;

      	  if(dcache->LRU_tail[index]->dirty) // 如果dirty bit=1，说明该数据在cache中被修改过，需要写回
      	    cache_stat_data.copies_back += block_size_in_words;

          // 使用write through策略时，更新cache数据时，同时也要更新memory
          if(cache_writeback==0)
          {
            cache_stat_data.copies_back += 1;
            new_item->dirty = 0; // 写回后，dirty bit需要清零
          }

          // 移除最久之前访问的记录
          delete(&dcache->LRU_head[index], &dcache->LRU_tail[index], dcache->LRU_tail[index]);
          // 将新的记录添加到LRU的链表头
          insert(&(dcache->LRU_head[index]), &(dcache->LRU_tail[index]), new_item);
        }
	    }
	  }
    else  // cache中尚有valid bit=0的记录
    {

      //  尚有valid bit=0的行，那么在cache miss的情况下，优先写入该行
      int tag_found = FALSE; 
      Pcache_line cache_line = dcache->LRU_head[index];

      // 遍历已有的记录，查找对应地址的数据是否已经在cache中
      while(cache_line)
      {
        if(cache_line->tag == tag)
        {
          tag_found = TRUE;
          break;
        }
        cache_line = cache_line->LRU_next;
      }

      if(tag_found) // cache hit，调整LRU，将访问的记录加到链表头（表示最近访问）
      {
      	delete(&dcache->LRU_head[index], &dcache->LRU_tail[index], cache_line);
      	insert(&dcache->LRU_head[index], &dcache->LRU_tail[index], cache_line);
 
	    	// dirty bit置1
	    	dcache->LRU_head[index]->dirty = 1;

        // 使用write through策略时，更新cache数据时，同时也要更新memory
        if(cache_writeback==0)
        {
          cache_stat_data.copies_back += 1;
          dcache->LRU_head[index]->dirty = 0; // 写回后，dirty bit需要清零
        }
	    }
      else
      {
        // cache miss
        // 如果使用write no allocate策略的时候，如果记录不在内存中，只更新memory，不需要把数据搬到cache中
        // 否则，需要从memory中fetch数据，又因为该组已满，所以需要执行LRU替换
        if(cache_writealloc==0)
        {
          cache_stat_data.copies_back += 1;
          cache_stat_data.misses++;
        }
        else
        {
	    	  cache_stat_data.demand_fetches += block_size_in_words;
	    	  cache_stat_data.misses++;

          Pcache_line new_item = malloc(sizeof(cache_line));
          new_item->tag = tag;
          new_item->dirty = 1;

          // 使用write through策略时，向cache写入数据时，同时也要向memory写一份
          if(cache_writeback==0)
          {
            cache_stat_data.copies_back += 1;
            new_item->dirty = 0; // 写回后，dirty bit需要清零
          }      

          // 将新的记录添加到LRU的链表头
          insert(&(dcache->LRU_head[index]), &(dcache->LRU_tail[index]), new_item);

          dcache->set_contents[index]++; // entry++
        }
	    }
	  }
	}
}

// inst load和 data load如果不使用cache分离时除统计量不同外，其他则完全一致，而cache分离时只是所使用的cache不同而已，整个过程是一样的
void perform_inst_load(cache* icache,unsigned addr)
{
  int index;
  unsigned int bitsSet, bitsOffset,tagMask,tag;
  int block_size_in_words = cache_block_size/WORD_SIZE;

  // 计算tag
  bitsSet = LOG2(icache->n_sets);
  bitsOffset = LOG2(cache_block_size);
  tagMask = 0xFFFFFFFF << (bitsOffset + bitsSet);
  // 按位与运算获取地址高位->tag
  tag = addr & tagMask;

  // 取出index对应的bit后，要右移对应的偏移量以得到正确的结果
  index = (addr & icache->index_mask) >> icache->index_mask_offset;

	cache_stat_inst.accesses++;

	if(icache->LRU_head[index] == NULL)
  {
    // 冷启动阶段，cache中一条记录都没有
    cache_stat_inst.misses++;
    cache_stat_inst.demand_fetches += block_size_in_words;
    
    Pcache_line new_item = malloc(sizeof(cache_line));
	    
    new_item->tag = tag;
    new_item->dirty = 0;
    icache->set_contents[index] = 1;
    insert(&icache->LRU_head[index], &icache->LRU_tail[index], new_item);
	}
  else
  {
	  if(icache->set_contents[index] == icache->associativity)
    {
      // 当前组已满，则首先检查是对应地址的数据是否已经在cache中
      // 若在，cache hit，修改LRU即可
      // 若不在，cache miss，需要替换掉最久之前访问的记录
	    
      Pcache_line cache_line = icache->LRU_head[index];
      int tag_found = FALSE; 

      // 遍历已有的记录，查找对应地址的数据是否已经在cache中
      while(cache_line)
      {
        if(cache_line->tag == tag)
        {
          tag_found = TRUE;
          break;
        }
        cache_line = cache_line->LRU_next;
      }

      if(tag_found) // cache hit，调整LRU，将访问的记录加到链表头（表示最近访问）
      {
      	delete(&icache->LRU_head[index], &icache->LRU_tail[index], cache_line);
      	insert(&icache->LRU_head[index], &icache->LRU_tail[index], cache_line);
      }
      else
      {
        //  cache miss，替换掉最久之前访问的记录
      	cache_stat_inst.demand_fetches += block_size_in_words;
      	cache_stat_inst.misses++;
      	cache_stat_inst.replacements++;

      	if(icache->LRU_tail[index]->dirty) // 如果dirty bit=1，说明该数据在cache中被修改过，需要写回
          cache_stat_inst.copies_back += block_size_in_words;

      	Pcache_line new_item = malloc(sizeof(cache_line));
      	new_item->tag = tag;
      	new_item->dirty = 0;
        
        // 移除最久之前访问的记录
      	delete(&icache->LRU_head[index], &icache->LRU_tail[index], icache->LRU_tail[index]);
        // 将新的记录添加到LRU的链表头
      	insert(&(icache->LRU_head[index]), &(icache->LRU_tail[index]), new_item);
	    }
	  }
    else
    {
      //  如果尚有valid bit=0的行，那么在cache miss的情况下，优先写入该行
      int tag_found = FALSE; 
      Pcache_line cache_line = icache->LRU_head[index];

      // 遍历已有的记录，查找对应地址的数据是否已经在cache中
      while(cache_line)
      {
        if(cache_line->tag == tag)
        {
          tag_found = TRUE;
          break;
        }
        cache_line = cache_line->LRU_next;
      }

      if(tag_found) // cache hit，调整LRU，将访问的记录加到链表头（表示最近访问）
      {
      	delete(&icache->LRU_head[index], &icache->LRU_tail[index], cache_line);
      	insert(&icache->LRU_head[index], &icache->LRU_tail[index], cache_line);
      }
      else // cache miss
      {
	    	cache_stat_inst.demand_fetches += block_size_in_words;
	    	cache_stat_inst.misses++;

	    	Pcache_line new_item = malloc(sizeof(cache_line));
	    	new_item->tag = tag;
	    	new_item->dirty = 0;

        // 将新写入的记录加到LRU链表头
      	insert(&(icache->LRU_head[index]), &(icache->LRU_tail[index]), new_item);

      	icache->set_contents[index]++;  // entry数++
	    }
	  }
	}
}


/************************************************************/
void perform_access(addr, access_type)
  unsigned addr, access_type;
{
  if(cache_split)
  {
    icache = &c1;
    dcache = &c2;
  }
  else
  {
    icache = &c1;
    dcache = &c1;
  }

  switch (access_type)
  {
  case TRACE_DATA_LOAD:       // data load
    perform_data_load(dcache, addr);
    break;
  case TRACE_DATA_STORE:      // data store
    perform_data_store(dcache, addr);
    break;
  case TRACE_INST_LOAD:       // instruction load
    perform_inst_load(icache, addr);
    break;
  default:
    break;
  }

}
/************************************************************/

/************************************************************/
void flush()
{

  int block_size_in_words = cache_block_size/WORD_SIZE;
  Pcache_line cache_line;

  for(int i=0; i < c1.n_sets; i++)
  {
  	cache_line = c1.LRU_head[i];

  	for(int j = 0; j < c1.set_contents[i]; j++)
    {
  	  if(cache_line->dirty)   // 如果dirty bit为1，则需要写回memory
        cache_stat_data.copies_back += block_size_in_words;
  		
      cache_line = cache_line->LRU_next;
  	}
  }
  // 如果使用分离的cache，则需要对c2执行同样的操作
  if(cache_split)
  {
    for(int i=0; i < c2.n_sets; i++)
    {
    	cache_line = c2.LRU_head[i];

    	for(int j = 0; j < c2.set_contents[i]; j++)
      {
    	  if(cache_line->dirty)
          cache_stat_inst.copies_back += block_size_in_words;
    		
        cache_line = cache_line->LRU_next;
    	}
    }
  }

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
