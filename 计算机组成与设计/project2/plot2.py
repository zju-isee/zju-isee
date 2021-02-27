import os
import re
import numpy as np
from matplotlib import pyplot as plt

rootDir = "./myOut_2"
fileArray = ["cc_stats_4_memory_bandwidth.txt", "spice_stats_4_memory_bandwidth.txt", "tex_stats_4_memory_bandwidth.txt"]
writePolicy = ["WT", "WB"]
allocPolicy = ["WA", "WNA"]
cache_size = ["8K", "16K"]
block_size = ["64", "128"]
assoc = ["2", "4"]

for i, fileName in enumerate(fileArray):
    filePath = os.path.join(rootDir, fileName)
    db = []
    cb = []
    with open(filePath, 'r') as f:
        lines = f.readlines()
        for line in lines:
            if "demand fetch" in line:
                line = re.split(r'[:()\s]', line)
                line = [x for x in line if x != '']
                db.append(int(line[-1]))
            if "copies back" in line:
                line = re.split(r'[:()\s]', line)
                line = [x for x in line if x != '']
                cb.append(int(line[-1]))
        f.close()
    for k in range(4):
        fig = plt.figure(figsize=(12, 12))
        DB = db[k*8:(k+1)*8]
        CB = cb[k*8:(k+1)*8]
        bar_width = 0.3  # 条形宽度
        x = np.arange(2)
        WNA = x - bar_width/2
        WA = x + bar_width/2
        for i in range(4):
            ax = fig.add_subplot(2, 2, i + 1)
            if i == 0:
                ax.bar(WNA, [CB[3], CB[7]], align="center", color='c', width=bar_width, alpha=0.5)
                ax.bar(WA, [CB[1], CB[5]], align="center", color = 'b', width = bar_width, alpha=0.5)
                ax.set_title("WB", fontsize = 16)
                ax.set_ylabel('demand fetch', fontsize = 16)

            if i == 1:
                ax.bar(WNA, [CB[2], CB[6]], align="center", color = 'c', width = bar_width, alpha=0.5)
                ax.bar(WA, [CB[0], CB[4]], align="center", color = 'b', width = bar_width, alpha=0.5)
                ax.set_title("WT", fontsize = 16)

            if i == 2:
                ax.bar(WNA, [DB[3], DB[7]], align="center", color='c', width=bar_width, alpha=0.5)
                ax.bar(WA, [DB[1], DB[5]], align="center", color = 'b', width = bar_width, alpha=0.5)
                ax.set_ylabel('copies back', fontsize = 16)

            if i == 3:
                ax.bar(WNA, [DB[2], DB[6]], align="center", color = 'c', width = bar_width, alpha=0.5)
                ax.bar(WA, [DB[0], DB[4]], align="center", color = 'b', width = bar_width, alpha=0.5)
            ax.set_xticks(x)
            ax.set_xticklabels(assoc)
            # ax.set_xlabel('cache size')
            # ax.set_xlabel('block size')
            # ax.set_xlabel('associatity')
            # ax.set_ylabel('hit rate')
            # ax.legend(loc='lower left')
        plt.suptitle("cache size = "+cache_size[k//2]+ "    block size = "+block_size[k%2], fontsize = 24)
        plt.savefig("./figs/"+fileName.split('_')[0]+str(k+1)+".png")
        plt.show()


