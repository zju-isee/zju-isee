import matplotlib.pyplot as plt
# file_name = "1.txt"
# file_name = "2.txt"
file_name = "3.txt"

I_cache_size = []
D_cache_size = []
I_cache_hitrate = []
D_cache_hitrate = []

file_object1 = open(file_name,'r')
try:
    while True:
        line = file_object1.readline()
        if line:
            l = line.split()
            I_cache_size.append(int(l[2]))
            print ("l=",l)
        else:
            break
        line = file_object1.readline()
        l = line.split()
        D_cache_size.append(int(l[2]))
        print ("l=",l)
        
        line = file_object1.readline()
        l = line.split()
        I_cache_hitrate.append(round(1-float(l[2]),4))
        print ("l=",l)

        line = file_object1.readline()
        l = line.split()
        D_cache_hitrate.append(round(1-float(l[2]),4))
        print ("l=",l)

finally:
    file_object1.close()

print(I_cache_size)
print(D_cache_size)
print(I_cache_hitrate)
print(D_cache_hitrate)

x_range = []
# for i in range(len(I_cache_size)):
#     x_range.append(i*2+2)

# for i in range(len(I_cache_size)):
#     x_range.append(i+2)

for i in range(len(I_cache_size)):
    x_range.append(i)

plt.plot(x_range, I_cache_hitrate, 'ro-', color='#0077bb', alpha=0.6, linewidth=1, label='I')
plt.plot(x_range, D_cache_hitrate, 'ro-', color='#FF0000', alpha=0.6, linewidth=1, label='D')

plt.legend(loc="lower right")
# plt.legend(loc="lower left")
# plt.title('cc')
# plt.title('spice')
plt.title('tex')
plt.show()