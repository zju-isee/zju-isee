import os
import re
import numpy as np
from matplotlib import pyplot as plt

rootDir = "./myOut_2"
# fileArray = ["cc_stats_1_wsc.txt", "spice_stats_1_wsc.txt", "tex_stats_1_wsc.txt"]
#fileArray = ["cc_stats_2_block.txt", "spice_stats_2_block.txt", "tex_stats_2_block.txt"]
# fileArray = ["cc_stats_3_assoc.txt", "spice_stats_3_assoc.txt", "tex_stats_3_assoc.txt"]

fig = plt.figure(figsize=(20, 6))

for i, fileName in enumerate(fileArray):
    filePath = os.path.join(rootDir, fileName)
    flag = 0
    # D_cache_size = []
    # I_cache_size = []
    # block_size = []
    assoc = []
    D_hit_rate = []
    I_hit_rate = []
    with open(filePath, 'r') as f:
        lines = f.readlines()
        for line in lines:
            # if "I-cache size" in line:
            #     line = re.split(r'[:()\s]', line)
            #     line = [x for x in line if x != '']
            #     I_cache_size.append(np.log2(int(line[-1])))
            # if "D-cache size" in line:
            #     line = re.split(r'[:()\s]', line)
            #     line = [x for x in line if x != '']
            #     D_cache_size.append(np.log2(int(line[-1])))
            # if "Block size" in line:
            #     line = re.split(r'[:()\s]', line)
            #     line = [x for x in line if x != '']
            #     block_size.append(np.log2(int(line[-1])))
            if "Associativity" in line:
                line = re.split(r'[:()\s]', line)
                line = [x for x in line if x != '']
                assoc.append(np.log2(int(line[-1])))
            if "hit rate" in line:
                line = re.split(r'[:()\s]', line)
                line = [x for x in line if x != '']
                if flag == 0:
                    I_hit_rate.append(float(line[-1]))
                else:
                    D_hit_rate.append(float(line[-1]))
                flag = ~flag
        f.close()
        ax = fig.add_subplot(1, 3, i + 1)
        # ax.plot(D_cache_size, D_hit_rate, c='b', label='D-cache')
        # ax.plot(I_cache_size, I_hit_rate, c='r', label='I-cache')
        # ax.plot(block_size, D_hit_rate, c='b', label='D-cache')
        # ax.plot(block_size, I_hit_rate, c='r', label='I-cache')
        ax.plot(assoc, D_hit_rate, c='b', label='D-cache')
        ax.plot(assoc, I_hit_rate, c='r', label='I-cache')
        ax.set_title(fileName.split('_')[0])
        # ax.set_xlabel('cache size')
        # ax.set_xlabel('block size')
        ax.set_xlabel('associatity')
        ax.set_ylabel('hit rate')
        ax.legend(loc='lower right')
        # ax.legend(loc='lower left')

# plt.savefig("./figs/workingset.png")
# plt.savefig("./figs/blocksize.png")
plt.savefig("./figs/associatity.png")
plt.show()


